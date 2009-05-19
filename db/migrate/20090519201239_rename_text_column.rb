class RenameTextColumn < ActiveRecord::Migration
  def self.up
    rename_column :page_parts, :text_content, :content
  end

  def self.down
    rename_column :page_parts, :content, :text_content
  end
end
