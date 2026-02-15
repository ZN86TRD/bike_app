class Bike < ApplicationRecord

  belongs_to :user
  
  #バイク画像
  has_one_attached :image

  #バリデーション
  validates :maker, presence: true
  validates :name, presence: true

  #enum(bikeタイプ別に分類)
  enum bike_type: { 
    road_bike: 0, 
    cross_bike: 1, 
    mountain_bike: 2, 
    minivelo: 3, 
    gravel_bike: 4,
    other: 5 
  }


  #デフォルト画像(NoImage対応)
  def get_bike_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_fill: [width, height]).processed
  end

end
