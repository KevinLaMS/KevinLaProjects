package main

import "fmt"

func main() {
    var total uint64 = 0
    for i := 0; i < 100000000; i++ {
        total += uint64(i)
    }
    fmt.Println("Go total:", total)
}