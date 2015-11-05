require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  context "GET home" do
    
    it "renders the home page" do
      get :home
      expect(response).to be_success
      expect(response).to render_template(:home)
    end
  end
end
