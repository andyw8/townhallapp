Feature: View votes

  In order to see the popularity of submission
  a citizen
  wants to see the number of votes for each submission

  Scenario: A submission with no votes
    Given a series exists
    And that series has a submission "My Submission" with 0 votes
    When I view that series
    Then I should see "My Submission (Score: 0)"

  Scenario: A submission with one vote
    Given a series exists
    And that series has a submission "My Submission" with 1 votes
    When I view that series
    Then I should see "My Submission (Score: 1)"

  Scenario: A submission with several votes
    Given a series exists
    And that series has a submission "My Submission" with 3 votes
    When I view that series
    Then I should see "My Submission (Score: 3)"
