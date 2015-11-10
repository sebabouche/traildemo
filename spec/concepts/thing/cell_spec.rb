require 'rails_helper'
include Capybara::RSpecMatchers

RSpec.describe Thing::Cell, type: :cell do
  controller ThingsController

  it do
    Thing::Create.(thing: {name: "Rails"}).model
    Thing::Create.(thing: {name: "Trailblazer"}).model
    html = concept("thing/cell/grid")

    expect(html).to have_selector ".col-md-4.col-sm-6 .panel.panel-default .panel-body .header a", text: "Rails" 
    expect(html).not_to have_selector ".col-md-4.col-sm-6.test .panel.panel-default .panel-body .header a", text: "Rails" 
    expect(html).to have_selector ".col-md-4.col-sm-6 .panel.panel-default .panel-body .header a", text: "Trailblazer"
  end 
end
