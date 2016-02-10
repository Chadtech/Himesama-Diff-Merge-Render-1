# Dependencies
_      = require 'lodash'
Diff   = require './diff'
Render = require './render'

min = (a, b) ->
  Math.min a.length, b.length

max = (a, b) ->
  Math.max a.length, b.length

eitherAreText = (model, draft) ->
  true if model.type is 'himesama-text'
  true if draft.type is 'himesama-text'

hk = 'himesama-id'

adoptId = (model, draft) ->
  draft.attributes[hk] = model.attributes[hk]
  draft

module.exports = Merge = 
  
  Tree: (model, draft) ->
    Merge.Node model, draft


  Node: (model, draft) ->
    { Children, Node } = Merge

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
      unless Diff.nodes model, draft
        draft = adoptId model, draft
        Render.node model, draft
        model.type       = draft.type
        model.attributes = draft.attributes
        Children model, draft


  Children: (model, draft) ->
    mChildren = model.children
    dChildren = draft.children
    { Children, Node } = Merge

    f = min mChildren, dChildren
    _.times f, (fi) =>
      mChild = mChildren[fi]
      dChild = dChildren[fi]

      Node mChild, dChild

    s   = max mChildren, dChildren
    ml  = mChildren.length
    dl  = dChildren.length
    _.times s - f, (si) =>
      if ml > dl
        
        mChildren.splice f, 1
        Render.remove model, f

      else
        dChild = dChildren[ si + f ]
        mChildren.push dChild
        Render.add model, dChild






