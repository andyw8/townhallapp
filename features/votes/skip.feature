Feature: Skip

  Background:
    Given I am authenticated

  Scenario: Voting against a submission with no votes
    Given a series exists
    And that series has a submission "My Submission" with no votes
    When I view that series
    And I click the "Skip" button next to "My Submission"
    Then I should see "My Submission" with 0 plus votes and 0 minus votes
    And I should see "Your vote was recorded"
    And I should see a vote review "You skipped this" for that submission
    And that submission should have 0 votes
    And that series should have 0 votes