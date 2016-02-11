# Dependencies
_              = require 'lodash'
Himesama       = require '../himesama'
{ div, p, br } = Himesama.DOM

module.exports = Words = Himesama.createClass

  needs: [ 'words' ]

  handle: ->
    @setState words: []

  render: ->
    { words } = @state

    div null,

      _.map words, (word, i) ->
        p
          id: 'A word (not weird)'
          className: 'point'
          i + ' ' + word

      p
        id: 'weridy'
        className: 'point link'
        event:     click: @handle
        'clear'
