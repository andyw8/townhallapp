Feature: Post Submission

  In order to change the world
  a citizen
  wants to post a submission

  Scenario: Adding a submission
  
    Authenticated users can post a submission for a series
  
    Given I am authenticated as "james@example.com"
    And I am viewing a series
    When I post a submission "Spend more money on education"
    Then I should see the notice "Successfully created submission."
    And 1 submissions should exist for that series
    And I should see that the author of "Spend more money on education" is "james@example.com"

  @pending
  Scenario: Adding a submission without a name
  
    Submissions must have a name
  
    Given I am authenticated
    When I try to create a submission without a name
    Then I should see the error "Name can't be blank"
    And 0 submissions should exist for that series

  Scenario: Adding a submission when not authenticated
  
    Only authenticated users can post a submission
  
    Given I am not authenticated
    And I am viewing a series
    Then I should not see a New Submission link