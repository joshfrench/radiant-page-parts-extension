class AddExtendedFields < ActiveRecord::Migration
  def self.up
    add_column :page_parts, :page_part_type, :string
    add_column :page_parts, :boolean_content, :boolean
    add_column :page_parts, :integer_content, :integer
    add_column :page_parts, :datetime_content, :datetime
    rename_column :page_parts, :content, :text_content
  end

  def self.down
    rename_column :page_parts, :text_content, :content
    remove_column :page_parts, :datetime_content
    remove_column :page_parts, :integer_content
    remove_column :page_parts, :boolean_content
    remove_column :page_parts, :page_part_type
  end
end
