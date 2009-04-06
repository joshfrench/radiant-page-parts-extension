require File.dirname(__FILE__) + '/../spec_helper'

describe PageParts::PagePartTags do
  before do
    @page = Page.new(:slug => "/", :parent_id => nil, :title => 'Home')
    @body = PagePart.new(:name => 'body', :content => 'Hello World')
    @page.parts << @body
  end

  describe "if_bool" do
    before do
      @bool = BooleanPagePart.new(:name =>  'bool', :content => true)
      @page.parts << @bool
    end

    it "should expand if part is true" do
      @page.should render('<r:if_bool part="bool">content</r:if_bool>').as('content')
    end
    
    it "should not expand if part is false" do
      @bool.content = false
      @page.should render('<r:if_bool part="bool">content</r:if_bool>').as('')
    end

    it "should throw exception if part is not a boolean" do
      @body.content = '<r:if_bool part="body">content</r:if_bool>'
      lambda {
        @page.render
      }.should raise_error(StandardTags::TagError)
    end
  end
  
  describe "if_earlier" do
    before do
      @date = DatetimePagePart.new(:name => 'date', :content => Time.now - 1.hour)
      @page.parts << @date
    end

    it "should expand if content is earlier than now" do
      @page.should render('<r:if_earlier part="date">content</r:if_earlier>').as('content')
    end

    it "should not expand if content is later than now" do
      @date.content = Time.now + 1.hour
      @page.should render('<r:if_earlier part="date">content</r:if_earlier>').as('')
    end

    it "should accept an explicit time for comparison" do
      @date.content = 2.weeks.ago
      last_week = 1.week.ago.to_s
      @page.should render("<r:if_earlier than='#{last_week}' part='date'>content</r:if_earlier>").as('content')
    end
  end
end