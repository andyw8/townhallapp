Feature: Skip Submission

  In order to avoid seeing a suggestion featured again which I don't care about
  As a user
  I want to mark that submission as skipped

  Skipped submissions do not count towards the votes count for a series or submission.

  Background:
    Given I am authenticated

  Scenario: Skipping a submission
    Given a series exists
    And that series has a submission "My Submission" with no votes
    When I view that series
    And I click the "Skip" button next to "My Submission"
    Then I should see "My Submission" with 0 plus votes and 0 minus votes
    And I should see "Your vote was recorded"
    And I should see a vote review "You skipped this" for that submission
    And that submission should have 0 votes
    And that series should have 0 votes
