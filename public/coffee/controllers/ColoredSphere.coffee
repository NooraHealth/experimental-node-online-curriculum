FamousEngine = require 'famous/core/FamousEngine'
Node = require 'famous/core/Node'
Physics = require 'famous/physics'
DOMElement = require 'famous/dom-renderables/DOMElement'
Sphere = require 'famous/physics/bodies/Sphere'
Spring = Physics.Spring
Vec3 = require 'famous/math/Vec3'
Lib = require '../lib/lib.coffee'
App = require '../App.coffee'
Mesh = require 'famous/webgl-renderables/Mesh'

class ColoredSphere extends Node

  constructor: ()->
    super
    #add a physics simulation
    @.setOrigin .5, .5, 0
      .setMountPoint .5, .5, .5
      .setAlign .5 , .5 , .5
      .setSizeMode 'absolute', 'absolute', 'absolute'
      .setAbsoluteSize 50, 50, 50

    @.simulation = new Physics.PhysicsEngine()
    anchor = @.anchor = new Vec3(0,0,1)
    sphere = @.sphere = new Sphere({mass: 50, size: [200, 200, 200]})
    spring = @.spring = new Spring null , sphere, {
      period: .6,
      dampingRatio: 0.2,
      anchor: anchor
    }
    
    @.simulation.add @.sphere, @.spring

    @.mesh = new Mesh(@).setGeometry "GeodesicSphere"

    @.addUIEvent 'click'
    @.addUIEvent 'mouseover'

    FamousEngine.requestUpdate(@)

    @

  setColor: (color)->
    @.mesh.setBaseColor color
    @

  choreograph: ()=>
    direction = if Math.random() > .5 then 1 else -1
    rand = Math.random()
    differential = 200 * rand * direction
    @.anchor.set differential, 0, differential
    FamousEngine.requestUpdate(@)
    @

  onUpdate:  (time) =>
    @.simulation.update time
    transform = @.simulation.getTransform @.sphere
    p = transform.position
    r = transform.rotation
    @.setPosition p[0], p[1], p[2]

    FamousEngine.requestUpdateOnNextTick @
    @

module.exports = ColoredSphere

