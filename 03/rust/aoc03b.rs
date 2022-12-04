//
// AOC 3b
//
#![feature(iter_array_chunks)]

use std::fs;
use std::collections::HashSet;
use std::collections::HashMap;
use std::iter::FromIterator;

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
    for [elf1, elf2, elf3] in contents.lines().array_chunks() {
        // get HashSet representations of each elf's rucksack contents
        let a: HashSet<char> = elf1.chars().collect();
        let b: HashSet<char> = elf2.chars().collect();
        let c: HashSet<char> = elf3.chars().collect();

        // find common item shared by all three
        let ab = HashSet::<&char>::from_iter(a.intersection(&b));
        let bc = HashSet::<&char>::from_iter(b.intersection(&c));

        let intersection = ab.intersection(&bc).collect::<Vec<_>>();

        // add priority for misplaced item to counter
        total_priority = total_priority + priority_map[intersection[0]];
    }

    println!("Priority total: {}", total_priority);
}
