FamousEngine = require 'famous/core/FamousEngine'
Camera = require 'famous/components/Camera'
Header = require './Header.coffee'

FamousEngine.init()

scene = FamousEngine.createScene "body"

#camera for perspective
camera = new Camera scene
camera.setDepth 1000

header = new Header()
scene.addChild header

