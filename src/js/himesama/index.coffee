# Dependencies
_       = require 'lodash'
htmlify = require './htmlify'
Merge   = require './merge'

DOMCreate = (type) ->
  ->
    args = _.toArray arguments 
    args[0] = {} unless args[0]?

    _.reduce (_.flatten args.slice 1),
      
      (vo, child, i) ->
        if _.isString child
          child = 
            type:       'himesama-text'
            content:    child
            attributes: {}
        child.parent = vo
        child.index  = i
        vo.children.push child
        vo

      type:         type
      attributes:   args[0]
      children:     []

allocateIds = (vo, id) ->
  if vo.type is 'custom'
    vo = vo.children[0]

  { attributes, children } = vo
  idAttr = 'himesama-id': id
  _.extend attributes, idAttr
  _.forEach children, (child, i) =>
    allocateIds child, id + '.' + i


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
        Himesama.rerender []
      
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
      return

    _.forEach keys, (k) =>
      @dirtify @vdom, k

    @rerender @vdom

    next?()


  Render: (vdom, mount) ->
    allocateIds vdom, '0'
    @vdom  = vdom
    @mount = mount
    html   = htmlify @vdom
    mount.appendChild html


  dirtify: (node, basis) ->
    { needs, children } = node
    if needs? and basis in needs
      node.dirty = true
    _.forEach children, (child, ci) =>
      @dirtify child, basis


  rerender: (node) ->
    { dirty, children } = node
    if dirty?
      node.dirty = false
      draft = node.render()
      Merge node, draft
    else
      _.forEach children,
        (child) => @rerender child


Himesama.initState = Himesama.initState.bind Himesama
Himesama.Render    = Himesama.Render.bind Himesama
DOM = (require './dom-elements').split ' '
DOM.unshift {}
Himesama.DOM = _.reduce DOM, (sum, el) -> 
  sum[el] = DOMCreate el
  sum


module.exports = Himesama
