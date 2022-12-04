#
# AOC 4a
#
using Printf

fp = open("../input", "r")

total = 0

for line in readlines(fp)
    # ex. "5-7,7-9"
    e1, e2 = split(line, ",")

    # extract range bounds
    e1_bounds = parse.(Int8, split(e1, "-"))
    e2_bounds = parse.(Int8, split(e2, "-"))

    # generate arrays for each range
    e1_range = collect(e1_bounds[1]:e1_bounds[2])
    e2_range = collect(e2_bounds[1]:e2_bounds[2])

    # size of smaller set
    min_size = min(length(e1_range), length(e2_range))

    # size of overlap
    shared_size = length(intersect(e1_range, e2_range))

    # check if one set is a subset of the other
    if shared_size == min_size
        global total += 1
    end
end

@printf("Total: %d", total)
