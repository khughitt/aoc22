#
# AOC 06a
#
fp = open("../input", "r")
txt = read(fp, String)

# signal window size?
window_size = 4

# window start/end indices
i = 1
j = window_size

# slide window across sequence checking for unique signal
while j <= length(txt)
    if length(Set(txt[i:j])) == window_size
        println("Solution: ", j)
        break
    end

    global i += 1
    global j += 1
end
