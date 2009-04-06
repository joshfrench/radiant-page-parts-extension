module PageParts
  module PagePartExtensions
    def self.included(base)
      base.class_eval do
        set_inheritance_column :page_part_type
        class_inheritable_accessor :content_column
        self.content_column = :text_content
        alias_attribute :content, :text_content
      end
      
      class << base
        # Attributes hash can include :class_name => 'PagePartDescendentName'. Returned object will be of this class.
        # If passed class is _not_ a PagePart or subclass, returned object will be a normal PagePart. If class name is
        # not a valid constant, throws an exception.
        def new(attributes={})
          attributes = HashWithIndifferentAccess.new(attributes)
          if klass_name = attributes.delete(:page_part_type) and (klass = klass_name.constantize) < PagePart
            klass.new(attributes)
          else
            super
          end
        end
        
        # When defining new PagePart subclasses, use +content+ to set storage column.
        #
        #   class BooleanPagePart < PagePart
        #     content :boolean
        #   end
        def content(type)
          self.content_column = "#{type}_content"
          alias_attribute :content, self.content_column
        end
        
        # For pretty listings
        def display_name
          self.name.titleize
        end
        
        # Filename of edit partial
        def partial_name
          if 'PagePart' == name
            'text_page_part'
          else
            name.gsub(' ', '').underscore
          end
        end
        
      end
    end
    
    def partial_name
      self.class.partial_name
    end
    
  end
end