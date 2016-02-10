# Dependencies
_          = require 'lodash'
Himesama   = require '../himesama'
{ div, p } = Himesama.DOM


module.exports = Count = Himesama.createClass

  needs: [ 'count' ]

  render: ->
    { count } = @state 

    div
      id:          'count div'
      style:       (display: 'inline')
      p 
        className: 'point', 
        style:     (display: 'inline')
        'Count : ' + count + ', '

