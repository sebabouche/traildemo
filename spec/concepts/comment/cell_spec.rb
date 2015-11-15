require 'rails_helper'
include Capybara::RSpecMatchers

RSpec.describe Comment::Cell, type: :cell do
  controller ThingsController

  let (:thing) do
    thing = Thing::Create.call(thing: { name: "Rails" }).model

    Comment::Create.call(comment: { body: "Excellent", weight: "0", user: { email: "zavan@trb.org" }}, id: thing.id).model
    Comment::Create.call(comment: { body: "!Well.", weight: "1", user: { email: "jonny@trb.org" }}, id: thing.id).model
    Comment::Create.call(comment: { body: "Cool stuff!", weight: "0", user: { email: "chris@trb.org" }}, id: thing.id).model
    Comment::Create.call(comment: { body: "Improving", weight: "1", user: { email: "hilz@trb.org" }}, id: thing.id).model

    thing
  end

                               

  it do
    html = concept("comment/cell/grid", thing).(:show)
    html = Capybara.string(html)

    comments = html.all(:css, ".comment")

    expect(comments.size).to eq(3)

    first = comments[0]
    expect(first).to have_content "hilz@trb.org"
    expect(first).to have_content "Improving"
    expect(first).not_to have_selector(".fa-heart")
    expect(first[:class]).not_to match "test"

    second = comments[1]
    expect(second).to have_content "chris@trb.org"
    expect(second).to have_content "Cool stuff!"
    expect(second).to have_selector(".fa-heart")
    expect(second[:class]).not_to match "test"

    third = comments[2]
    expect(third).to have_content "jonny@trb.org"
    expect(third).to have_content "!Well."
    expect(third).not_to have_selector(".fi-heart")
    expect(third[:class]).to match "test" # last grid item.

    # "More!"
    expect(html.find("#next a")["href"]).to eq "/things/#{thing.id}/next_comments?page=2"
    expect(html.find("#next a")["href"]).to eq next_comments_thing_path(id: thing, page: "2")
  end

  # .(:append)
  it do
    html = concept("comment/cell/grid", thing, page: 2).(:append)

    expect(html).to match /replaceWith/
    expect(html).to match /zavan@trb.org/
  end
end 

