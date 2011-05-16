Feature: Sign out

  Scenario: User signs out successfully
    Given I am signed in as "user@example.com/password"
    When I follow "Sign Out"
    Then I should be on the home page
    And should see "Signed out successfully."
    And should not see "Sign Out"