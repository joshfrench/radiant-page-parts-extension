# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class PagePartsExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/page_parts"
  
  # define_routes do |map|
  #   map.namespace :admin, :member => { :remove => :get } do |admin|
  #     admin.resources :page_parts
  #   end
  # end
  
  def activate
    # admin.tabs.add "Page Parts", "/admin/page_parts", :after => "Layouts", :visibility => [:all]
  end
  
  def deactivate
    # admin.tabs.remove "Page Parts"
  end
  
end
