//
// AOC01a
//
use std::fs;

fn main() {
    // read input into array of lines
    let path = "../input";

    let contents = fs::read_to_string(path)
        .expect("Unable to find file!");

    let lines = contents.lines();

    // counters for max / current calories
    let mut max_cals: u32 = 0;
    let mut counter: u32 = 0;

    // iterate over lines
    for line in lines {
        // when an empty line is encountered, compute total calories and compare to max and reset
        // counter
        if line == "" {
            if counter > max_cals {
                max_cals = counter;
            }

            counter = 0;
        } else {
            // otherwise, add calorie amount to counter
            let cals: u32 = line.trim().parse().expect("Not a number!");
            counter = counter + cals;
        }
    }

    // print max cals
    println!("Elf with the most snacks: {}", max_cals);
}
