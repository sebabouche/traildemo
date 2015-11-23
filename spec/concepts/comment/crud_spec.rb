require 'rails_helper'

RSpec.describe Comment do
  let (:thing) { Thing::Create.(thing: {name: "Rails", description: "Kickass web dev"}).model }

  describe "Create" do
    it "persists valid" do
      resp, op = Comment::Create.run(
        comment: {
          body:   "Fantastic!",
          weight: "1",
          user:   { email: "jonny@trb.org" }
        },
        id: thing.id
      )

      comment = op.model

      expect(comment.persisted?).to be_truthy
      expect(comment.body).to eq("Fantastic!")
      expect(comment.weight).to eq(1)

      expect(comment.user.persisted?).to be_truthy
      expect(comment.user.email).to eq("jonny@trb.org")

      expect(op.thing).to eq(thing)
    end

    it "invalid" do
      res, op = Comment::Create.run(
        comment: {
          body:   "Fantastic!",
          weight: "1"
        }
      )

      expect(res).to be_falsey
      expect(op.errors.messages).to eq(:thing=>["doit être rempli(e)"], :"user"=>["doit être rempli(e)"] )
    end

    it "invalid email, wrong weight" do
      res, op = Comment::Create.run(
        comment: {
          user:   { email: "1337@" },
          weight: 3
        }
      )

      expect(res).to be_falsey
      expect(op.errors.messages[:"user.email"]).to eq ["n'est pas valide"]
      expect(op.errors.messages[:"weight"]).to eq ["n'est pas inclus(e) dans la liste"]
    end

    it "invalid body" do
      res, op = Comment::Create.run(
        comment: {
          body:   "Fantastic, but a little bit to long this piece of shared information is! Didn't we say that it has to be less than 16 characters? Well, maybe you should listen to what I say."
        }
      )

      expect(res).to be_falsey
      expect(op.errors.messages[:"body"]).to eq ["est trop long (pas plus de 160 caractères)"]
    end

    it do
      params = {
        id: thing.id,
        comment: {"body" => "Fantastic!", "weight"=>"1", "user"=>{"email"=>"joe@trb.org"}}
      }

      op1 = Comment::Create.call(params)
      op2 = Comment::Create.call(params)

      expect(op1.model.user.id).to eq(op2.model.user.id)
    end
  end
end
