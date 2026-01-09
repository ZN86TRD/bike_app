class Post < ApplicationRecord

    belongs_to :user
    has_many :post_comments, dependent: :destroy
    has_one_attached :image
    validates :title, presence: true
    validates :body, presence: true


    def get_image
        unless image.attached?
          file_path = Rails.root.join('app/assets/images/no_image.jpg')
          image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
        end
        image
    end

    def self.ransackable_attributes(auth_object = nil)
      ["title", "body"] # 検索対象カラムの指定
    end
  
    def self.ransackable_associations(auth_object = nil)
      ["user"] # 投稿者の名前で検索する場合のやつ
    end
end
