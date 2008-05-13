require File.dirname(__FILE__) + '/../spec_helper'

describe Page do
  include PageSpecHelper

  before(:each) do
    @page = Page.new
  end

  it "should be invalid without a title" do
    @page.attributes = valid_page_attributes.except(:title)
    @page.should_not be_valid
    @page.errors.on(:title).should eql("is required")
    @page.title = 'My Title'
    @page.should be_valid
  end

  it "should be invalid without a body" do
    @page.attributes = valid_page_attributes.except(:body)
    @page.should_not be_valid
    @page.errors.on(:body).should eql("is required")
    @page.body = 'My Body'
    @page.should be_valid
  end

  it "should be valid with a full set of valid attributes" do
    @page.attributes = valid_page_attributes
    @page.should be_valid
  end

end
