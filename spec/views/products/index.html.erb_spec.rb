require 'spec_helper'

describe "products/index.html.erb" do
  before do
    assign(:products, [mock("Product", :title => "Running Shoe", :image_url => "http://image.example.com", :link => "http://example.com")])
  end
  it 'renders' do
    render
  end
end
