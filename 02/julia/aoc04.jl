#
# Advent of Code 2022 Challenge Day 2 p2
#
fp = open("../input", "r")

# function to compute the score for a single round
function score_round(a::Char, b::Char)
    # add score due to shape choice
    shape_scores = Dict('X' => 1, 'Y' => 2, 'Z' => 3)

    round_total = shape_scores[b]

    # matrix of outcome scores (rows = opponent, cols = you)
    score_mat = [[3, 0, 6] [6, 3, 0] [0, 6, 3]]

    p1_shapes = Dict('A' => 1, 'B' => 2, 'C' => 3)
    p2_shapes = Dict('X' => 1, 'Y' => 2, 'Z' => 3)

    p1_ind = p1_shapes[a]
    p2_ind = p2_shapes[b]

    return round_total + score_mat[p1_ind, p2_ind]
end

# function to map determine what shape to choose to achieve the desired outcome
function choose_shape(opp_shape::Char, desired_outcome::Char)
    mapping_mat = [['Z', 'X', 'Y'] ['X', 'Y', 'Z'] ['Y', 'Z', 'X']]

    shape_inds = Dict('A' => 1, 'B' => 2, 'C' => 3)
    outcome_inds = Dict('X' => 1, 'Y' => 2, 'Z' => 3)

    shape_ind = shape_inds[opp_shape]
    outcome_ind = outcome_inds[desired_outcome]

    return mapping_mat[shape_ind, outcome_ind]
end

# iterate over entries and compute total score
total = 0

for line in readlines(fp)
    a, b = split(line) 

    my_shape = choose_shape(only(a), only(b))

    global total = total + score_round(only(a), my_shape)
end

println("Total score: " * string(total))
