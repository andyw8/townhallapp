Feature: Featured submission

  We display a random submission which the user has not voted on.

  Background:

    Given I am authenticated
    And a series exists

  Scenario: Message for a series where I have voted for all the submissions
   Given a submission exists for that series
    And I have voted for that submission
    When I view that series
    Then I should see a message "You have voted on all the submissions in this series"

  Scenario: Message for a series a series with no submissions
    When I view that series
    Then I should not see a featured submission

  Scenario: A series with one submission, which I haven't voted on
    And that series has a submission "Submission 1"
    When I view that series
    Then the featured submission should be "Submission 1"

  Scenario: A series with two submissions, one of which I've voted on
  
    The featured submission should not one which the user has already voted on
  
    Given that series has a submission "Submission 1"
    And that series has a submission "Submission 2"
    And I have voted on the submission "Submission 2" in that series
    When I view that series
    Then the featured submission should be "Submission 1"

  Scenario: A series with one submission, which I've voted on
     And that series has a submission "Submission 1"
     And I have voted on that submission
     When I view that series
     Then I should not see a featured submission
     But I should see a message that I have voted on all the submissions

  Scenario: A series with two submissions, none of which I've voted on
    And that series has a submission "Submission 1"
    And that series has a submission "Submission 2"
    And the next random submission will be "Submission 2"
    When I view that series
    # Then the featured submission should be "Submission 2"
