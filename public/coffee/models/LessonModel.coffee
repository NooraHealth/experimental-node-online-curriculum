App = require '../App.coffee'

class LessonModel
  constructor: ()->
    @.contentEndpoint = "http://noorahealthcontent.noorahealth.org/NooraHealthContent/"

  lessons: ()->
    return [
      {title: "One", image: "Image/Pulse.jpeg" },
      {title: "Two" , image: "Image/Hygiene.jpg"},
      {title: "Three" , image: "Image/medication.jpeg"}
    ]

model = new LessonModel()
module.exports = model
