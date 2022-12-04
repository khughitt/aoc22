#
# AOC03a
#
fp = open("../input", "r")

# create a mapping from item symbol to priority
letters = "abcdefghijklmnopqrstuvwxyz"
letters = letters * uppercase(letters)

mapping = Dict{Char, Integer}()

i = 1

for letter in split(letters, "")
    mapping[only(letter)] = i
    
    global i = i + 1
end

# counter to keep track of priority total
total = 0

# iterate over entries
for line in readlines(fp)
    num_items = length(line)
    comp_size = Int(num_items / 2)

    c1 = Set(line[1:comp_size])
    c2 = Set(line[(comp_size + 1):end])

    common_item = first(intersect(c1, c2))

    global total = total + mapping[common_item]
end

println("Total priority: " * string(total))
