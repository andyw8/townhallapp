Feature: Ranking

  Submissions are ranked by a calculated score. The score is not publicly shown.

  A new submission has a score of 0. A plus vote adds 1 point, and a minus vote subtracts 1 point.

  It's possible for a submission to a negative score.

  Scenario: Single plus vote
    Given a series with the submissions:
      | name         | plus votes | minus votes |
      | Submission A | 0          | 0           |
      | Submission B | 1          | 0           |
    When I view that series
    Then the submissions should be in the order:
      | Submission B |
      | Submission A |

  Scenario: Single minus votes
    Given a series with the submissions:
      | name         | plus votes | minus votes |
      | Submission A | 0          | 0           |
      | Submission B | 0          | 1           |
    When I view that series
    Then the submissions should be in the order:
      | Submission A |
      | Submission B |

  Scenario: Multiple minus votes
    Given a series with the submissions:
      | name         | plus votes | minus votes |
      | Submission A | 0          | 2           |
      | Submission B | 0          | 1           |
    When I view that series
    Then the submissions should be in the order:
      | Submission B |
      | Submission A |

  Scenario: Multiple plus votes
    Given a series with the submissions:
      | name         | plus votes | minus votes |
      | Submission A | 1          | 0           |
      | Submission B | 2          | 0           |
    When I view that series
    Then the submissions should be in the order:
      | Submission B |
      | Submission A |

  Scenario: Mix of plus and minus votes
    Given a series with the submissions:
      | name         | plus votes | minus votes |
      | Submission A | 1          | 1           |
      | Submission B | 2          | 1           |
    When I view that series
    Then the submissions should be in the order:
      | Submission B |
      | Submission A |
