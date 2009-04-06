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
    
    desc %{
      Given the name of a datetime page part, expands if that part's value is earlier 
      than @Time.now@. Accepts an optional @than@ parameter if you need to compare the
      value to something other than @Time.now@.
      
      *Usage:*
      
      <pre><code><r:if_earlier [than="April 7 2009"] part="datetime part name">...</r:if_earlier></code></pre>
    }  
    tag 'if_earlier' do |tag|
      page = tag.locals.page
      comparison = tag.attr['than'] ? DateTime.parse(tag.attr['than']) : DateTime.now
      part = page.part(tag.attr['part'])
      raise StandardTags::TagError.new("`#{tag.attr['part']}' is not a DatetimePagePart") unless part.is_a?(DatetimePagePart)
      tag.expand if part.content < comparison
    end
    
    desc %{
      Given the name of a datetime page part, expands if that part's value is later 
      than @Time.now@. Accepts an optional @than@ parameter if you need to compare the
      value to something other than @Time.now@.
      
      *Usage:*
      
      <pre><code><r:if_later [than="April 7 2009"] part="datetime part name">...</r:if_later></code></pre>
    }
    tag 'if_later' do |tag|
      page = tag.locals.page
      comparison = tag.attr['than'] ? DateTime.parse(tag.attr['than']) : DateTime.now
      part = page.part(tag.attr['part'])
      raise StandardTags::TagError.new("`#{tag.attr['part']}' is not a DatetimePagePart") unless part.is_a?(DatetimePagePart)
      tag.expand if part.content > comparison
    end

  end
end