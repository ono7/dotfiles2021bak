showNumbers(10)

function showNumbers(limit) {
  for (let i = 0; i < limit; i++) {
    // if (i % 2 === 0) console.log("EVEN", i)
    // else console.log("ODD", i)
    const message = (i % 2 === 0) ? "EVEN" : "ODD"
    console.log(i, message)
  }
}
