Feature: Cast vote

  In order to change the world
  a citizen
  wants to cast a vote for a submission

  Background:
    Given I am authenticated

  Scenario: Voting for a submission
  
    Users can vote for a submission
  
    Given a series exists
    And that series has a submission "My Submission" with no votes
    When I view that series
    And I vote for "My Submission"
    Then "My Submission" should have 1 plus votes and 0 minus votes
    And I should see the notice "Your vote was recorded"

  Scenario: Voting against a submission with no votes
  
    Users can vote against a submission
  
    Given a series exists
    And that series has a submission "My Submission" with no votes
    When I view that series
    And I vote against "My Submission"
    Then "My Submission" should have 0 plus votes and 1 minus votes
    And I should see the notice "Your vote was recorded"

  Scenario: Attempting to re-vote for a submission
  
    Users cannot vote again for the same submission
  
    Given a series exists
    And that series has a submission "My Submission" with no votes
    When I view that series
    And I vote for "My Submission"
    Then "My Submission" should have 1 plus votes and 0 minus votes
    And I should not see a Vote button next to "My Submission"

  Scenario: User signs out then attempts to vote
  
    Only signed-in users can vote
  
    Given I am not signed in
    And a series exists
    And that series has a submission
    When I view that series
    Then I should not be able to vote
