class Item < ApplicationRecord

  has_many :category_items
  has_many :categories, through: :category_items
  
  mount_uploader :image, ImageUploader

  validates :title, presence: true

end
