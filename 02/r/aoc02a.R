#
# AOC02a
#

# function to compute the score for a single round
scoreRound <- function(a, b) {
  score <- 0

  # add score for r/p/s choice
  shapePoints <- list(
    "X" = 1,
    "Y" = 2,
    "Z" = 3
  )

  score <- score + shapePoints[[b]]

  # add score based on outcome (rows = opponent, cols = you)
  outcomeMat <- matrix(c(3, 0, 6, 6, 3, 0, 0, 6, 3), nrow=3)

  rownames(outcomeMat) <- c("A", "B", "C")
  colnames(outcomeMat) <- c("X", "Y", "Z")

  score <- score + outcomeMat[a, b]

  score
}

# counter to keep track of the total
total <- 0

# iterate over rows in input data and tally up score
for (line in readLines("../input")) {
  shapes <- unlist(strsplit(line, " "))

  total <- total + scoreRound(shapes[1], shapes[2])
}

sprintf("Total score: %d", total)
