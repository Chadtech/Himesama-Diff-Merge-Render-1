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

    buttons = 
      div null,
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

    if count > 3
      buttons =
        div null,
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

    if count > 6
      buttons =
        div null,
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




    
    div 
      id:          'counter div'
      style:       display: 'inline'
      buttons




