Color = require 'famous/utilities/Color'

class App

  constructor: ()->
    @.COLORS = [
      new Color('yellow'),
      new Color('red'),
      new Color('blue'),
      new Color('green'),
      new Color('grey')
    ]
    @.NUM_SPHERES = 5

    @.CHAOS = 0
    @.ORDERED = 1
    @.SYNCHRONIZED = 2

    @.DANCES = [
      @.CHAOS, @.ORDERED, @.SYNCHRONIZED
    ]

    @.DANCE_NUMBER = 0
    @.switchChoreography()
    
  switchChoreography: ()->
    @.CHOREOGRAPHY = @.DANCES[@.DANCE_NUMBER]
    @.DANCE_NUMBER = @.DANCE_NUMBER++ %% @.DANCES.length

app = new App()

module.exports = app
