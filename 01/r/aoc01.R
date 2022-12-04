#
# AOC01a/b
#
txt <- readr::read_file('../input')

elf_strs <- unlist(strsplit(txt, "\n\n"))

elf_totals <- unlist(lapply(strsplit(unlist(elf_strs), "\n"), function(x) {
  sum(as.numeric(x))
}))

# part 1
max(elf_totals)

# part 2
sum(sort(elf_totals, TRUE)[1:3])
