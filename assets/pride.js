"use strict";

Array.prototype.random = function () {
  return this[Math.floor((Math.random()*this.length))];
}

const flags = ['lgbtqia', 'transgender', 'enby', 'agender', 'queer', 'genderfluid', 'bisexual', 'cisgender', 'pansexual', 'polysexual', 'omnisexual', 'omniromantic', 'gay_men', 'lesbian', 'abrosexual', 'asexual', 'aromantic', 'aroace', 'bigender', 'demigender', 'demiboy', 'demigirl', 'transmasculine', 'transfeminine', 'biromantic', 'genderflux', 'pangender', 'polyamorous', 'sapphic']

const month = new Date().getMonth();
if (month == 5) {
    const nav = document.getElementsByTagName("nav")[0];
    const flag = flags.random();
    nav.classList.add(flag);

    for (let child of nav.children) {
        child.classList.add("pride");
    }

    let last = nav.children[nav.children.length - 1];
    last.style.display = "block";
    last.setAttribute("href", `https://lgbtqia.fandom.com/wiki/${flag}`);
}
