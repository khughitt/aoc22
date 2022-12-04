//
// AOC 4b
//
use std::fs;
use std::collections::HashSet;

fn main() {
    let contents = fs::read_to_string("../input")
        .expect("Unable to find file!");

    let mut counter = 0;

    for line in contents.lines() {
        // parse section ranges for each elf
        let mut elves = line.split(',');

        let elf1 = elves.next().unwrap();
        let elf2 = elves.next().unwrap();

        let e1_strs: Vec<&str> = elf1.split('-').collect();
        let e2_strs: Vec<&str> = elf2.split('-').collect();

        // convert string bounds to integers
        let e1_start: u16 = e1_strs[0].parse().expect("not a number!");
        let e1_end: u16 = e1_strs[1].parse().expect("not a number!");
        let e2_start: u16 = e2_strs[0].parse().expect("not a number!");
        let e2_end: u16 = e2_strs[1].parse().expect("not a number!");

        // generate vector representations of ranges
        let e1_range = (e1_start..e1_end + 1).collect::<Vec<u16>>();
        let e2_range = (e2_start..e2_end + 1).collect::<Vec<u16>>();
        
        // doesn't work..
        let e1_set:HashSet<u16> = e1_range.into_iter().collect();
        let e2_set:HashSet<u16> = e2_range.into_iter().collect();

        let intersection = e1_set.intersection(&e2_set).collect::<Vec<_>>();

        if intersection.len() > 0 {
            counter = counter + 1;
        }
    }

    // print final count
    println!("Total: {}", counter);
}
