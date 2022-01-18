# db/migrate/20220116173750_create_lookup_post_types.rb
class CreateLookupPostTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :lookup_post_types do |t|
      t.string "name"

      t.timestamps
    end
  end
end
