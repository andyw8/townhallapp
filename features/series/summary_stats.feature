Feature: Summary stats

  In order to understand the level of activity in a series
  a user
  wants to see some participation statistics

  Scenario: New series
    When I create a new series
    Then the stats for that series should be:
      | users       | 0 |
      | submissions | 0 |
      | votes       | 0 |

  @wip
  Scenario: Series with a single submission
    When I create a new series
    And a user creates a submission
    And that user creates another submission
    And another user creates a submission
    Then the series stats should be:
      | users       | 0 |
      | submissions | 3 |
      | votes       | 0 |

  @wip
  Scenario: Series with a submission and votes from different users
    When I create a new series
    And a user creates a submission
    And a user votes for that submission
    And another user votes against that submission
    Then the series stats should be:
      | users       | 2 |
      | submissions | 1 |
      | votes       | 2 |
