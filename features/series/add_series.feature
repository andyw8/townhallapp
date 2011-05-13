Feature: Add Series

  In order to collect submissions
  a moderator
  wants to create a series

  Background:
    Given no series exist

  Scenario: Trying to add a series if not authenticated
    Given I am on the series index page
    When I follow "New Series"
    Then I should see "You need to sign in or sign up before continuing."
    And I should be on the sign-in page

  Scenario: Adding a series
    Given I am authenticated as "bob@microsoft.com"
    And I am on the series index page
    When I follow "New Series"
    And I fill in "Name" with "How can we make things better?"
    And I press "Create Series"
    Then I should see "Successfully created series"
    And 1 series should exist
    And the series owner of "How can we make things better?" should be shown as "bob@microsoft.com"

  Scenario: Adding a series without a name
    Given I am authenticated
    And I am creating a new series
    And I leave the "name" field blank
    When I press "Create Series"
    Then I should see "Name can't be blank"
    And 0 series should exist
