#
# AOC 4b
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

    # size of overlap
    shared_size = length(intersect(e1_range, e2_range))

    if shared_size > 0
        global total += 1
    end
end

@printf("Total: %d", total)
