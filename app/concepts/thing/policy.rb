class Thing::Policy
  attr_reader :model, :user

  def initialize(user, model)
    @user, @model = user, model
  end

  def create?
    true
  end

  def signed_in?
    user.present?
  end

  def admin?
    signed_in? and user.email == "admin@trb.org"
  end
end
