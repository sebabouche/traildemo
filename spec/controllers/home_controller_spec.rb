require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe "GET #index" do
    render_views

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it do
      Thing::Create.(thing: {name: "Trailblazer"})
      Thing::Create.(thing: {name: "Rails"})

      get :index
      expect(response.body).to match "Rails"
      expect(response.body).to match "Trailblazer"
    end
  end

end
