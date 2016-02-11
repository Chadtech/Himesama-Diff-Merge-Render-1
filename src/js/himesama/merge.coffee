# Dependencies
_      = require 'lodash'
Diff   = require './diff'
Render = require './render'

# Utilities
{ min, max } = Math 

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
        i           = model.index
        parent      = model.parent
        children    = parent.children
        children[i] = draft
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

  ml = mChildren.length
  dl = dChildren.length

  f = min ml, dl
  _.times f, (fi) =>
    mChild = mChildren[ fi ]
    dChild = dChildren[ fi ]
    Merge mChild, dChild

  s  = max ml, dl
  if ml > dl
    _.times s - f, =>
      mChildren.splice f, 1
      Render.remove model, f
  else
    _.times s - f, (si) =>
      dChild   = dChildren[ si + f ]
      modelsId = model.attributes[hk]
      childsId = modelsId + '.' + (si + f)
      dChild.attributes[hk] = childsId 
      mChildren.push dChild
      Render.add model, dChild


