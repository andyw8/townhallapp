Feature: Sign in

  Scenario: Valid credentials
  
    Given I am signed up as "user@example.com/password"
    When I sign-in with those credentials
    Then I should be signed in

  Scenario: Invalid credentials
    Given I am signed up as "user@example.com/password"
    When I sign-in as "user@example.com/hello"
    Then I should not be signed-in
    And I should be on the sign-in page
