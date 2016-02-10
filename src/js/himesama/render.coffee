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
    nEl      = HTMLify.Single draft
    children = _.toArray el.children
    _.forEach children, (child) ->
      nEl.appendChild child
    parent = el.parentNode
    parent.replaceChild nEl, el

  nodeToText: (model, draft) ->
    id     = model.attributes[hk]
    el     = getByAttribute hk, id
    nEl    = HTMLify.Text draft.content
    parent = el.parentNode
    parent.replaceChild nEl, el

  textToNode: (model, draft) -> 
    parent = model.parent
    id     = parent.attributes[hk]
    parent = getByAttribute hk, id
    nEl    = HTMLify.Single draft
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
    child = HTMLify child
    id = model.attributes[hk]
    el = getByAttribute hk, id
    el.appendChild child







