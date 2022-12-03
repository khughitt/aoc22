#
# Advent of Code 2022 Challenge #4
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
  outcomeMat <- matrix(c(3, 0, 6, 6, 3, 0, 0, 6, 3), nrow = 3)

  rownames(outcomeMat) <- c("A", "B", "C")
  colnames(outcomeMat) <- c("X", "Y", "Z")

  score <- score + outcomeMat[a, b]

  score
}

# function to map from desired outcome to shape choice
chooseShape <- function(opponentShape, desiredOutcome) {
  # add score based on outcome (rows = opponent, cols = you)
  outcomeMat <- matrix(c("Z", "X", "Y", "X", "Y", "Z", "Y", "Z", "X"), nrow = 3)

  rownames(outcomeMat) <- c("A", "B", "C")
  colnames(outcomeMat) <- c("X", "Y", "Z")

  outcomeMat[opponentShape, desiredOutcome]
}

# counter to keep track of the total
total <- 0

# iterate over rows in input data and tally up score
for (line in readLines("../input")) {
  row <- unlist(strsplit(line, " "))

  oppShape <- row[1]
  myShape <- chooseShape(row[1], row[2])

  total <- total + scoreRound(oppShape, myShape)
}

sprintf("Total score: %d", total)
