Feature: Play a game

      a3
    a4
  a5
    b5
      c5

  

                         :a5, :a4, :a3,
                      :b5, :b4, :b3, :b2,
                    :c5, :c4, :c3, :c2, :c1,
                  :d5, :d4, :d3, :d2, :d1,
                :e5, :e4, :e3, :e2, :e1,
              :f5, :f4, :f3, :f2, :f1,
            :g5, :g4, :g3, :g2, :g1,
          :h5, :h4, :h3, :h2, :h1,
       :i5, :i4, :i3, :i2, :i1,
         :j4, :j3, :j2, :j1,
           :k3, :k2, :k1

  Scenario: Phase 1
    Given a blank board
    And the following moves:
    | piece  | position |
    | red    | d3       |
    | red    | e4       |
    | red    | f4       |
    | black  | g3       |
    | white  | g2       |

    Then I should see the board