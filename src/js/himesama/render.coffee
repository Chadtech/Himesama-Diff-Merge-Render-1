# Dependencies
_       = require 'lodash'
HTMLify = require './htmlify'
  
# Utilities
{ getElementById
  createTextNode
  createElement
  querySelectorAll
  querySelector
  getByAttribute } = require './doc'

hk = 'himesama-id'


module.exports = Render = 
  node: (model, draft) ->
    id       = model.attributes[hk]
    el       = getByAttribute hk, id
    children = _.toArray el.children
    nEl = _.reduce children, 
      (nEl, child) ->
        nEl.appendChild child
      HTMLify.Single draft
    parent = el.parentNode
    parent.replaceChild nEl, el

  nodeToText: (model, draft) ->
    console.log 'Node to text'
    id     = model.attributes[ hk ]
    el     = getByAttribute hk, id
    nEl    = HTMLify.Text draft.content
    parent = el.parentNode
    parent.replaceChild nEl, el

  textToNode: (model, draft) -> 
    console.log 'Text to node'
    parent = model.parent
    id     = parent.attributes[hk]
    parent = getByAttribute hk, id
    nEl    = HTMLify draft
    parent.textContent = ''
    parent.appendChild nEl

  text: (model, draft) ->
    parent = model.parent
    id     = parent.attributes[hk]
    parent = getByAttribute hk, id
    parent.textContent = draft.content

  remove: (model, i) ->
    id = model.attributes[hk]
    el = getByAttribute hk, id
    el.removeChild el.childNodes[i]

  add: (model, child) ->
    if child.type is 'himesama-text'
      el.textContent = child.content
    else
      child = HTMLify child
      id = model.attributes[hk]
      el = getByAttribute hk, id
      el.appendChild child







