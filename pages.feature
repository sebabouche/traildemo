Feature: Visit static pages
  As a visitor
  I want to visit static pages
  So that I can understand what this app is about
  Scenario: Visitor visits the homepage
    Given I'm a "visitor"
    When I visit the "home"
    Then I can read the "headline" and "bodycopy"
