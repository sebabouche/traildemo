require 'rails_helper'

RSpec.describe Thing::Create, type: :operation do
  # it { is_expected.to be_a_trailblazer_operation }
  # it { is_expected.to use_model Thing }

  describe "Create" do
    it "persists valid" do
      thing = Thing::Create[thing: {name: "Rails", description: "Kickass web dev"}].model

      expect(thing.persisted?).to be_truthy
      expect(thing.name).to eq('Rails')
      expect(thing.description).to eq('Kickass web dev')
    end
  end
end

