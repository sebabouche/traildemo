require 'rails_helper'
# include Capybara::RSpecMatchers

RSpec.describe Comment::Cell, type: :cell do
  controller ThingsController

  let (:thing) do
    thing = Thing::Create.call(thing: { name: "Rails" }).model

    Comment::Create.call(comment: { body: "Excellent", weight: "0", user: { email: "zavan@trb.org" }}, id: thing.id).model
    Comment::Create.call(comment: { body: "!Well.", weight: "1", user: { email: "jonny@trb.org" }}, id: thing.id).model
    Comment::Create.call(comment: { body: "Cool stuff!", weight: "0", user: { email: "chris@trb.org" }}, id: thing.id).model
    Comment::Create.call(comment: { body: "Improving", weight: "1", user: { email: "hilz@trb.org" }}, id: thing.id).model
  end

                               

  it do
    html = concept("comment/cell/grid", thing).(:show)
    html = Capybara.string(html)

    comments = html.all(:css, comment)

    expect(comments.size).to eq(3)

    first = comment[0]
    expect(first.find(".header")).to have_content "hilz@trb.org"
  end
end 

