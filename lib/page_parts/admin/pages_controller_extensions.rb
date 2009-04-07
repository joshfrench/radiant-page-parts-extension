module PageParts
  module Admin
    module PagesControllerExtensions
      def self.included(base)
        base.class_eval do
          before_filter :add_js, :only => [:new, :edit, :create, :update]
        end
      end
    
      def add_js
        @javascripts << 'prototype_extensions'
        @javascripts << 'lowpro'
        @javascripts << 'admin/DatePicker'
        @stylesheets << 'admin/page_parts'
      end
    end
  end
end