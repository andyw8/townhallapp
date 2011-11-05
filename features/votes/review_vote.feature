Feature: Review vote

  In order to check how I previously voted
  As a user
  I want to see a 'vote review' for submission that I voted on

  Scenario: Guest user views a submission that no-one has voted on

    Only sign-in users can see vote reviews

    Given a submission exists
    When I view that submission's series
    Then I should not see a vote review for that submission

  Scenario: Guest user views a submission that someone has voted on

    Given a submission exists
    And a user has voted for that submission
    When I view that submission's series
    Then I should not see a vote review for that submission

  Scenario: Authenticated user views a submission someone else has voted on

    Authenticated users should not see vote reviews for another user's votes

    Given I am authenticated
    And a submission exists
    And another user has voted for that submission
    When I view that submission's series
    Then I should not see a vote review for that submission

  Scenario Outline: Authenticated user views a submission he has voted for

    Authenticated users should vote reviews for submissions they voted on

    Given I am authenticated
    And a submission exists
    And I have voted <position> that submission
    When I view that submission's series
    Then I should see a vote review "<message>" for that submission
    Examples:
      | position | message                |
      | for      | You voted for this     |
      | against  | You voted against this |
