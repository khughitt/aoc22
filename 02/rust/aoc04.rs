//
// AOC 2b
//
use std::fs;
use std::collections::HashMap;

// function to determine score based on recorded shape combinations
fn score_round(a:char, b:char) -> u32 {
    // create a dict with the scores based on my shape choice
    let shape_scores = HashMap::from([
        ('X', 1),
        ('Y', 2),
        ('Z', 3),
    ]);

    // score based on my shape choice?
    let mut score:u32 = shape_scores[&b];

    // add points based on who won (the lazy way..)

    // opp: "rock"
    if a == 'A' {
        // me: "rock"
        if b == 'X' {
            score = score + 3;
        // me: "paper"
        } else if b == 'Y' {
            score = score + 6;
        // me: "scissors"
        } else {
            score = score + 0;
        }

    // opp: "paper"
    } else if a == 'B' {
        // me: "rock"
        if b == 'X' {
            score = score + 0;
        // me: "paper"
        } else if b == 'Y' {
            score = score + 3;
        // me: "scissors"
        } else {
            score = score + 6;
        }

    // opp: "scissors"
    } else {
        // me: "rock"
        if b == 'X' {
            score = score + 6;
        // me: "paper"
        } else if b == 'Y' {
            score = score + 0;
        // me: "scissors"
        } else {
            score = score + 3;
        }
    }

    return score;
}

// function to determine shape to choose based on opponent choice and desired outcome
fn choose_shape(opp_shape:char, outcome:char) -> char {
    // opp: "rock"
    let shape;

    if opp_shape == 'A' {
        if outcome == 'X' {
            shape = 'Z';
        } else if outcome == 'Y' {
            shape = 'X';
        } else {
            shape = 'Y';
        }
    // opp: "paper"
    } else if opp_shape == 'B' {
        if outcome == 'X' {
            shape = 'X';
        } else if outcome == 'Y' {
            shape = 'Y';
        } else {
            shape = 'Z';
        }
    // opp: "scissors"
    } else {
        if outcome == 'X' {
            shape = 'Y';
        } else if outcome == 'Y' {
            shape = 'Z';
        } else {
            shape = 'X';
        }
    }

    return shape;
}


fn main() {
    // read input
    let contents = fs::read_to_string("../input")
        .expect("Unable to find file!");

    let lines = contents.lines();

    // counter for total score
    let mut total_score = 0;

    // iterate over input entries and compute estimated score
    for line in lines {
        //println!("{}", line);
       
        //let mut iter = "A few words".split_whitespace();
        let parts: Vec<&str> = line.split(' ').collect();

        // get row vals as chars
        let opp_shape = parts[0].chars().next().expect("unexpected empty string!");
        let desired_outcome = parts[1].chars().next().expect("unexpected empty string!");

        let my_shape = choose_shape(opp_shape, desired_outcome);

        total_score = total_score + score_round(opp_shape, my_shape);
    }
    println!("{}", total_score);
}
