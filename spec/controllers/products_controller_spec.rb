require 'spec_helper'

describe ProductsController do

  describe "GET 'index'" do

    context "without parameter" do
      before do
        get :index
      end

      it 'should reply with 404' do
        response.should be_not_found        
      end

    end

    context "with :tag parameter" do

      before do
        FakeWeb.register_uri(:get, "http://www.amazon.com/rss/tag/running/popular?length=5", :body => File.open(File.join(Rails.root,'spec','fixtures','products_rss.xml')).read)
        get :index, :tag => 'running'
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

end
