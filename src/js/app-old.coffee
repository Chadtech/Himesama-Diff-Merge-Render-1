# Dependencies
_             = require 'lodash'
Himesama      = require './himesama'
{ Render }    = Himesama
{ initState } = Himesama
{ div, p }    = Himesama.DOM

# Initialize State
initState 
  title:      'Himesama yeeee'
  message:    'yeeee'
  count:      0
  listField:  ''
  words:      []

# Components
Title   = require './components/title'
Counter = require './components/counter'
Count   = require './components/count'
Field   = require './components/list-field'
Words   = require './components/words'


App = Himesama.createClass

  render: -> 
    div id: 'A', 
      Title()
      Count()
      Counter()
      Field()
      Words()


Root  = document.getElementById 'root'

Render App(), Root 
