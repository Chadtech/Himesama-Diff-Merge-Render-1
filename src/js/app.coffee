# Dependencies 
_           = require 'lodash'
Himesama    = require './himesama'
{ Render }  = Himesama

{ div, p } = Himesama.DOM


Himesama.initState 
  title: 'yeeee'


yeee = Himesama.createClass

  needs: ['title']

  handle: ->
    @setState title: 'DOPE'

  render: ->
    { title } = @state

    div null,
      p 
        className: 'point'
        event:     click: @handle
        title


App = Himesama.createClass

  render: ->

    div null,
      yeee()


mount = document.getElementById 'root'
Render App(), mount




