Feature: Cast vote

  In order to change the world
  a citizen
  wants to cast a vote for a submission

  Background:
    Given I am authenticated

  Scenario: User signs out then attempts to vote
    Given I have signed out
    And a series exists
    And that series has a submission "My Submission" with no votes
    When I view that series
    Then I should not see any vote buttons

  Scenario: Voting for a submission with no votes
    Given a series exists
    And that series has a submission "My Submission" with no votes
    When I view that series
    And I click the "Vote For" button next to "My Submission"
    Then I should see "My Submission" with 1 plus votes and 0 minus votes
    And I should see "Your vote was recorded"

  Scenario: Attempting to re-vote for a submission
    Given a series exists
    And that series has a submission "My Submission" with no votes
    When I view that series
    And I click the "Vote For" button next to "My Submission"
    Then I should see "My Submission" with 1 plus votes and 0 minus votes
    And I should not see a Vote button next to "My Submission"

  Scenario: Voting against a submission with series votes
    Given a series exists
    And that series has a submission "My Submission" with no votes
    When I view that series
    And I click the "Vote Against" button next to "My Submission"
    Then I should see "My Submission" with 0 plus votes and 1 minus votes
    And I should see "Your vote was recorded"
