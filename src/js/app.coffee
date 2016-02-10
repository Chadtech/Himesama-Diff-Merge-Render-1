# Dependencies 
_         = require 'lodash'
Himesama  = require './himesama'
{ Merge } = Himesama
{ Render } = Himesama

{ div, p } = Himesama.DOM

# App =
#   div id: 'not A!',
#     div id: 'Not B!',
#       p 
#         className: 'point'
#         'dank memes'

# Update =
#   div id: 'A',
#     div id: 'B',
#       p 
#         id: 'hell ye'
#         className: 'point'
#         'so dank'
#       p
#         className: 'point'
#         'yeeee'
#       p
#         className: 'point'
#         'dank'


App = Himesama.createClass

  render: ->

    p
      className: 'point'
      'Yeeee'



mount = document.getElementById 'root'
Render App(), mount




