require 'rails_helper'

require_dependency "session/operations"

RSpec.describe Session::SignUp, type: :operation do
  describe "SignUp" do
    it do
      res, op = Session::SignUp.run(user: {
        email: "selectport@trb.org",
        password: "123123",
        confirm_password: "123123",
      })

      expect(op.model.persisted?).to be_truthy
      expect(op.model.email).to eq "selectport@trb.org"
      expect(Tyrant::Authenticatable.new(op.model).digest).to eq "123123"
    end
  end
end
