class Post < ApplicationRecord

    belongs_to :user
    has_many :post_comments, dependent: :destroy
    has_many :favorites, dependent: :destroy
    has_one_attached :image
    validates :title, presence: true
    validates :body, presence: true
    validates :image, 
      content_type: { in: %w(image/jpeg), message: "はJPG形式でアップロードしてください" },
      size: { less_than: 5.megabytes , message: "は5MB以下にしてください" }


    def get_image
        unless image.attached?
          file_path = Rails.root.join('app/assets/images/no_image.jpg')
          image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
        end
        image
    end

    #いいね確認
    def favorited_by?(user)
      favorites.exists?(user_id: user.id)
    end

    #検索対象選定
    def self.ransackable_attributes(auth_object = nil)
      ["title", "body"] # 検索対象カラムの指定
    end
  
    def self.ransackable_associations(auth_object = nil)
      ["user"] # 投稿者の名前で検索する場合
    end

    #タイムライン機能
    def self.feed(user)
      following_ids = user.followings.pluck(:id)
      following_ids << user.id
      where(user_id: following_ids).order(created_at: :desc)
    end
end
