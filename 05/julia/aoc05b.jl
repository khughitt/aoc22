#
# AOC 05a
#

# read input and split into crates / actions
function main()
    fp = open("../input")

    txt = read(fp, String)

    # parse initial crate positions and moves to make
    crates_txt, moves_txt = split(txt, "\n\n")

    crates = parse_crates(crates_txt)
    moves = parse_moves(moves_txt)

    # apply moves
    for move in moves
        for i in 1:move.num
            crate = pop!(crates[move.from])
            push!(crates[move.to], crate)
        end

        # reverse order of newly added crates (part b)
        crates[move.to][(end - move.num + 1):end] = reverse(crates[move.to][(end - move.num + 1):end])
    end

    # print top items in each crate after making all moves
    crate_nums = 1:9

    answer = ""

    for i in crate_nums
        answer *= crates[i][end]
    end

    println("Answer: " * answer)
end

# function to parse crane movements
function parse_moves(txt)
    #moves = []
    moves = NamedTuple{(:num, :from, :to), Tuple{UInt8, UInt8, UInt8}}[]

    # split input lines and drop empty line at the end
    lines = split(txt, '\n')[1:end-1]

    # indices of different components in each line
    NUM_IND = 2
    FROM_IND = 4
    TO_IND = 6

    for line in lines
        parts = split(line, ' ')

        num = parse(UInt8, parts[NUM_IND])
        from = parse(UInt8, parts[FROM_IND])
        to = parse(UInt8, parts[TO_IND])

        push!(moves, (num=num, from=from, to=to))
    end

    return moves
end

# function to parse initial crate positions
function parse_crates(txt)
    # create a dict of arrays to store crate contents
    crates = Dict{UInt8, Array{Char}}() 

    crate_nums = 1:9

    for i in crate_nums
        crates[i] = []
    end

    # iterate over lines and parse initial contents; skip last line with crate numbers
    for line in split(txt, '\n')[1:end-1]
        for num in crate_nums
            # crate column = num * 4 - 2
            i = num * 4 - 2

            if isletter(line[i])
                push!(crates[num], line[i])
            end
        end
    end

    # fix order in stacks
    for i in crate_nums
        crates[i] = reverse(crates[i])
    end

    return crates
end

main()
