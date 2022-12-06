//
// AOC 05a
//
use std::fs;
use std::collections::HashMap;

fn main() {
    let contents = fs::read_to_string("../input")
        .expect("Unable to find file!");

    let parts: Vec<&str> = contents.split("\n\n").collect();

    let mut crates = parse_crates(parts[0].to_string());
    let actions = parse_moves(parts[1].to_string());

    // apply moves to crates
    for action in actions.iter() {
        let (num_items, from, to) = action;

        // apply the move <n> times
        for _ in 1..=*num_items {
            // pop last item in "from" vec
            let item = crates.get_mut(from).map(|val| val.pop().unwrap()).unwrap();

            // push onto "to" vec
            crates.get_mut(to).map(|val| val.push(item));
        }
    }

    // print item at top of each crate
    for (k, v) in &crates {
        println!("{}: {}", k, v.last().unwrap());
    }
}

// function to parse the text with the moves to make
fn parse_moves(txt:String) -> Vec<(u8, u8, u8)> {
    // indices for items to parse from each line
    let num_idx = 1;
    let from_idx = 3;
    let to_idx = 5;

    // vector to store output
    let mut moves: Vec<(u8, u8, u8)> = vec![];

    // iterate over lines and parse move components
    // ex. "move 3 from 2 to 9" 
    for line in txt.lines() {
        let parts: Vec<&str> = line.split(' ').collect();

        let num_moves: u8 = parts[num_idx].parse().expect("not a number!");
        let from: u8 = parts[from_idx].parse().expect("not a number!");
        let to: u8 = parts[to_idx].parse().expect("not a number!");

        moves.push((num_moves, from, to));
    }

    return moves;
}

// function to parse the initial crate position diagram
fn parse_crates(txt:String) -> HashMap<u8, Vec<String>> {
    let mut crates = HashMap::new();

    // iterate over lines of crates input
    for line in txt.lines() {
        for(i, line_char) in line.chars().enumerate() {
            if line_char.is_alphabetic() {
                let crate_num:u8 = ((i as u8) + 3) / 4;

                // create vector to store crate contents, if first time encountering
                if !crates.contains_key(&crate_num) {
                    let v: Vec<String> = vec![];
                    crates.insert(crate_num, v);
                }

                // doesn't work..
                //crates[&crate_num].push(line_char.to_string());

                // add char to crate
                crates.get_mut(&crate_num).map(|val| val.push(line_char.to_string()));
            }
        }
    }

    // doesn't work (can't modify hashmap contents while iterating over them..)
    // for (crate_num, c) in crates.iter() {
    //     c.reverse();
    // }

    // create a copy of the keys so we can iterate and modify the crates
    let crate_nums: Vec<u8> = crates.keys().cloned().collect();

    // fix order of contents; in hindsight, i probably could have just pretended the front of the
    // vectors were the top of the crates..
    for crate_num in crate_nums {
        crates.get_mut(&crate_num).map(|c| c.reverse());
    }
    
    return crates
}
