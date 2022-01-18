# 20220117013554_create_image_lists.rb
class CreateImageLists < ActiveRecord::Migration[6.1]
  def change
    create_table :image_lists do |t|
      t.string  :title
      t.text    :caption
      t.string  :image_list_type
      t.references  :post, null: false, foreign_key: true

      t.timestamps
    end

    create_table :image_list_items do |t|
      t.string  :title
      t.text    :caption
      t.string  :list_image, default: ""
      t.references  :image_list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
