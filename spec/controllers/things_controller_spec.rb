require 'rails_helper'

RSpec.describe ThingsController, type: :controller do
  render_views

  describe "#index" do
    it do
      Thing::Create.(thing: {name: "Trailblazer"}).model
      get :index
      expect(response.body).to match "Trailblazer"
    end
  end

  describe "show" do
    let (:thing) do
      thing = Thing::Create.call(thing: { name: "Trailblazer" }).model

      Comment::Create.call(comment: { body: "Excellent", weight: "0", user: { email: "zavan@trb.org" }}, id: thing.id).model
      Comment::Create.call(comment: { body: "!Well.", weight: "1", user: { email: "jonny@trb.org" }}, id: thing.id).model
      Comment::Create.call(comment: { body: "Cool stuff!", weight: "0", user: { email: "chris@trb.org" }}, id: thing.id).model
      Comment::Create.call(comment: { body: "Improving", weight: "1", user: { email: "hilz@trb.org" }}, id: thing.id).model

      thing
    end

    it do
      get :show, id: thing.id
      res = HTMLEntities.new.decode(response.body)
      ap res
      expect(res).to match(/Trailblazer/)

      expect(res).to have_selector(:css, "input.btn[value='Créer un(e) Comment']")
      expect(res).to have_selector(".comment_user_email")
      expect(res).to have_selector(".comments .comment")
    end
  end

  describe "#new" do
    it do
      get :new
      expect(response.body).to have_selector(:css, "form #thing_name")
      expect(response.body).not_to have_selector(:css, "form #thing_name.readonly")
    end
  end

  describe "#edit" do
    let (:thing) { Thing::Create.(thing: {name: "Trailblazer"}).model }
 
    it do
      get :edit, id: thing.id
      expect(response.body).to have_selector(:css, "form #thing_name.readonly[value='Trailblazer']")
    end
  end

  describe "#create" do
    it 'redirects if valid' do
      post :create, {thing: {name: "Bad Religion"}} 
      expect(response).to redirect_to thing_path(Thing.last)
    end

    it 'renders new if invalid' do
      post :create, {thing: {name: ""}} 
      expect(response).to render_template(:new)
    end
  end

  describe "#update" do
    let (:thing) { Thing::Create.(thing: {name: "Trailblazer"}).model }

    it do
      put :update, { id: thing.id, thing: { description: "Is the best…" } }
      expect(response).to redirect_to thing_path(thing)
    end
  end
end
