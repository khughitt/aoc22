#
# Advent of Code 2022 Challenge #1
#
fp = open("../input")

# max/current counters
max_cals = 0

contents = read(fp, String)

elves = split(contents, "\n\n")

for elf in elves
    counter = 0

    for cal_str in split(rstrip(elf), "\n")
        counter = counter + parse(Int64, cal_str)
    end

    if counter > max_cals
        global max_cals = counter
    end
end

close(fp)

println("Elf with the most snacks: " * string(max_cals))
