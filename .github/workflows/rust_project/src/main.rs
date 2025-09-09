fn main() {
    let mut total = 0u64;
    for i in 0..100_000_000 {
        total = total.wrapping_add(i);
    }
    println!("Rust total: {}", total);
}