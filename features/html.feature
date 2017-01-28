Feature: Fill html tag attributes
  Background:
    Given I clear the buffer
    Given I turn on sgml-mode
    When I set fill-function-arguments-first-argument-same-line to t
    When I set fill-function-arguments-argument-separator to " "


  # html
  Scenario: to single line html
     When I insert:
    """
    <foo
    x
    y
    z
    >
    """
    When I place the cursor after "x"
    When I call "fill-function-arguments-to-single-line"
    Then I should see "<foo x y z>"


  Scenario: to multi line html
    When I insert:
    """
    <foo x y z>
    """
    When I place the cursor after "x"
    When I call "fill-function-arguments-to-multi-line"
    Then I should see pattern "<foo\s-*$"
    Then I should see pattern "x\s-*$"
    Then I should see pattern "y\s-*$"
    Then I should see pattern "z\s-*$"
    Then I should see pattern ">\s-*$"
