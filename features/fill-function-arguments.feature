Feature: Fill function arguments
  Background:
    Given I clear the buffer
    Given I turn on c++-mode

  Scenario: to single line simple
    When I insert:
    """
    foo(
      x,
      y,
      z
    )
    """
    When I place the cursor after "x"
    When I call "fill-function-arguments-to-single-line"
    Then I should see "foo(x, y, z)"
