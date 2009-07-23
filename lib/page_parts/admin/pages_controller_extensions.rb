module PageParts
  module Admin
    module PagesControllerExtensions
      def self.included(base)
        base.class_eval do
          before_filter :add_js_and_css, :only => [:new, :edit, :create, :update]
          helper :page_parts
        end
      end
    
      def add_js_and_css
        @javascripts << 'prototype_extensions'
        @javascripts << 'lowpro'
        @javascripts << 'admin/DatePicker'
        @stylesheets << 'admin/date_picker'
      end
      
    end
  end
end