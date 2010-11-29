require 'spec_helper'

describe ProductsController do

  describe "GET 'index'" do

    before do
      get :index
    end
    it "assigns @products" do
      assigns(:products).should_not be_nil
    end
  end

end
