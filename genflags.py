#!/bin/env python3

# thanks hyfetch <3
flags = {
    "lgbtqia": "red orange yellow green blue purple".split(" "),
    "transgender": "#00d1fe #fea3e7 #ffffff #fea3e7 #00d1fe".split(" "),
    "enby": "#faf258 #ffffff #9261cc #2c2c2c".split(" "),
    "agender": "#000000 #bec3c9 #ffffff #b9f484 #ffffff #bec3c9 #000000".split(" "),
    "queer": "#b57fdd #ffffff #49821e".split(" "),
    "genderfluid": "#fe76a2 #ffffff #bf12d7 #000000 #303cbe".split(" "),
    "bisexual": "#fb0074 #af4e99 #0135ab".split(" "),
    "cisgender": "#fb0074 #0135ab".split(" "),
    "pansexual": "#ff1b90 #ffd900 #01b2fe".split(" "),
    "polysexual": "#f714ba #01d66a #1594f6".split(" "),
    "omnisexual": "#fe9ace #ff53bf #200044 #6760fe #8ea6ff".split(" "),
    "omniromantic": "#fec8e4 #fda1db #89739a #aba7fe #bfceff".split(" "),
    "gay_men": "#078d70 #98e8c1 #ffffff #7bade2 #3d1a78".split(" "),
    "lesbian": "#d52d00 #ff9c58 #ffffff #d560a6 #a80060".split(" "),
    "abrosexual": "#46d294 #a3e9ca #ffffff #f78bb3 #ee1766".split(" "),
    "asexual": "#000000 #a5a5a5 #ffffff #960085".split(" "),
    "aromantic": "#3ba740 #a8d47a #ffffff #ababab #000000".split(" "),
    "aroace": "#e28c00 #eccd00 #ffffff #62aedc #203856".split(" "),
    "bigender": "#c479a2 #eda5cd #d6c7e8 #ffffff #d6c7e8 #9ac7e8 #6d82d1".split(" "),
    "demigender": "#7f7f7f #c4c4c4 #fbff75 #ffffff #fbff75 #c4c4c4 #7f7f7f".split(" "),
    "demiboy": "#7f7f7f #c4c4c4 #9dd7ea #ffffff #9dd7ea #c4c4c4 #7f7f7f".split(" "),
    "demigirl": "#7f7f7f #c4c4c4 #fdadc8 #ffffff #fdadc8 #c4c4c4 #7f7f7f".split(" "),
    "transmasculine": "#ff8abd #cdf5fe #9aebff #74dfff #9aebff #cdf5fe #ff8abd".split(" "),
    "transfeminine": "#73deff #ffe2ee #ffb5d6 #ff8dc0 #ffb5d6 #ffe2ee #73deff".split(" "),
    "biromantic": "#8869a5 #d8a7d8 #ffffff #fdb18d #151638".split(" "),
    "genderflux": "#f47694 #f2a2b9 #cecece #7ce0f7 #3ecdf9 #fff48d".split(" "),
    "pangender": "#fff798 #fff798 #ffebfb #ffffff #ffebfb #fff798 #fff798".split(" "),
    "polyamorous": "#ffffff #fcbf00 #009fe3 #e50051 #340c46".split(" "),
    "sapphic": "#fd8ba8 #fbf2ff #c76bc5 #fdd768 #c76bc5 #fbf2ff #fd8ba8".split(" "),
}

for flag in flags:
    gradient = []
    length = len(flags[flag])
    point = 100 / length
    i = 0
    for color in flags[flag]:
        gradient.append(f"{color} {point * i:3.2f}%")
        gradient.append(f"{color} {point * (i + 1):3.2f}%")
        i += 1
    gr = ", ".join(gradient)
    print(f".{flag} {{ background: linear-gradient(to bottom, {gr}) !important; }}")
