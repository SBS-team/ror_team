#= require jquery
#= require jquery.tagcanvas
#= require jquery.highlight-4

$(document).ready ->

  $("#myCanvas").tagcanvas(
    textColour: "#008DF0"
    outlineColour: "#008DF0"
    weight: true
    outlineThickness: 1
    zoom: 1
    maxSpeed: -0.04
    depth: 0.75
    textHeight: 14
  , "tagcloud")

  $('.content').highlight 'you'