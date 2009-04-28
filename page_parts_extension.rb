require_dependency 'application'

class PagePartsExtension < Radiant::Extension
  version "0.1"
  description "Adds rich content to page parts"
  url "http://digitalpulp.com"
  
  def activate
    PagePart.send(:include, PageParts::PagePartExtensions)
    Page.send(:include, PageParts::PageExtensions, PageParts::PagePartTags)
    Admin::PagesController.send(:include, PageParts::Admin::PagesControllerExtensions)
    Dir.glob(File.join(PagePartsExtension.root, %w(app models *.rb))).each { |f| require_dependency f }
    require 'page_parts/standard_tags'
    if defined? ContentTypesExtension
      admin.content_types.edit.add :parts_head, 'admin/content_types/parts_head_type', :after => 'name'
      admin.content_types.edit.add :parts_body, 'admin/content_types/parts_body_type', :after => 'name'
      admin.content_types.edit.add :popup, 'admin/content_types/type_select', :after => 'name_field' 
    end
  end
  
  def deactivate
  end
  
end
