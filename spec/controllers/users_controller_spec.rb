require 'spec_helper'

describe UsersController do

  let(:user) { Factory(:user) }  # This is similar to setting an @user in a before block
                                 # let(:user) makes a user method available

  shared_examples_for "finding user" do
    it "assigns user" do
      assigns(:user).should == user
    end
  end

  describe "GET index" do
    it "assigns all users as @users" do
      get :index
      assigns(:users).should_not be_nil
    end
  end

  describe "GET show" do
    before do
      get :show, :id => user.to_param
    end
    it_should_behave_like "finding user"
  end

  describe "GET new" do
    it "assigns a new user as user" do
      get :new
      assigns(:user).should_not be_nil
    end
    it 'assigns a new shipping address' do
      get :new
      assigns[:user].should have(1).shipping_addresses
    end
  end

  describe "GET edit" do
    before do
      get :edit, :id => user.to_param
    end
    it_should_behave_like "finding user"
  end

  describe "POST create" do

    describe "with valid params" do
      it "saves a newly created user" do
        lambda {
          post :create, :user => {:first_name => "Joe", :last_name => "Smith"}
        }.should change(User,:count).by(1)
      end

      it "redirects to the created user" do
        post :create, :user => {:first_name => "Joe", :last_name => "Smith"}
        response.should redirect_to(user_url(assigns(:user).id))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user as user" do
        lambda {
          post :create, :user => {}
        }.should_not change(User,:count)
        assigns(:user).should_not be_nil
        assigns(:user).should be_kind_of(User)
      end

      it "re-renders the 'new' template" do
        post :create, :user => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do

    describe "with valid params" do

      before do
        put :update, :id => user.to_param, :user => {:first_name => 'NNNNN'}
      end

      it "updates the requested user" do
        user.reload.first_name.should == "NNNNN"
      end

      it_should_behave_like "finding user"

      it "redirects to the user" do
        put :update, :id => user.to_param, :user => {:first_name => 'Peter'}
        response.should redirect_to(user_url(user))
      end
    end

    describe "with invalid params" do
      before do
        put :update, :id => user.to_param, :user => {:first_name => ''}
      end

      it_should_behave_like "finding user"

      it "re-renders the 'edit' template" do
        response.should render_template("edit")
      end
    end

  end
end
