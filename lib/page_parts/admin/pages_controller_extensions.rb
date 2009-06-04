module PageParts
  module Admin
    module PagesControllerExtensions
      def self.included(base)
        base.class_eval do
          before_filter :add_js, :only => [:new, :edit, :create, :update]
          include ActionView::Helpers::TagHelper
          helper_method :render_part
        end
      end
    
      def add_js
        @javascripts << 'prototype_extensions'
        @javascripts << 'lowpro'
        @javascripts << 'admin/DatePicker'
        @stylesheets << 'admin/page_parts'
      end
      
      private
        def render_part(part,fields)
          inner = content_tag(:div, fields, :class => 'part', :id => "part-#{part.name.to_slug}")
          content_tag(:div, inner, :class => 'page', :id => "page-#{part.name.to_slug}")
        end
    end
  end
end