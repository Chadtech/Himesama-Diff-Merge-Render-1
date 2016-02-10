# Dependencies
_         = require 'lodash'
Himesama  = require '../himesama'
{ input } = Himesama.DOM


module.exports = FieldInput = Himesama.createClass

  needs: [ 'listField' ]

  handle: (event) ->
    @setState listField: event.target.value

  submit: (event) ->
    if event.which is 13
      { words, listField } = @state 
      words.push listField
      @setState 
        listField: ''
        words:     words

  render: ->
    { listField } = @state 

    input 
      className:    'field'
      style:        (display: 'table')
      placeholder:  'press enter'
      value:        listField
      event:        
        input:      @handle
        keydown:    @submit

