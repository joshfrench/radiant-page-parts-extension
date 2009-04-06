module PageParts
  module PagePartTags
    
    include Radiant::Taggable

    desc %{
      Given the name of a boolean page part, expands if that part's value is true.
      
      *Usage:*
      
      <pre><code><r:if_bool part="boolean part name">...</r:if_bool></code></pre>
    }
    tag 'if_bool' do |tag|
      page = tag.locals.page
      part = page.part(tag.attr['part'])
      raise StandardTags::TagError.new("`#{tag.attr['part']}' is not a BooleanPagePart") unless part.is_a?(BooleanPagePart)
      tag.expand if part.content?
    end
    
    desc %{
      Given the name of a boolean page part, expands unless that part's value is true.
      
      *Usage:*
      
      <pre><code><r:unless_bool part="boolean part name">...</r:unless_bool></code></pre>
    }
    tag 'unless_bool' do |tag|
      page = tag.locals.page
      part = page.part(tag.attr['part'])
      raise StandardTags::TagError.new("`#{tag.attr['part']}' is not a BooleanPagePart") unless part.is_a?(BooleanPagePart)
      tag.expand unless part.content?
    end

  end
end