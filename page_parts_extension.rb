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
  end

  def deactivate
  end

end
