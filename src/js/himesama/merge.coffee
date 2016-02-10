# Dependencies
_      = require 'lodash'
Diff   = require './diff'
Render = require './render'

# Utilities
min = (a, b) -> Math.min a.length, b.length
max = (a, b) -> Math.max a.length, b.length

eitherAreText = (model, draft) ->
  return true if model.type is 'himesama-text'
  return true if draft.type is 'himesama-text'

hk = 'himesama-id'

adoptId = (model, draft) ->
  draft.attributes[hk] = model.attributes[hk]
  draft

handleCustom = (vo) -> 
  return vo.children[0] if vo.type is 'custom'
  vo

module.exports = Merge = (model, draft) ->

  model = handleCustom model
  draft = handleCustom draft

  if eitherAreText model, draft
    if model.type isnt 'himesama-text'
      Render.nodeToText model, draft
    else
      if draft.type is 'himesama-text'
        unless Diff.strings model, draft
          Render.text model, draft
      else
        Render.textToNode model, draft
  else
    draft = adoptId model, draft
    unless Diff.nodes model, draft
      Render.node model, draft
      model.type       = draft.type
      model.attributes = draft.attributes
    
    mergeChildren model, draft


mergeChildren = (model, draft) ->
  mChildren = model.children
  dChildren = draft.children

  f = min mChildren, dChildren
  _.times f, (fi) =>
    mChild = mChildren[fi]
    dChild = dChildren[fi]

    Merge mChild, dChild

  s  = max mChildren, dChildren
  ml = mChildren.length
  dl = dChildren.length
  _.times s - f, (si) =>
    if ml > dl
      mChildren.splice f, 1
      Render.remove model, f

    else
      dChild = dChildren[ si + f ]
      mChildren.push dChild
      Render.add model, dChild


