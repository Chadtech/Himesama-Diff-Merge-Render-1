# Dependencies
_       = require 'lodash'
HTMLify = require './htmlify'

DOMCreate = (type) ->
  ->
    args = _.toArray arguments 
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

allocateIds = (vdom, id) ->
  idAttr = 'himesama-id': id
  { attributes, children } = vdom
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


  Diff:  require './diff'
  Merge: require './merge'

  Render: (vdom, mount) ->
    allocateIds vdom, '0'
    html = HTMLify vdom
    mount.appendChild html


Himesama.initState = Himesama.initState.bind Himesama
Himesama.Render = Himesama.Render.bind Himesama
DOM = (require './dom-elements').split ' '
Himesama.DOM = _.reduce DOM, 
  (sum, el) -> 
    sum[el] = DOMCreate el
    sum
  {}

module.exports = Himesama
