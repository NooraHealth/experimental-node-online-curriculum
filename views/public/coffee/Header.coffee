FamousEngine = require 'famous/core/FamousEngine'
Node = require 'famous/core/Node'
Physics = require 'famous/physics'
Transitionable = require 'famous/transitions/Transitionable'
DOMElement = require 'famous/dom-renderables/DOMElement'
Box = require 'famous/physics/bodies/Box'

class Logo extends Node

  constructor: ()->
    super
    @.sizeTransitionable = new Transitionable(0)

    @.setOrigin .5, .5, 0
      .setMountPoint 0, .5, 0
      .setAlign -0.05, .05, 0
      .setSizeMode 'absolute', 'absolute', 'relative'
      .setAbsoluteSize 270, 70
      .setProportionalSize 1, 1,  1

    @.domElement = new DOMElement @ , {
      properties: {
        "color":"white"
        "width": "100%"
      }
      attributes: {
        class: "valign-wrapper z-depth-2 header"
      }
      content: "<img src='images/NHlogo.png' class='logo valign'/>"
    }

    @.addUIEvent "mouseenter"
    @.addUIEvent "mouseout"
    @.addUIEvent "mouseover"

  onReceive: (e, payload)=>
    if e == "mouseenter"
      console.log "Mouseenter"
      @.sizeTransitionable.to 1, "easeIn", 500, ()-> console.log "DONE"
      FamousEngine.requestUpdateOnNextTick @

    if e == "mouseout"
      console.log "Mouse out"
      @.sizeTransitionable.to 0, "easeOut", 500, ()-> console.log "DONE"
      FamousEngine.requestUpdateOnNextTick @


  onUpdate: ()->
    @.setAbsoluteSize @.sizeTransitionable.get()*100 + 200

module.exports = Logo
