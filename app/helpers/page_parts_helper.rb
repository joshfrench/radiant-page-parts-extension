module PagePartsHelper
  def render_part(part,fields)

    # PRE 0.8.0 DP STYLING :
    if config['defaults.page_part_editing_style'] == 'list'
      name = content_tag(:strong, part.name)
      content_tag(:div, [name,fields].join, :class => 'listed-part', :id => "page-#{part.name.to_slug}")

    # STOCK RADIANT PAGE PART RENDERING :
    else
      inner = content_tag(:div, fields, :class => 'part', :id => "part-#{part.name.to_slug}")
      content_tag(:div, inner, :class => 'page', :id => "page-#{part.name.to_slug}")
    end

  end
end