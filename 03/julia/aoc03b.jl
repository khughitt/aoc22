#
# AOC03b
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
for group in Iterators.partition(readlines(fp), 3) |> collect
    common_item = first(intersect(Set(group[1]), Set(group[2]), Set(group[3])))

    global total = total + mapping[common_item]
end

println("Total priority: " * string(total))
