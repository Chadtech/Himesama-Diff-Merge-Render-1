# Dependencies
_          = require 'lodash'
Himesama   = require '../himesama'
{ div, p } = Himesama.DOM

module.exports = Words = Himesama.createClass

  needs: [ 'words' ]

  render: ->
    { words } = @state

    div null,

      _.map words, (word, i) ->
        p
          className: 'point'
          i + ' ' + word
