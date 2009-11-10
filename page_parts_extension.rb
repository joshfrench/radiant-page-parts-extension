require_dependency 'application_controller'

class PagePartsExtension < Radiant::Extension
  version "0.9"
  description "Adds rich content to page parts"
  url "http://digitalpulp.com"
  
  def activate
    PagePart.send(:include, PageParts::PagePartExtensions)
    Page.send(:include, PageParts::PageExtensions, PageParts::PagePartTags)
    Admin::PagesController.send(:include, PageParts::Admin::PagesControllerExtensions)

    ([RADIANT_ROOT] + Radiant::Extension.descendants.map(&:root)).each do |path|
      Dir["#{path}/app/models/*_page_part.rb"].each do |page_part|
         $1.camelize.constantize if page_part =~ %r{/([^/]+)\.rb}
      end
    end

    require 'page_parts/standard_tags'
    if PagePartsExtension.content_types_enabled?
      admin.content_types.edit.add :parts_head, 'admin/content_types/parts_head_type', :after => 'description'
      admin.content_types.edit.add :parts_body, 'admin/content_types/parts_body_type', :after => 'description'
      admin.content_types.edit.add :content_type_add_part_popup, 'admin/content_types/type_select', :after => 'description_field'
    end
    
    Radiant::AdminUI.class_eval { attr_accessor :page_parts }
    admin.page_parts = returning OpenStruct.new do |page_parts|
      page_parts.new = Radiant::AdminUI::RegionSet.new do |edit|
        edit.page_controls.concat %w{part_controls}
      end
    end
    
  end
  
  def deactivate
  end

  def self.content_types_enabled?
    !!defined?(ContentTypesExtension)
  end

end
