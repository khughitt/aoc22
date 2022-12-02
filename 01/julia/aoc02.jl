#
# Advent of Code 2022 Challenge #1
#
fp = open("../input")

# max/current counters
max_cals = 0

contents = read(fp, String)

elves = split(contents, "\n\n")

elf_totals = Int[]

for elf in elves
    counter = 0

    for cal_str in split(rstrip(elf), "\n")
        counter = counter + parse(Int64, cal_str)
    end

    push!(elf_totals, counter) 
end

close(fp)

# sort totals and sum top 3
total = sum(sort(elf_totals, rev=true)[1:3])

println("Total calories for top 3 elves: " * string(total))
