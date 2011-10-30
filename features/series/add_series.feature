Feature: Add Series

  In order to collect submissions
  a moderator
  wants to create a series

  Scenario: Trying to add a series if not authenticated
    Given I am on the series index page
    When I try to create a new series
    Then I should see the alert "You need to sign in or sign up before continuing."
    And I should be on the sign-in page

  Scenario: Adding a series
    Given no series exist
    And I am authenticated as "bob@microsoft.com"
    When I create a new series "How can we make things better?"
    Then I should see the notice "Successfully created series."
    And 1 series should exist
    And the series owner of "How can we make things better?" should be shown as "bob@microsoft.com"

  Scenario: Adding a series without a name
    Given no series exist
    And I am authenticated
    When I try to create a series without a name
    Then I should see the error "Name can't be blank"
    And 0 series should exist
