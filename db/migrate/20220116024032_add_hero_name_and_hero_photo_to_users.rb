# db/migrate/20220116024032_add_hero_name_and_hero_photo_to_users.rb
class AddHeroNameAndHeroPhotoToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column  :users, :first_name, :string, :default => ""
    add_column  :users, :last_name, :string, :default => ""
    add_column  :users, :avatar, :string, :default => ""
  end
end
