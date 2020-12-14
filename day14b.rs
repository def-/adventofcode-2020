extern crate regex;

use std::{io, io::prelude::*};
use regex::Regex;
use std::collections::HashMap;

fn f(mut res: &mut HashMap<usize, i64>, float: &Vec<usize>, val: i64, addr: usize, i: usize) {
    if i >= float.len() {
        res.insert(addr, val);
    } else {
        f(&mut res, &float, val, addr | float[i], i + 1);
        f(&mut res, &float, val, addr & !float[i], i + 1);
    }
}

fn main() {
    let rmask = Regex::new(r"mask = ([0-9X]+)").unwrap();
    let rmem = Regex::new(r"mem\[([0-9]+)\] = ([0-9]+)").unwrap();
    let mut set = 0_usize;
    let mut float = Vec::new();
    let mut res: HashMap<usize, i64> = HashMap::new();
    for l in io::stdin().lock().lines() {
        let line = l.unwrap();
        if rmask.is_match(&line) {
            let m = rmask.captures(&line).unwrap();
            set = 0_usize;
            float.clear();
            for (i, c) in m[1].chars().enumerate() {
                let b = 1 << (35 - i);
                if c == '1' {
                    set |= b;
                } else if c == 'X' {
                    float.push(b);
                }
            }
        } else if rmem.is_match(&line) {
            let m = rmem.captures(&line).unwrap();
            let mut addr = m[1].parse::<usize>().unwrap();
            let val = m[2].parse::<i64>().unwrap();
            addr |= set;
            f(&mut res, &float, val, addr, 0);
        }
    }
    println!("{}", res.values().sum::<i64>());
}
