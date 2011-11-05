Feature: Browse Submissions

  In order to see what other people have submitted
  a citizen
  wants to browse the submission for a particular series

  Scenario: Page and window title
    Given a series exists named "My Series"
    When I view that series
    Then the page title should be "My Series"
    And the window title should be "My Series"

  Scenario: Viewing a series with no submissions
  
    Display a notice rather than show a blank page
  
    Given a series exists
    And no are no submissions for that series
    When I view that series
    Then I should see a message "There are no submissions"

  Scenario: Submission visibility when viewing a series

    The series should only include submissions which are part of that series

    Given the following submissions and series:
      | name         | series   |
      | Submission A | Series 1 |
      | Submission B | Series 2 |
    When I view the series "Series 1"
    Then I should see only the submission "Submission A"
