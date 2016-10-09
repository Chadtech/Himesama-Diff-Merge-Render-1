# Dependencies
_         = require 'lodash'
Himesama  = require '../himesama'
{ input } = Himesama.DOM


module.exports = TitleField = Himesama.createClass
  
  needs: [ 'title' ]

  handle: ->
    @setState title: event.target.value

  render: ->
    { title } = @state

    input
      className:   'field'
      placeholder: 'yeeeee'
      value:       title
      event:       input: @handle