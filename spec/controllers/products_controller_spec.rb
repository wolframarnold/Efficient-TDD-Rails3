require 'spec_helper'

describe ProductsController do

  before :all do
    FakeWeb.register_uri(:get, "http://www.amazon.com/rss/tag/running/popular?length=5", :body => File.open(File.join(Rails.root,'spec','fixtures','products_rss.xml')).read)
  end

  describe "GET 'index'" do

    before do
      get :index
    end

    it "assigns @products" do
      assigns(:products).should_not be_nil
      assigns(:products).should be_instance_of(Array)
      assigns(:products).length.should > 1
      assigns(:products).each do |p|
        p.should be_instance_of(Product)
      end
    end
  end

end
