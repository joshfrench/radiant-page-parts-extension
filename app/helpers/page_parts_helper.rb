module PagePartsHelper
  def render_part(part,fields)
    inner = content_tag(:div, fields, :class => 'part', :id => "part-#{part.name.to_slug}")
    content_tag(:div, inner, :class => 'page', :id => "page-#{part.name.to_slug}")
  end
end