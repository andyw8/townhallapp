Feature: List series

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
