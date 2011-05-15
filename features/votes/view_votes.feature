@curr
Feature: View votes

  In order to see the popularity of submission
  a citizen
  wants to see the number of votes for each submission

  Scenario: A submission with no votes
    Given a series exists
    And that series has a submission "My Submission" with 0 plus votes and 0 minus votes
    When I view that series
    Then I should see "My Submission" with 0 plus votes and 0 minus votes

  Scenario: A submission with one vote
    Given a series exists
    And that series has a submission "My Submission" with 1 plus votes and 0 minus votes
    When I view that series
    Then I should see "My Submission" with 1 plus votes and 0 minus votes

  Scenario: A submission with several votes
    Given a series exists
    And that series has a submission "My Submission" with 2 plus votes and 1 minus votes
    When I view that series
    Then I should see "My Submission" with 2 plus votes and 1 minus votes
