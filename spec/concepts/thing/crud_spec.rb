require 'rails_helper'

RSpec.describe Thing::Create, type: :operation do
  # it { is_expected.to be_a_trailblazer_operation }
  # it { is_expected.to use_model Thing }

  describe "Create" do
    it "persists valid things" do
      thing = Thing::Create.(thing: {name: "Rails", description: "Kickass web dev"}).model

      expect(thing.persisted?).to be_truthy
      expect(thing.name).to eq('Rails')
      expect(thing.description).to eq('Kickass web dev')
    end

    it 'does not persist invalid things' do
      resp, op = Thing::Create.run(thing: {name: ""})
      expect(resp).to be_falsey
      expect(op.model.persisted?).to be_falsey
      expect(op.contract.errors.to_s).to eq "{:name=>[\"doit être rempli(e)\"]}"
    end

    it 'does not persist with invalid description' do
      resp, op = Thing::Create.run(thing: {name: "Rails", description: "hi"})
      expect(resp).to equal false 
      expect(op.contract.errors.to_s).to eq "{:description=>[\"est trop court (au moins 4 caractères)\"]}" 
    end
  end

  describe "Update" do
    let (:thing) { Thing::Create.(thing: {name: "Rails", description: "Kickass web dev"}).model }

    it "persists valid thing, ignores name" do
      Thing::Update.(
        id: thing.id,
        thing: {
          name: "Lotus",
          description: "Simply better…"
        }
      )

      thing.reload
      expect(thing.name).to eq "Rails"
      expect(thing.description).to eq "Simply better…"
    end
  end
end

