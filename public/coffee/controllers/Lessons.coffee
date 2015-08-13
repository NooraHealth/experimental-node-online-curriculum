FamousEngine = require 'famous/core/FamousEngine'
Node = require 'famous/core/Node'
Physics = require 'famous/physics'
DOMElement = require 'famous/dom-renderables/DOMElement'
Sphere = require 'famous/physics/bodies/Sphere'
Spring = Physics.Spring
Vec3 = require 'famous/math/Vec3'
Lib = require '../lib/lib.coffee'
App = require '../App.coffee'
LessonModel = require '../models/LessonModel.coffee'

class LessonSeries extends Node
  constructor: ()->
    super

    @.setOrigin .5, .5, 0
      .setMountPoint .5, .5, .5
      .setAlign .5 , .5 , .5
      .setSizeMode 'absolute', 'absolute', 'absolute'
      .setAbsoluteSize 50, 50, 50

class LessonThumbnail extends Node
  constructor: ()->
    super

    @.setOrigin .5, .5, 0
      .setMountPoint .5, .5, .5
      .setAlign .5 , .5 , .5
      .setSizeMode 'absolute', 'absolute', 'absolute'
      .setAbsoluteSize 50, 50, 50

    @.domElement = new DOMElement @, {
     

    }


lc = new LessonThumbnail()

module.exports = lc
