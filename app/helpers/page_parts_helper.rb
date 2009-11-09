module PagePartsHelper
  def render_part(part,fields)
    name = content_tag(:div, content_tag(:label, part.name, :for => "part_#{part.name.to_slug}_content"), :class => 'page-part-name')
    content_tag(:div, [name,fields].join, :class => 'page page-part Field', :id => "page-#{part.name.to_slug}", "data-caption" => part.name.to_slug)
  end
end