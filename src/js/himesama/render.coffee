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
    tc       = el.textContent
    children = _.toArray el.children
    # console.log 'CHILDREN', children
    # console.log 'TEXT CONTENT', el.textContent
    nEl = _.reduce children, 
      (nEl, child) ->
        nEl.appendChild child
      HTMLify.Single draft
    nEl.textContent = tc
    parent = el.parentNode
    parent.replaceChild nEl, el

  nodeToText: (model, draft) ->
    # console.log 'Node to text'
    id     = model.attributes[ hk ]
    el     = getByAttribute hk, id
    nEl    = HTMLify.Text draft.content
    parent = el.parentNode
    parent.replaceChild nEl, el

  textToNode: (model, draft) -> 
    # console.log 'Text to node'
    parent = model.parent
    id     = parent.attributes[hk]
    parent = getByAttribute hk, id
    nEl    = HTMLify draft
    parent.textContent = ''
    parent.appendChild nEl

  text: (model, draft) ->
    # console.log 'Text to text', 
    parent = model.parent
    id     = parent.attributes[hk]
    parent = getByAttribute hk, id

    parent.textContent = draft.content

  remove: (model, i) ->
    if model.type is 'himesama-text'
      parent = model.parent
      id     = parent.attributes[hk]
      el     = getByAttribute hk, id
      el.textContent = ''
    else
      id = model.attributes[hk]
      el = getByAttribute hk, id
      el.remove()

  add: (model, child) ->
    if child.type is 'himesama-text'
      el.textContent = child.content
    else
      child = HTMLify child
      id = model.attributes[hk]
      el = getByAttribute hk, id
      el.appendChild child







