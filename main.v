import rand



fn main () {
    random_smol_blob := Smol_blob(rand.u32())
    println("random_smol_blob.health      : ${random_smol_blob.health()}")
    println("random_smol_blob.hunger      : ${random_smol_blob.hunger()}")
    println("random_smol_blob.happiness   : ${random_smol_blob.happiness()}")
    println("random_smol_blob.energy      : ${random_smol_blob.energy()}")
    println("random_smol_blob.loyalty     : ${random_smol_blob.loyalty()}")
    println("random_smol_blob.speed       : ${random_smol_blob.speed()}")
    println("random_smol_blob.force       : ${random_smol_blob.force()}")
    println("random_smol_blob.job         : ${random_smol_blob.job()}")
    println("random_smol_blob.personality : ${random_smol_blob.personality()}")

    random_big_blob := Big_blob( []Smol_blob{len:1_000_000, init:Smol_blob(rand.u32() + u32(index - index))} )
    println("random_big_blob.health      : ${random_big_blob.health()}")
    println("random_big_blob.hunger      : ${random_big_blob.hunger()}")
    println("random_big_blob.happiness   : ${random_big_blob.happiness()}")
    println("random_big_blob.energy      : ${random_big_blob.energy()}")
    println("random_big_blob.loyalty     : ${random_big_blob.loyalty()}")
    println("random_big_blob.speed       : ${random_big_blob.speed()}")
    println("random_big_blob.force       : ${random_big_blob.force()}")
    println("random_big_blob.job         : ${random_big_blob.job()}")
    println("random_big_blob.personality : ${random_big_blob.personality()}")

    mut flock_exemple := Big_blob( [Smol_blob(0b11111_111_11111_111_111_11_11_111_111111),
                                Smol_blob(0b10000_000_11111_000_000_00_00_000_000000),
                                Smol_blob(0b11111_111_00000_111_111_11_11_111_111111),
                                Smol_blob(0b10000_000_00000_000_000_00_00_000_000000),
                                Smol_blob(0b11010_101_10101_101_010_10_10_101_010101),
                                Smol_blob(0b10101_010_10101_010_101_01_01_010_101010)]
                            )
    flock_exemple.reproduce()
    println("\n")
    for i in 0..flock_exemple.len {
        println("blob n°${i} : ${flock_exemple[i]:b}")
    }
}
