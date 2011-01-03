Feature: Play a game

       c1  d1  e1  f1  g1  h1  i1  j1  k1            1  .   .   .   .   .   .   .   .   .
    b2  c2  d2  e2  f2  g2  h2  i2  j2  k2         2  .   .   .   .   .   .   .   .   .   .
  a3  b3  c3  d3  e3  f3  g3  h3  i3  j3  k3     3  .   .   .   .   .   .   .   .   .   .   .
    a4  b4  c4  d4  e4  f4  g4  h4  i4  j4         4  .   .   .   .   .   .   .   .   .   .   k
      a5  b5  c5  d5  e5  f5  g5  h5  i5             5  .   .   .   .   .   .   .   .   .   j
                                                          a   b   c   d   e   f   g   h   i


  Scenario: Phase 1
    Given a blank board
    And the following moves:
    | piece    | r  | r  | r  | b  | w  |
    | position | d3 | e4 | f4 | g3 | a5 |

    Then I should see the board:
   |                stacks                     |
   |     .   .   .   .   .   .   .   .   .     |
   |   .   .   .   .   .   .   .   .   .   .   |
   | .   .   .  r1   .   .  b1   .   .   .   . |
   |   .   .   .   .  r1  r1   .   .   .   .   |
   |    w1   .   .   .   .   .   .   .   .     |


  Scenario: Start of Phase 2
    Given the following board:
   |                stacks                     |
   |    w1  b1  w1  b1  w1  b1  w1  b1  w1     |
   |  w1  b1  b1  b1  b1  w1  b1  b1  b1  w1   |
   |w1  b1  w1  r1  b1  b1  b1  b1  w1  w1  w1 |
   |  w1  b1  w1  b1  r1  r1  b1  w1  w1  b1   |
   |    w1  b1  b1  b1  w1  b1  w1  w1  w1     |

    When I permform the following moves:
    | player | position_1 | position_2  |
    | white  |     a3     |     b3      |

    Then I should see the board:
   |                stacks                     |
   |    w1  b1  w1  b1  w1  b1  w1  b1  w1     |
   |  w1  b1  b1  b1  b1  w1  b1  b1  b1  w1   |
   | .  w2  w1  r1  b1  b1  b1  b1  w1  w1  w1 |
   |  w1  b1  w1  b1  r1  r1  b1  w1  w1  b1   |
   |    w1  b1  b1  b1  w1  b1  w1  w1  w1     |


  Scenario: Phase 2 - cut offs
    Given the following board:
   |                stacks                     |
   |    w1  b1  w1   .  w1  b1  w1  b1  w1     |
   |  w1  b1  b1  b1   .  w1  b1  b1  b1  w1   |
   |w1  b1  w1  r1  b1   .  b1  b1  w1  w1  w1 |
   |  w1  b1  w1  b1  r1   .  b1  w1  w1  b1   |
   |    w1  b1  b1  b1  w1  b1  w1  w1  w1     |

    When I permform the following moves:
    | player | position_1 | position_2  |
    | black  |     f5     |     e5      |

    Then I should see the board:

      |                stacks                     |
   |    w1  b1  w1   .  w1  b1  w1  b1  w1     |
   |  w1  b1  b1  b1   .  w1  b1  b1  b1  w1   |
   |w1  b1  w1  r1  b1   .  b1  b1  w1  w1  w1 |
   |  w1  b1  w1  b1  r1   .  b1  w1  w1  b1   |
   |    w1  b1  b1  b1  w1  b1  w1  w1  w1     |

#   |                stacks                     |
#   |    w1  b1  w1   .   .   .   .   .   .     |
#   |  w1  b1  b1  b1   .   .   .   .   .   .   |
#   |w1  b1  w1  r1  b1   .   .   .   .   .   . |
#   |  w1  b1  w1  b1  r1   .   .   .   .   .   |
#   |    w1  b1  b1  b1  b2   .   .   .   .     |