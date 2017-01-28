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


  Scenario: dwim fill tags as tags
    When I insert:
    """
    <foo x y z>
    """
    When I place the cursor after "x"
    When I call "fill-function-arguments-dwim"
    Then I should see pattern "<foo\s-*$"
    Then I should see pattern "x\s-*$"
    Then I should see pattern "y\s-*$"


  Scenario: dwim fill text as text
    When I insert:
    """
    <div>
        Praesent fermentum tempor tellus.  Etiam laoreet quam sed arcu.  Nunc rutrum turpis sed pede.  Nam euismod tellus id erat.  Integer placerat tristique nisl.  Phasellus neque orci, porta a, aliquet quis, semper a, massa.  Nunc aliquet, augue nec adipiscing interdum, lacus tellus malesuada massa, quis varius mi purus non odio.
    <div>
    """
    When I go to word "fermentum"
    When I call "fill-function-arguments-dwim"
    Then I should see pattern "arcu\.$"
