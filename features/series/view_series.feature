Feature: View Series

  In order to see what other people have submitted
  a citizen
  wants to browse the submission for a particular series

  Scenario: Viewing a series with no submissions
    Given a series exists
    And no are no submissions for that series
    When I view that series
    Then I should see "There are no submissions"

  @current
  Scenario: Order of series

    Should be displayed newest first

    Given the following series:
      | name     | created     |
      | Series A | 1 month ago |
      | Series B | 1 hour ago  |
      | Series C | 1 week ago  |
    When I view the series index
    Then I should see the series in the order:
      | Series B |
      | Series C |
      | Series A |

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