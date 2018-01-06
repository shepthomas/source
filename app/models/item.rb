class Item < ApplicationRecord

  mount_uploader :image, ImageUploader
  
  validates :title, presence: true

end
