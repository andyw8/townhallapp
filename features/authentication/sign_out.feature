Feature: Sign out

  Scenario: User signs out successfully
    Given I am signed in as "user@example.com/password"
    When I sign out
    Then I should be on the home page
    And I should see the notice "Signed out successfully."