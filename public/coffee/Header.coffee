FamousEngine = require 'famous/core/FamousEngine'
Node = require 'famous/core/Node'
Physics = require 'famous/physics'
DOMElement = require 'famous/dom-renderables/DOMElement'
Box = require 'famous/physics/bodies/Box'
Spring = Physics.Spring
Vec3 = require 'famous/math/Vec3'
Lib = require './lib/lib.coffee'
App = require './App.coffee'
Mesh = require 'famous/webgl-renderables/Mesh'
RotationalSpring = require 'famous/physics/forces/RotationalSpring'
RotationalDrag = require 'famous/physics/forces/RotationalDrag'
Quaternion = require 'famous/math/Quaternion'

class Header extends Node
  constructor: ()->
    super
    logo = @.logo = new Logo()
    @.addChild logo

#class Logo extends Node
  #constructor: ()->

class Logo extends Node

  constructor: ()->
    super
    @.margin = 400

    @.setOrigin .5, .5, 0
      .setMountPoint .5, .5, 0
      .setAlign 0.07, .05, 0
      .setSizeMode 'absolute', 'absolute', 'relative'
      .setAbsoluteSize 70, 70
      .setProportionalSize 1, 1,  1

    @.simulation = new Physics.PhysicsEngine()
    anchor = @.anchor = new Vec3( -1, 0, 0 )
    box = @.box = new Box({mass: 100, size: [ 70, 70 , 70]})
    spring = @.spring = new Spring null , box, {
      period: 1,
      dampingRatio: 1,
      anchor: anchor
    }

    quaternion = @.quaternion = new Quaternion().fromEuler .25 * Math.PI , -1/2 * Math.PI, 0
    rotationalSpring = @.rotationalSpring = new RotationalSpring null, box, {
      period: .5,
      dampingRatio: .5,
      anchor: quaternion
    }

    rotationalDrag = @.rotationalDrag = new RotationalDrag box, {
      strength: 5,
      anchor: quaternion
    }
    
    @.simulation.add box, spring, rotationalSpring
    @.domElement = new DOMElement @ , {
      properties: {
        "color":"white"
        "width": "100%"
      }
      attributes: {
        class: "valign-wrapper z-depth-2 logo"
      }
      content: "<img src='images/NHlogo.png' class='valign align-right'/>"
    }

    @.addUIEvent "click"
    @.addUIEvent "mouseover"

  enter: ()->
    @.anchor.set 1, 0, 0
    @.quaternion.set 1, 0, 0, 0

  onReceive: (e, payload) =>
    if e == "click"
      console.log "A click has been received"
      @.enter()
      console.log @.anchor
    if e == "mouseover"
      console.log "Mouseover!"

  onUpdate:  (time) =>
    @.simulation.update time
    transform = @.simulation.getTransform @.box
    p = transform.position
    r = transform.rotation

    @.setPosition p[0], 0, 0
    @.setRotation r[0], r[1], r[2], r[3]

    FamousEngine.requestUpdateOnNextTick @
    @

module.exports = Header
