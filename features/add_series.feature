Feature: Add Series
  In order to collect submissions
  a moderator
  wants to create a series

  Scenario: Adding a series
    Given I am on the series index page
    When I follow "New Series"
    And I fill in "Name" with "How can we make things better?"
    And I press "Create Series"
    Then I should see "Successfully created series"
    And 1 series should exist

  Scenario: Adding a series without a name
    Given I am creating a new series
    And I leave the "name" field blank
    When I press "Create Series"
    Then I should see "Name can't be blank"
    And 0 series should exist
