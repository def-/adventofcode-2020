extern crate regex;

use std::{io, io::prelude::*};
use regex::Regex;

fn main() {
    let rmask = Regex::new(r"mask = ([0-9X]+)").unwrap();
    let rmem = Regex::new(r"mem\[([0-9]+)\] = ([0-9]+)").unwrap();
    let mut set = 0_i64;
    let mut unset = i64::MAX;
    let mut array = [0_i64; 100000];
    for l in io::stdin().lock().lines() {
        let line = l.unwrap();
        if rmask.is_match(&line) {
            let m = rmask.captures(&line).unwrap();
            set = 0_i64;
            unset = i64::MAX;
            for (i, c) in m[1].chars().enumerate() {
                if c == '1' {
                    set |= 1 << (35-i);
                } else if c == '0' {
                    unset &= !(1 << (35-i));
                }
            }
        } else if rmem.is_match(&line) {
            let m = rmem.captures(&line).unwrap();
            let addr = m[1].parse::<usize>().unwrap();
            let mut val = m[2].parse::<i64>().unwrap();
            val |= set;
            val &= unset;
            array[addr] = val;
        }
    }
    println!("{}", array.iter().sum::<i64>());
}
