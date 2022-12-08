#
# AOC 07a
#
using AbstractTrees

mutable struct PathNode
    const name::String
    const parent::String
    const is_dir::Bool
    size::Int
    children::Vector{PathNode}
end

AbstractTrees.children(n::PathNode) = n.children
AbstractTrees.printnode(io::IO, node::PathNode) = print(io, "#", node.name)

function main()
    # read file contents
    fp = open("../input", "r")
    entries = readlines(fp)

    # skip first two entries ("cd /" and "ls")
    entries = entries[3:end]

    # build tree recursively
    _, root = create_dir_node(entries, 1, "/")

    # iterate over nodes in tree and find directories with size <= 100000
    total = 0

    for n in collect(PreOrderDFS(root))
        if n.is_dir && n.size <= 100000
            println(n.name, ": ", n.size)
            total += n.size
        end
    end

    println("TOTAL: ", total)
end

# function to recursively construct a node for the current directory
function create_dir_node(entries::Vector{String}, i::Int, path::String, parent::String="")
    # create node to represent current dir
    n = PathNode(path, parent, true, 0, [])

    # iterate over entries passed in
    while i <= length(entries)
        entry = entries[i]
        parts = split(entry)

        i += 1

        # "cd"/"ls" position in command
        # command (starts with "$")
        if startswith(entry, '$')
            cmd = parts[2]

            if cmd == "ls"
                # <do nothing>
            elseif cmd == "cd"
                # cd <target>
                target = parts[3]

                if target == ".."
                    return i, n
                else
                    # otherwise, crease node for child dir and add to children
                    i, child_node = create_dir_node(entries, i, joinpath(path, target), path)

                    push!(n.children, child_node)

                    # update total directory size
                    n.size = n.size + child_node.size
                end
            end
        else
            # output from "ls"
            # ex. "1234 foo.txt" or "dir bar"
            if parts[1] == "dir"
                # if entry is "dir xx" don't do anything for now; these will be processed as they are
                # traversed..
                # <do nothing>
            else
                # if not a "$" command or a dir, then should be a file entry
                filesize = parse(Int64, parts[1])

                # create a file node and add to current directory node's children
                file_node = PathNode(joinpath(path, parts[2]), path, false, filesize, [])
                push!(n.children, file_node)

                # update total directory size
                n.size = n.size + filesize
            end
        end
    end

    return i, n
end

main()
