Feature: View Series

  In order to see what other people have submitted
  a citizen
  wants to browse the submission for a particular series

  Scenario: Viewing a series with no submissions
    Given a series exists
    And no are no submissions for that series
    When I view that series
    Then I should see "There are no submissions"

  Scenario: Order of submissions when viewing a series

    Should be displayed newest first

    Given a series exists
    And the following submissions for that series:
      | name         | created     |
      | Submission A | 1 month ago |
      | Submission B | 1 hour ago  |
      | Submission C | 1 week ago  |
    When I view that series
    Then I should see the submissions in the order:
      | Submission B |
      | Submission C |
      | Submission A |

  @wip
  Scenario: Submission visibility when viewing a series

    The series should only shown submissions which are part of that series.

    Given the following submissions:
      | name         | series   |
      | Submission A | Series 1 |
      | Submission B | Series 2 |
    When I view the series "Series 1"
    Then I should see "Submission A"
    But I should not see "Submission B"