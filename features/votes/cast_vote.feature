Feature: Cast vote

  In order to change the world
  a citizen
  wants to cast a vote for a submission

  Scenario: Unauthenticated user votes attempts to vote
    Given a series exists
    And that series has a submission "My Submission" with 0 votes
    When I view that series
    Then I should not see any vote buttons

  Scenario: Authenticated user votes for a submission with no votes
    Given I am authenticated
    And a series exists
    And that series has a submission "My Submission" with 0 votes
    When I view that series
    And I click the vote button next to "My Submission"
    Then I should see "My Submission (1 vote)"
    And I should see "Your vote was recorded"
