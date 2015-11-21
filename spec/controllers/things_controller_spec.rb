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
      expect(response.body).to have_selector("input.email", count: 3)
    end
  end

  describe "#edit" do
    let (:thing) { Thing::Create.(thing: {name: "Trailblazer", users: [{"email"=>"joe@trb.org"}]}).model }
 
    it do
      get :edit, id: thing.id
      expect(response.body).to have_selector(:css, "form #thing_name.readonly[value='Trailblazer']")
      expect(response.body).to have_selector(:css, "#thing_users_attributes_0_email.readonly[value='joe@trb.org']")
      expect(response.body).to have_selector(:css, "#thing_users_attributes_0_remove")
      expect(response.body).to have_selector(:css, "#thing_users_attributes_1_email")
      expect(response.body).to have_selector(:css, "#thing_users_attributes_2_email")
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
      expect(response.body).to have_selector(:css, "div.alert")
      expect(response.body).to have_selector("input.email", count: 3)
    end
  end

  describe "#update" do
    let (:thing) { Thing::Create.(thing: {name: "Trailblazer"}).model }

    it do
      put :update, { id: thing.id, thing: { description: "Is the best…" } }
      expect(response).to redirect_to thing_path(thing)
    end
  end

  describe "#create_comment" do
    let (:thing) { Thing::Create.(thing: {name: "Trailblazer"}).model }
    it do
      post :create_comment, { id: thing.id, comment: { body: "That green jacket!", weight: "1", user: { email: "seuros@trb.org" } } }
      expect(flash[:notice]).to eq("Created comment for \"Trailblazer\"")
    end
  end

  describe "#next_comments" do
    let (:thing) do
      thing = Thing::Create.call(thing: { name: "Trailblazer" }).model

      Comment::Create.call(comment: { body: "Excellent", weight: "0", user: { email: "zavan@trb.org" }}, id: thing.id).model
      Comment::Create.call(comment: { body: "!Well.", weight: "1", user: { email: "jonny@trb.org" }}, id: thing.id).model
      Comment::Create.call(comment: { body: "Cool stuff!", weight: "0", user: { email: "chris@trb.org" }}, id: thing.id).model
      Comment::Create.call(comment: { body: "Improving", weight: "1", user: { email: "hilz@trb.org" }}, id: thing.id).model

      thing
    end

    it do
      xhr :get, :next_comments, id: thing.id, page: 2

      expect(response.body).to match /zavan@trb.org/
    end
  end
end
