Feature: Sign in

  Scenario: User signs in successfully
    Given I am signed up as "user@example.com/password"
    When I go to the sign-in page
    And fill in "Email" with "user@example.com"
    And fill in "Password" with "password"
    And press "Sign in"
    Then I should see "Signed in successfully."
    And should not see "Sign in"

  Scenario: User signs in with incorrect credentials
    Given I am signed up as "user@example.com/password"
    When I go to the sign-in page
    And fill in "Email" with "blah"
    And press "Sign in"
    Then I should be on the sign-in page
    And should see "Invalid email or password."
