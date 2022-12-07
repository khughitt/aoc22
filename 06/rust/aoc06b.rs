//
// AOC 06b
//
use std::fs;
use std::collections::HashSet;

fn main() {
    let contents = fs::read_to_string("../input")
        .expect("File not found!");

    // signal size
    let signal_size = 14;

    // indices for window start/end
    let mut i = 0;
    let mut j = signal_size;

    // length of data stream? (assuming ascii for now..)
    let stream_len = contents.trim().len();

    while j <= stream_len {
        // get window substring
        let window: String = contents.chars().skip(i).take(signal_size).collect();

        // create a set and add characters in window one-by-one, counting each unique character
        let mut chars = HashSet::new();

        let mut counter: usize = 0;

        for c in window.chars() {
            if !chars.contains(&c) {
                chars.insert(c);
                counter += 1;
            } else {

            }
        }

        // if the number of elements in the resulting set is the size of the signal, then a match
        // has been made
        if counter == signal_size {
            break
        }

        i += 1;
        j += 1;
    }

    println!("Solution: {}", j)
}
