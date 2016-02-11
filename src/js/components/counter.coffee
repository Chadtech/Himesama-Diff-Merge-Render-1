# Dependencies
_        = require 'lodash'
Himesama = require '../himesama'
{div, p} = Himesama.DOM


module.exports = Counter = Himesama.createClass

  increment: ->
    { count } = @state 
    @setState count: (count + 1)

  decrement: ->
    { count } = @state
    @setState count: (count - 1)

  render: ->
    { count } = @state

    div 
      id:          'counter div'
      style:       display: 'inline'
      p 
        className: 'point link' 
        style:     display: 'inline'
        event:     click: @increment
        ' + 1'

      p 
        className: 'point' 
        style:     display: 'inline'
        ','

      p 
        className: 'point link' 
        style:     display: 'inline'
        event:     click: @decrement
        ' - 1 '



