require "rails_helper"

RSpec.describe Thing::Create, type: :operation do
  let(:current_user) { User::Create.call(user: {email: "fred@trb.org"}).model }
  let(:admin) { User::Create.call(user: {email: "admin@trb.org"}).model }

  
  describe "I'm the author!" do
    let(:user) { User::Create.call(user: {email: "nick@trb.org"}).model }

    it "anonymous" do
      op = Thing::Create.call(
        thing: {
          name: "Rails", 
          users: [{"email" => user.email}], 
          is_author: "1"
        },
        current_user: nil
      )
      thing = op.model

      expect(thing.users).to eq [user]
      expect(op).to be_instance_of Thing::Create
    end

    it "signed_in" do
      op = Thing::Create.call(
        thing: {
          name: "Rails",
          users: [{"email" => user.email}],
          is_author: "1"
        },
        current_user: current_user
      )
      thing = op.model

      expect(thing.users).to eq [user, current_user]
      expect(op).to be_instance_of Thing::Create::SignedIn
    end

    it "admin" do
      op = Thing::Create.call(
        thing: {
          name: "Rails",
          users: [{"email" => user.email}],
          is_author: "1"
        },
        current_user: admin
      )
      thing = op.model

      expect(thing.users).to eq [user, admin]
      expect(op).to be_instance_of Thing::Create::Admin
    end
  end
end

