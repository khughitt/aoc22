//
// AOC01b
//
use std::fs;

fn main() {
    // read input into array of lines
    let path = "../input";

    let contents = fs::read_to_string(path)
        .expect("Unable to find file!");

    let lines = contents.lines();

    // counters for max / current calories
    //let mut max_cals: u32 = 0;
    let mut counter: u32 = 0;

    // vector to store elf totals
    let mut elf_totals: Vec<u32> = vec![];

    // iterate over lines
    for line in lines {
        // when an empty line is encountered, compute total calories and compare to max and reset
        // counter
        if line == "" {
            // if counter > max_cals {
            //     max_cals = counter;
            // }
            elf_totals.push(counter);

            counter = 0;
        } else {
            // otherwise, add calorie amount to counter
            let cals: u32 = line.trim().parse().expect("Not a number!");
            counter = counter + cals;
        }
    }

    // sort
    elf_totals.sort();
    elf_totals.reverse();

    // sum
    // https://doc.rust-lang.org/core/iter/trait.Iterator.html#method.fold
    //let total = elf_totals[0..3].iter().fold(0, |acc, x| acc + x);
    //
    // fn fold<B, F>(self, init: B, f: F) -> B
    // > Folds every element into an accumulator by applying an operation, returning the final
    // > result.

    // a simpler sum approach (thanks, Jonathan!)
    let total:u32 = elf_totals[0..3].iter().sum();

    // print max cals
    println!("Total calories for top 3 elves: {}", total);
}
