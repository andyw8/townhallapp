Feature: View votes

  In order to see the popularity of submission
  a citizen
  wants to see the number of votes for each submission

  Scenario: A submission with no votes
    Given a series exists
    And that series has a submission with no votes
    When I view that series
    Then that submission should have 0 plus votes and 0 minus votes

  Scenario: A submission with one vote
    Given a series exists
    And that series has a submission with 1 plus vote and 0 minus votes
    When I view that series
    Then that submission should have 1 plus vote and 0 minus votes

  Scenario: A submission with several votes
    Given a series exists
    And that series has a submission with 2 plus votes and 1 minus vote
    When I view that series
    Then that submission should have 2 plus votes and 1 minus vote
