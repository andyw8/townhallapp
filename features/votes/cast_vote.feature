Feature: Cast vote

  In order to change the world
  a citizen
  wants to cast a vote for a submission

  Background:
    Given I am authenticated

  Scenario: Unauthenticated user votes attempts to vote
    Given I have signed out
    And a series exists
    And that series has a submission "My Submission" with 0 votes
    When I view that series
    Then I should not see any vote buttons

  Scenario: Authenticated user votes for a submission with no votes
    And a series exists
    And that series has a submission "My Submission" with 0 votes
    When I view that series
    And I click the vote button next to "My Submission"
    Then I should see "My Submission (1 vote)"
    And I should see "Your vote was recorded"

  Scenario: Authenticated user votes attempts to re-vote for a submission
    Given a series exists
    And that series has a submission "My Submission" with 0 votes
    When I view that series
    And I click the vote button next to "My Submission"
    Then I should see "My Submission (1 vote)"
    And I should not see a Vote button next to "My Submission"
