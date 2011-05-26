Feature: Comments

  Scenario: A new submission

    When I create a new submission
    Then it should have no comments

  Scenario: Ability for a guest to comment on a submission

    Given I am not signed in
    When I view a submission
    Then I should not see a "Comment" field

  Scenario: Signed-in user comments on a submission

    Given I am authentication
    And I am viewing a submission
    When I fill in "Comment" with "This is very good"
    And I press "Post"
    Then that post should have the comment "This is very good"

  Scenario: Ordering of comments
    Pending

  Scenario: Date and time of comments
    Pending

  Scenario: Author name on comments
    Pending

  Scenario: Formatting of comments
    Pending
