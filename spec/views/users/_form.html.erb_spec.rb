require 'spec_helper'

describe 'users/_form.html.erb' do
  before do
    assign(:user, Factory.build(:user))
    render
  end

  it 'should have first_name and last_name fields' do
    rendered.should have_selector('form') do |f|
      f.should have_selector("input[name='user[first_name]']")
      f.should have_selector('input[name="user[last_name]"]')
    end
  end
end