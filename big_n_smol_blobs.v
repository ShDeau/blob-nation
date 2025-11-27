type Smol_blob = u32
type Big_blob = []Smol_blob
enum Food_types {
    none
    mango
    radis
    meat
}

const mask_stat        := Smol_blob(0b11111111111111111111111111111111)
const mask_health      := Smol_blob(0b11111000000000000000000000000000)
const mask_hunger      := Smol_blob(0b00000111000000000000000000000000)
const mask_happiness   := Smol_blob(0b00000000111110000000000000000000)
const mask_energy      := Smol_blob(0b00000000000001110000000000000000)
const mask_loyalty     := Smol_blob(0b00000000000000001110000000000000)
const mask_speed       := Smol_blob(0b00000000000000000001100000000000)
const mask_force       := Smol_blob(0b00000000000000000000011000000000)
const mask_job         := Smol_blob(0b00000000000000000000000111000000)
const mask_personality := Smol_blob(0b00000000000000000000000000111111)

fn (b Smol_blob) health      () u32 {return (b & mask_health)      >> 27}
fn (b Smol_blob) hunger      () u32 {return (b & mask_hunger)      >> 24}
fn (b Smol_blob) happiness   () u32 {return (b & mask_happiness)   >> 19}
fn (b Smol_blob) energy      () u32 {return (b & mask_energy)      >> 16}
fn (b Smol_blob) loyalty     () u32 {return (b & mask_loyalty)     >> 13}
fn (b Smol_blob) speed       () u32 {return (b & mask_speed)       >> 11}
fn (b Smol_blob) force       () u32 {return (b & mask_force)       >> 9}
fn (b Smol_blob) job         () u32 {return (b & mask_job)         >> 6}
fn (b Smol_blob) personality () u32 {return (b & mask_personality) >> 0}
fn make_blob (health u32, hunger u32, happiness u32, energy u32, loyalty u32, speed u32, force u32, job u32, personality u32) Smol_blob {
    return Smol_blob(
        health        << 27
        + hunger      << 24
        + happiness   << 19
        + energy      << 16
        + loyalty     << 13
        + speed       << 11
        + force       << 9
        + job         << 6
        + personality << 0
    )
}
fn (b Smol_blob) print_smol_blob () {
    println("Smol_blob :")
    println("\thealth      : ${b.health()}")
    println("\thunger      : ${b.hunger()}")
    println("\thappiness   : ${b.happiness()}")
    println("\tenergy      : ${b.energy()}")
    println("\tloyalty     : ${b.loyalty()}")
    println("\tspeed       : ${b.speed()}")
    println("\tforce       : ${b.force()}")
    println("\tjob         : ${b.job()}")
    println("\tpersonality : ${b.personality()}")
    println("}")
}

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


fn reproduce_single_blobs (b1 &Smol_blob, b2 &Smol_blob) Smol_blob {
    unsafe{*b1 = *b1 - (*b1).energy() << 16 + ((*b1).energy() / 2) << 16}
    unsafe{*b2 = *b2 - (*b2).energy() << 16 + ((*b2).energy() / 2) << 16}
    return make_blob(
        ((*b1).health()      + (*b2).health())      / 2,
        ((*b1).hunger()      + (*b2).hunger())      / 2,
        ((*b1).happiness()   + (*b2).happiness())   / 2,
        ((*b1).energy()      + (*b2).energy())      / 2,
        ((*b1).loyalty()     + (*b2).loyalty())     / 2,
        ((*b1).speed()       + (*b2).speed())       / 2,
        ((*b1).force()       + (*b2).force())       / 2,
        ((*b1).job()         + (*b2).job())         / 2,
        ((*b1).personality() + (*b2).personality()) / 2
    )
}

fn (mut b Big_blob) reproduce () {
    mut to_reproduce := b.filter(it.happiness() > mask_stat.happiness() / 2)
    if to_reproduce.len % 2 == 1 {b.pop()}
    i_max := to_reproduce.len /2
    for i in 0..i_max {
        new_blob := reproduce_single_blobs(&to_reproduce[i], &to_reproduce[i+1])
        to_reproduce.delete_many(i, 2)
        to_reproduce.insert(i, new_blob)
    }
    b.prepend(to_reproduce)
}

fn (mut b Smol_blob) eating_smol_blob (food Food_types) {
    match food {
        .none {}
        .mango {
            new_happiness := min_u32(mask_stat.happiness(), b.happiness() + 1)
            b -= b.happiness() << 19
            b += new_happiness << 19

            new_hunger := min_u32(mask_stat.hunger(), b.hunger() + 1)
            b -= b.hunger() << 24
            b += new_hunger << 24
        }
        .radis {
            new_happiness := max_u32(0, b.happiness() - 1)
            b -= b.happiness() << 19
            b += new_happiness << 19

            new_hunger := min_u32(mask_stat.hunger(), b.hunger() + 1)
            b -= b.hunger() << 24
            b += new_hunger << 24}
        .meat {
            new_hunger := min_u32(mask_stat.hunger(), b.hunger() + 2)
            b -= b.hunger() << 24
            b += new_hunger << 24}
    }
}

fn (mut b Big_blob) eating (food Food_types) {
    for mut i in b {
        i.eating_smol_blob(food)
    }
}
