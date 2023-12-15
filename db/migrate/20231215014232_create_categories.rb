# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    return if table_exists? 'categories'

    create_table :categories, id: :uuid do |t|
      t.string :name, default: '', null: false
      t.string :icon, default: '', null: false
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :categories, :name
    add_index :categories, :icon
  end
end
