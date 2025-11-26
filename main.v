import rand

type Smol_blob = u32
type Big_blob = []Smol_blob

const mask_stat        := u32(0b11111111111111111111111111111111)
const mask_health      := u32(0b11111000000000000000000000000000)
const mask_hunger      := u32(0b00000111000000000000000000000000)
const mask_happiness   := u32(0b00000000111110000000000000000000)
const mask_energy      := u32(0b00000000000001110000000000000000)
const mask_loyalty     := u32(0b00000000000000001110000000000000)
const mask_speed       := u32(0b00000000000000000001100000000000)
const mask_force       := u32(0b00000000000000000000011000000000)
const mask_job         := u32(0b00000000000000000000000111000000)
const mask_personality := u32(0b00000000000000000000000000111111)

fn (b Smol_blob) health      () u32 {return (b & mask_health)      >> 27}
fn (b Smol_blob) hunger      () u32 {return (b & mask_hunger)      >> 24}
fn (b Smol_blob) happiness   () u32 {return (b & mask_happiness)   >> 19}
fn (b Smol_blob) energy      () u32 {return (b & mask_energy)      >> 16}
fn (b Smol_blob) loyalty     () u32 {return (b & mask_loyalty)     >> 13}
fn (b Smol_blob) speed       () u32 {return (b & mask_speed)       >> 11}
fn (b Smol_blob) force       () u32 {return (b & mask_force)       >> 9}
fn (b Smol_blob) job         () u32 {return (b & mask_job)         >> 6}
fn (b Smol_blob) personality () u32 {return (b & mask_personality) >> 0}

fn (b Big_blob) health       () u32 {
    mut av := u32(0)
    for i in b {
        av += i.health()
    }
    return av / u32(b.len)
}
fn (b Big_blob) hunger       () u32 {
    mut av := u32(0)
    for i in b {
        av += i.hunger()
    }
    return av / u32(b.len)
}
fn (b Big_blob) happiness    () u32 {
    mut av := u32(0)
    for i in b {
        av += i.happiness()
    }
    return av / u32(b.len)
}
fn (b Big_blob) energy       () u32 {
    mut av := u32(0)
    for i in b {
        av += i.energy()
    }
    return av / u32(b.len)
}
fn (b Big_blob) loyalty      () u32 {
    mut av := u32(0)
    for i in b {
        av += i.loyalty()
    }
    return av / u32(b.len)
}
fn (b Big_blob) speed       () u32 {
    mut av := u32(0)
    for i in b {
        av += i.speed()
    }
    return av / u32(b.len)
}
fn (b Big_blob) force       () u32 {
    mut av := u32(0)
    for i in b {
        av += i.force()
    }
    return av / u32(b.len)
}
fn (b Big_blob) job         () u32 {
    mut av := u32(0)
    for i in b {
        av += i.job()
    }
    return av / u32(b.len)
}
fn (b Big_blob) personality () u32 {
    mut av := u32(0)
    for i in b {
        av += i.personality()
    }
    return av / u32(b.len)
}

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

    random_big_blob := Big_blob( []Smol_blob{len:100_000_000, init:Smol_blob(rand.u32() + u32(index - index))} )
    println("random_big_blob.health      : ${random_big_blob.health()}")
    println("random_big_blob.hunger      : ${random_big_blob.hunger()}")
    println("random_big_blob.happiness   : ${random_big_blob.happiness()}")
    println("random_big_blob.energy      : ${random_big_blob.energy()}")
    println("random_big_blob.loyalty     : ${random_big_blob.loyalty()}")
    println("random_big_blob.speed       : ${random_big_blob.speed()}")
    println("random_big_blob.force       : ${random_big_blob.force()}")
    println("random_big_blob.job         : ${random_big_blob.job()}")
    println("random_big_blob.personality : ${random_big_blob.personality()}")
}
