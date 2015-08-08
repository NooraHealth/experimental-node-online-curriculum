FamousEngine = require 'famous/core/FamousEngine'
Node = require 'famous/core/Node'
Camera = require 'famous/components/Camera'
Color = require 'famous/utilities/Color'
DOMElement = require 'famous/dom-renderables/DOMElement'
Collision = require 'famous/physics/constraints/Collision'
PointLight  = require 'famous/webgl-renderables/lights/PointLight'
AmbientLight  = require 'famous/webgl-renderables/lights/AmbientLight'
App = require './App.coffee'
SpinnerNode = require './SpinnerNode.coffee'
ColoredSphere = require './ColoredSphere.coffee'

FamousEngine.init()

scene = FamousEngine.createScene "body"

#camera for perspective
camera = new Camera scene
camera.setDepth 1000

root = scene.addChild()

#light
lightnode = scene.addChild()
  .setAlign .5, .5, .5
  .setPosition 0, 0, 250

pntLight = new PointLight lightnode
  .setColor new Color('white')

ambientColor = new Color("grey")
ambience = scene.addChild()
ambientLight = new AmbientLight ambience
  .setColor ambientColor


i = 0
while i < App.NUM_SPHERES

  spinner = new SpinnerNode()
  sphere = new ColoredSphere()
    .setColor App.COLORS[i]

  scene.addChild(spinner)
  spinner.addChild(sphere)

  sphere.choreograph()

  i++

