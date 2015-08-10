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

class LessonController extends Node
  constructor: ()->

    #@.domElement = new DOMElement @, {

    #}


lc = new LessonController()

module.exports = lc
