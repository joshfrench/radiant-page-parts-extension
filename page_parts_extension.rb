require_dependency 'application_controller'

class PagePartsExtension < Radiant::Extension
  version "0.8.0"
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
      admin.content_types.edit.add :parts_head, 'admin/content_types/parts_head_type', :after => 'name'
      admin.content_types.edit.add :parts_body, 'admin/content_types/parts_body_type', :after => 'name'
      admin.content_types.edit.add :popup, 'admin/content_types/type_select', :after => 'description_field'
    end
    
  end
  
  def deactivate
  end

  def self.content_types_enabled?
    !!defined?(ContentTypesExtension)
  end

end
