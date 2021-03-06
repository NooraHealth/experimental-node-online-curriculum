FamousEngine = require 'famous/core/FamousEngine'
DOMElement = require 'famous/dom-renderables/DOMElement'
Node = require 'famous/core/Node'
Vec3 = require 'famous/math/Vec3'
Lib = require '../lib/lib.coffee'
App = require '../App.coffee'

class SpinnerNode extends Node
  constructor: ()->
    super

    @.setOrigin .5, .5, .5
      .setMountPoint .5, .5, .5
      .setAlign .5 , .5 , .5
      
    rand = Math.random()

    @.d = new Vec3 Lib.getDirection(), Lib.getDirection(), Lib.getDirection()
    @.m = new Vec3 Math.random(), Math.random(), Math.random()
    @.m.scale(.001)
    @.cross = @.d.cross(@.m)

    #determine the axis of rotation
    if rand < 0.3
      @.axis = new Vec3 1, 0 , 0
    if rand >= 0.3 and rand < 0.6
      @.axis = new Vec3 0, 1, 0
    else
      @.axis = new Vec3 0, 0, 1


    @.addUIEvent 'click'
    FamousEngine.requestUpdate(@)

  onUpdate: (time)=>

    setOrderedRotation = ()=>
      x = @.cross.x * @.axis.x * time
      y = @.cross.y * @.axis.y * time
      z = @.cross.z * @.axis.z * time
      @.setRotation x, y, z

    setChaos = ()=>
      @.setRotation @.cross.x * time, @.cross.y * time, @.cross.z * time

    setSynchronous = ()=>
      @.setRotation time * 0.001, time * 0.002, time * 0.001

    switch App.CHOREOGRAPHY
      when App.SYNCHRONIZED then setSynchronous()
      when App.CHAOS then setChaos()
      when App.ORDERED then setOrderedRotation()

    FamousEngine.requestUpdateOnNextTick @

  onReceive: (e, payload) ->
    if e == "click"
      console.log "Switching the choreography"
      App.switchChoreography()

module.exports = SpinnerNode
