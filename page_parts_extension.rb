require_dependency 'application_controller'

class PagePartsExtension < Radiant::Extension
  version "0.9"
  description "Manage rich content through page parts"
  url "http://digitalpulp.com"
  
  def activate
    PagePart.send(:include, PageParts::PagePartExtensions)
    Page.send(:include, PageParts::PageExtensions, PageParts::PagePartTags)
    Admin::ResourceController.prepend_view_path 'app/views'

    paths = [Rails, *Radiant::Extension.descendants].map do |ext|
      ext.root.to_s + '/app/models'
    end
    paths.each do |path|
      Dir["#{path}/*_page_part.rb"].each do |page_part|
        if page_part =~ %r{/([^/]+)\.rb}
          require_dependency page_part
          ActiveSupport::Dependencies.explicitly_unloadable_constants << $1.camelize
        end
      end
    end

    require 'page_parts/standard_tags'
  end

  def deactivate
  end

end
