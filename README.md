# Page Parts

Content model enhancements for PageParts. Allows the storage of native DB
types (boolean, integer, and datetime) in addition to the standard text 
content. Provides a foundation for creating richer content types through
PagePart subclasses.

## Usage

Install and run migrations. Now when adding a page part, you will be able to
specify what type. Content will be stored as a native representation
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

### Creating New Subclasses

PagePart subclasses must provide their own partials for use in the editing
screen. See the partials shipped with this extension for examples.

There are two methods you should be aware of when creating new subclasses:

#### content

This class method specifies the storage to use for this class. Options are
`:text`, `:integer`, `:boolean`, and `:datetime`. The default is `:text`.

    class IntegerPagePart < PagePart
      content :integer
    end
  
#### content_for_render
 
By default, all PagePart subclasses simply return `content.to_s` when asked to
render. Override this method to return something else.

    class ReversedPagePart < PagePart
      def content_for_render
        content.reverse
      end
    end

## TODO

 * Indexes on additional content columns
 * Calendar picker JS