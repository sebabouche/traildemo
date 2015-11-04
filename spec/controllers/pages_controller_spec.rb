require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  context "GET home" do
    
    it "reads like a sentence (almost)" do
      get :home
      expect(response).to be_success
      expect(response).to render_template(:home)
    end
  end
end
