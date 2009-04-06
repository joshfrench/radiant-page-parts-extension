require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::PagePartsController do
  dataset :users
  
  before do
    login_as :admin
  end
  
  it "should render a partial for the subclass" do
    xhr :post, :create, :page_part => { :name => "boolean", :page_part_type => "BooleanPagePart" }
    response.should render_template('admin/page_parts/_boolean_page_part')
  end
  
  it "should assign a subclassed page part" do
    xhr :post, :create, :page_part => { :name => "boolean", :page_part_type => "BooleanPagePart" }
    attr = assigns(:page_part)
    attr.should be_kind_of(BooleanPagePart)
    attr.name.should eql('boolean')
  end
  
end