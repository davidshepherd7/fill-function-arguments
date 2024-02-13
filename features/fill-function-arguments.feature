Feature: Fill function arguments
  Background:
    Given I clear the buffer
    Given I turn on c++-mode
    Given I set fill-function-arguments-argument-separator to ","
    Given I set fill-function-arguments-trailing-separator to nil


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


  Scenario: to multi line simple
    When I insert:
    """
    foo(x, y, z)
    """
    When I place the cursor after "x"
    When I call "fill-function-arguments-to-multi-line"
    Then I should see pattern "foo($"
    Then I should see pattern "x,$"
    Then I should see pattern "y,$"
    Then I should see pattern "z$"

  Scenario: to multi line with strings
    When I insert:
    """
    foo(x, "a string, with commas", y)
    """
    When I place the cursor before "y"
    When I call "fill-function-arguments-to-multi-line"
    Then I should see "a string, with commas"

  Scenario: to multi line with nested calls
    When I insert "foo(x, g(a, b, c), y, z)"
    When I place the cursor before "y"
    When I call "fill-function-arguments-to-multi-line"
    Then I should see "g(a, b, c)"

  Scenario: to multi line trailing spaces
    When I insert:
    """
    foo( x , y,   z)
    """
    When I place the cursor after "x"
    When I call "fill-function-arguments-to-multi-line"
    Then I should see pattern "foo($"
    Then I should see pattern "x ,$"
    Then I should see pattern "y,$"
    Then I should see pattern "z$"



  # DWIM function
  Scenario: dwim to multi line
    When I insert:
    """
    foo(x, y, z)
    """
    When I place the cursor after "x"
    When I call "fill-function-arguments-dwim"
    Then I should see pattern "foo($"
    Then I should see pattern "x,$"
    Then I should see pattern "y,$"
    Then I should see pattern "z$"

  Scenario: dwim to single line
    When I insert:
    """
    foo(
      x,
      y,
      z
    )
    """
    When I place the cursor after "x"
    When I call "fill-function-arguments-dwim"
    Then I should see "foo(x, y, z)"

  Scenario: dwim fill comments
    When I insert:
    """
    // lorem ipsum aoru aouwf owu awoupna awfoudnnrsouvn oseinadn4iresarostunoaunawfonuawufn asoun afwun afoutn awfonu
    """
    When I go to word "lorem"
    When I call "fill-function-arguments-dwim"
    Then I should see pattern "awfoudnnrsouvn$"

  Scenario: dwim fill strings
    When I insert:
    """
    "lorem ipsum aoru aouwf owu awoupna awfoudnnrsouvn oseinadn4iresarostunoaunawfonuawufn asoun afwun afoutn awfonu"
    """
    When I go to word "lorem"
    When I call "fill-function-arguments-dwim"
    Then I should see pattern "awfoudnnrsouvn$"

  Scenario: dwim fill comments with prefix to justify
    When I insert:
    """
    // lorem ipsum aoru aouwf owu awoupna awfoudnnrsouvn oseinadn4iresarostunoaunawfonuawufn asoun afwun afoutn awfonu
    """
    When I go to word "lorem"
    When I call "universal-argument"
    When I call "fill-function-arguments-dwim"
    # Justifying inserts multiple spaces on the first line before the wrap
    Then I should see pattern "   awfoudnnrsouvn$"

  Scenario: to-single-line trailing commas
    When I insert:
    """
    foo(
      x,
      y,
      z,
    )
    """
    When I place the cursor after "x"
    When I call "fill-function-arguments-dwim"
    Then I should see "foo(x, y, z)"

  Scenario: to-single-line trailing complex separator
    When I set fill-function-arguments-argument-separator to ".*;"
    When I insert:
    """
    foo(
      x.*;
      y.*;
      z.*;
    )
    """
    When I place the cursor after "x"
    When I call "fill-function-arguments-dwim"
    Then I should see "foo(x.*; y.*; z)"

  Scenario: to-single-line trailing commas
    When I set fill-function-arguments-trailing-separator to t
    When I insert:
    """
    foo(x, y, z)
    """
    When I place the cursor after "x"
    When I call "fill-function-arguments-dwim"
    Then I should see pattern "foo($"
    Then I should see pattern "x,$"
    Then I should see pattern "y,$"
    Then I should see pattern "z,$"

  Scenario: indent after fill
    # Python has reasonable defaults for indentation, so use that
    Given I turn on python-mode
    Given I set python-indent-offset to 4
    Given I set fill-function-arguments-indent-after-fill to t
    When I insert:
    """
    const auto a = foo(x, y, z)
    """
    When I place the cursor after "x"
    When I call "fill-function-arguments-to-multi-line"
    Then I should see pattern "^const auto a = foo($"
    Then I should see pattern "^    x,$"
    Then I should see pattern "^    y,$"
    Then I should see pattern "^    z$"
    Then I should see pattern "^)$"
