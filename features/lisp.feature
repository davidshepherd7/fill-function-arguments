Feature: Fill lisp functions
  Background:
    Given I clear the buffer
    Given I turn on emacs-lisp-mode
    When I set fill-function-arguments-first-argument-same-line to t
    When I set fill-function-arguments-second-argument-same-line to t
    When I set fill-function-arguments-argument-separator to " "
    When I set fill-function-arguments-last-argument-same-line to t

  @lisp
  Scenario: to single line lisp function
    When I insert:
    """
    (and t
         t
         foo)
    """
    When I place the cursor after "and"
    When I call "fill-function-arguments-dwim"
    Then I should see "(and t t foo)"

  @lisp
  Scenario: to multi line lisp function
    When I insert "(and t t foo)"
    When I place the cursor after "and"
    When I call "fill-function-arguments-dwim"
    Then I should see pattern "(and t$"
    Then I should see pattern "t$"
    Then I should see pattern "foo)$"
