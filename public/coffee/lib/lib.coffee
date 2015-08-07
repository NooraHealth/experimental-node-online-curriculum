lib = {
  getDirection: ()->
    if Math.random() > .5 then return 1 else return -1
}

module.exports = lib
