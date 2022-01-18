class ImageListItem < ApplicationRecord
  belongs_to :image_list, :inverse_of => :image_list_items

  mount_uploader :list_image, ListImageUploader

  validates_processing_of :list_image
  validates :list_image, file_size: { less_than: 0.5.megabytes }

end
