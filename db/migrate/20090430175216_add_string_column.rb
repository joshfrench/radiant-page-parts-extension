class AddStringColumn < ActiveRecord::Migration
  def self.up
    add_column :page_parts, :string_content, :string
    add_index :page_parts, :string_content
  end

  def self.down
    remove_index :page_parts, :string_content
    remove_column :page_parts, :string_content
  end
end
