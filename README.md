# Page Parts

Content model enhancements for PageParts. Allows the storage of native DB
types (boolean, integer, string, and datetime) in addition to the standard 
text content. Provides a framework for creating richer content types through
PagePart subclasses.

## Usage

Install and run migrations. When adding new parts to pages, you will be asked
which type of part to add. Content will be stored as a native representation
(DatetimePagePart in a datetime column, &c.), allowing for advanced operations
at the DB level. Further subclasses with custom behavior can be added easily.

### Tags

New Radius tags are included for working with enhanced parts. Full references
are available in the editing screen, but these additional tags are available:

 * `if_bool`
 * `unless_bool`
 * `if_earlier`
 * `if_later`
 * `if_greater`
 * `if_less`
 * `if_equal`
 * `unless_equal`
 
The standard `date` tag is also extended to accept the name of any datetime 
page part and use that part's content as its value.

`<r:date for="datetime page part name" [format="%A, %B %d, %Y"] />`

### Creating New Subclasses

PagePart subclasses must provide their own partials for use in the editing
screen. See the partials shipped with this extension for examples.

There are two methods you should be aware of when creating new subclasses:

#### .content

This class method specifies the storage to use for this class. Options are
`:integer`, `:boolean`, `:string`, and `:datetime`. If you don't specify a
storage type, it will default to the existing `content` field, which is a text
column.

    class IntegerPagePart < PagePart
      content :integer
    end
  
#### #content_for_render
 
By default, all PagePart subclasses simply return `content.to_s` when asked to
render. Override this method to return something else.

    class ReversedPagePart < PagePart
      def content_for_render
        content.reverse
      end
    end