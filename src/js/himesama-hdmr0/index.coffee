# Dependencies
_          = require 'lodash'
{ Render, HTMLify } = require './render'

DOMCreate = (type) ->
  ->
    args       = _.toArray arguments 

    type:       type
    attributes: args[0]
    children:   _.flatten (args.slice 1)


Himesama =


  createClass: (c) -> 
    ->
      H = {}
      _.forEach (_.keys c), (k) ->
        v = c[k]
        v = v.bind H if _.isFunction v
        H[k] = v
        return

      H.setAttr = (payload, next) ->
        @dirty  = true
        _.forEach (_.keys payload), (k) =>
          @attributes[k] = payload[k]
        Himesama.Rerender []
      
      attributes = arguments[0]
      needs      = arguments[1]

      H.attributes = {}
      if H.initAttributes?
        H.attributes = H.initAttributes()
      _.forEach (_.keys attributes), (k) =>
        H.attributes[k] = attributes[k]

      if needs?
        if H.needs? then H.needs.concat needs
        else H.needs = needs

      H.dirty    = false
      H.setState = Himesama.setState.bind Himesama
      H.state    = Himesama.state
      H.type     = 'custom'
      H.children = [ H.render() ]
      H


  initState: (state) -> @state = state


  setState: (payload, next) ->
    keys = _.keys payload
    _.forEach keys, (k) =>
      @state[k] = payload[k]
    @Rerender keys
    next?()


  Render: (root, mountPoint) ->
    @VirtualDOM = root.render()
    @mountPoint = mountPoint
    html = HTMLify.entireTree @VirtualDOM
    mountPoint.appendChild html


  Rerender: (stateKeys) ->
    _.forEach stateKeys, (key) =>
      @markDirty @VirtualDOM, key
    @handleDirt @VirtualDOM
    root = @mountPoint.children[0]
    Render root, @VirtualDOM


  markDirty: (node, basis) ->
    if node.needs? and basis in node.needs
      node.dirty = true
    _.forEach node.children, (child, ci) =>
      @markDirty child, basis


  handleDirt: (node) ->
    {dirty, children} = node
    if dirty? and dirty
      node.dirty    = false
      node.children = [node.render()]
    else
      _.forEach children, (child) => 
        @handleDirt child

Himesama.Render    = Himesama.Render.bind Himesama
Himesama.initState = Himesama.initState.bind Himesama
DOM                = (require './dom-elements').split ' '
Himesama.DOM       = _.reduce DOM, 
  (sum, el) -> 
    sum[el] = DOMCreate el
    sum
  {}

module.exports = Himesama
