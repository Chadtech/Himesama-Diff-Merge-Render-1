# Dependencies
_          = require 'lodash'
Himesama   = require '../himesama'
{ div, p } = Himesama.DOM


module.exports = Title = Himesama.createClass
  
  needs: [ 'title' ]

  render: ->
    { title } = @state

    p
      className: 'point'
      p 
        className: 'point'
        title