class Post < ApplicationRecord
  belongs_to  :lookup_post_type, :inverse_of => :posts
  belongs_to  :user, :inverse_of => :posts

  has_many    :pull_quotes,
              :inverse_of => :post,
              :dependent => :destroy

  has_many    :image_lists,
              :inverse_of => :post,
              :dependent => :destroy

  has_many    :image_list_items,
              :through => :image_lists,
              :inverse_of => :image_list,
              :dependent => :destroy

  has_rich_text :body

  validates_presence_of :title,
                        :lookup_post_type_id,
                        :description,
                        :body,
                        :user_id

  accepts_nested_attributes_for :image_lists,
    allow_destroy: true,
    :reject_if => proc { |att| att[:title].blank? && att[:list_item_type].blank? }

  accepts_nested_attributes_for :pull_quotes,
    allow_destroy: true,
    :reject_if => proc { |att| att[:quote].blank? }
end
