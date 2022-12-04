//
// AOC 3a
//
use std::fs;
use std::collections::HashSet;
use std::collections::HashMap;

fn main() {
    // read input
    let contents = fs::read_to_string("../input")
        .expect("Unable to find file!");

    // create priority mapping
    let mut priority_map = HashMap::new();

    let priorities = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".to_string();

    let mut i = 1;

    for letter in priorities.chars() {
        priority_map.insert(letter, i); 
        i = i + 1;
    }

    // counter for sum of priorities
    let mut total_priority = 0;

    // iterate over lines of file
    for line in contents.lines() {
        let num_items = line.chars().count();

        // split contents in half
        let (c1, c2) = line.split_at(num_items / 2);

        // determine which item is present in both comparments
        let a: HashSet<char> = c1.chars().collect();
        let b: HashSet<char> = c2.chars().collect();

        let intersection = a.intersection(&b).collect::<Vec<_>>();

        // add priority for misplaced item to counter
        total_priority = total_priority + priority_map[intersection[0]];
    }

    println!("Priority total: {}", total_priority);
}
