Feature: Post Submission

  In order to change the world
  a citizen
  wants to post a submission

  Scenario: Adding a submission
    Given I am authenticated
    And I am viewing the submissions for a series
    When I follow "New Submission"
    And I fill in "Name" with "Spend more money on education"
    And I press "Create Submission"
    Then I should see "Successfully created submission"
    And 1 submissions should exist for that series

  Scenario: Adding a submission without a name
    Given I am authenticated
    And I am creating a new submission for a series
    And I leave the "name" field blank
    When I press "Create Submission"
    Then I should see "Name can't be blank"
    And 0 submissions should exist for that series

  Scenario: Adding a submission when not authenticated
    Given I am not authenticated
    And I am viewing the submissions for a series
    Then I should not see "New Submission"
