module StandardTags
  desc %{
    Renders the date based on the current page (by default when it was published or created).
    The format attribute uses the same formating codes used by the Ruby @strftime@ function. By
    default it's set to @%A, %B %d, %Y@.  The @for@ attribute selects which date to render.  Valid
    options are @published_at@, @created_at@, @updated_at@, @now@, or the name of any datetime
    page part. @now@ will render the current date/time, regardless of the  page.

    *Usage:*

    <pre><code><r:date [format="%A, %B %d, %Y"] [for="published_at"]/></code></pre>
  }
  tag 'date' do |tag|
    page = tag.locals.page
    format = (tag.attr['format'] || '%A, %B %d, %Y')
    time_attr = tag.attr['for']
    date = if time_attr
      case
      when time_attr == 'now'
        Time.now
      when ['published_at', 'created_at', 'updated_at'].include?(time_attr)
        page[time_attr]
      else
        if part = page.part(time_attr)
          part.content
        else
          raise TagError, "Invalid value for 'for' attribute."
        end
      end
    else
      page.published_at || page.created_at
    end
    date.strftime(format)
  end
  
  tag 'table' do |tag|
    raise TagError, "Missing required attribute `part_name`" unless tag.attr['part_name']
    tag.locals.table = tag.locals.page.part(tag.attr['part_name']).content
  end
  
  tag 'table:head' do |tag|
    tag.locals.head = tag.locals.table.first.keys
  end

  tag 'table:head:each' do |tag|
    returning [] do |result|
      tag.locals.head.each do |head|
        tag.locals.header = head
        result << tag.expand
      end
    end
  end

  tag 'table:head:each:title' do |tag|
    tag.locals.header.to_s.titleize
  end

  tag 'table:rows' do |tag|
    tag.locals.table
  end

  tag 'table:rows:each' do |tag|
    returning [] do |result|
      tag.locals.table.each do |row|
        tag.locals.row = row
        result << tag.expand
      end
    end
  end

  tag 'table:rows:each:value' do |tag|
    tag.locals.row[tag.attr['key']]
  end

  tag 'table:columns' do |tag|
    columns = {}
    tag.locals.table.map{|x| x.values}.transpose.each_with_index{|x,i| columns[tag.locals.table.first.keys[i]] = x }
    tag.locals.columns = columns
  end

  tag 'table:columns:values' do |tag|
    tag.locals.columns[tag.attr['key']]
  end

end