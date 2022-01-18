class CreatePullQuotes < ActiveRecord::Migration[6.1]
  def change
    create_table :pull_quotes do |t|
      t.text :quote
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
