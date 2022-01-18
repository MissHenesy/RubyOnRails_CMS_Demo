class ImageList < ApplicationRecord
  belongs_to  :post, :inverse_of => :image_lists, optional: true

  has_many    :image_list_items,
              :foreign_key => :image_list_id,
              :inverse_of => :image_list,
              :dependent => :destroy

  accepts_nested_attributes_for :image_list_items,
    allow_destroy: true,
    :reject_if => proc { |att| att[:title].blank? &&
                               att[:caption].blank? &&
                               att[:list_image].blank? }

end
