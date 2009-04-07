require_dependency 'application'

class PagePartsExtension < Radiant::Extension
  version "0.1"
  description "Adds rich content to page parts"
  url "http://digitalpulp.com"
  
  def activate
    PagePart.send(:include, PageParts::PagePartExtensions)
    Page.send(:include, PageParts::PageExtensions, PageParts::PagePartTags)
    Admin::PagesController.send(:include, PageParts::PagesControllerExtensions)
    Dir.glob(File.join(PagePartsExtension.root, %w(app models *.rb))).each { |f| require_dependency f }
  end
  
  def deactivate
  end
  
end
