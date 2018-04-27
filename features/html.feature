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

  Scenario: to single line html with attribute arguments
     When I insert:
    """
    <foo
    x="one"
    y="two"
    z="three"
    >
    """
    When I place the cursor after "x"
    When I call "fill-function-arguments-to-single-line"
    Then I should see "<foo x="one" y="two" z="three">"


  Scenario: to multi line html
    When I insert:
    """
    <foo x y z>
    """
    When I place the cursor after "x"
    When I call "fill-function-arguments-to-multi-line"
    Then I should see pattern "<foo$"
    Then I should see pattern "x$"
    Then I should see pattern "y$"
    Then I should see pattern "z$"
    Then I should see pattern ">$"


  Scenario: to multi line html with attribute arguments
    When I insert:
    """
    <foo x="one" y="two" z="three">
    """
    When I place the cursor after "x"
    When I call "fill-function-arguments-to-multi-line"
    Then I should see pattern "<foo$"
    Then I should see pattern "x="one"$"
    Then I should see pattern "y="two"$"
    Then I should see pattern "z="three"$"
    Then I should see pattern ">$"


  Scenario: dwim fill tags as tags
    When I insert:
    """
    <foo x y z>
    """
    When I place the cursor after "x"
    When I call "fill-function-arguments-dwim"
    Then I should see pattern "<foo$"
    Then I should see pattern "x$"
    Then I should see pattern "y$"


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
