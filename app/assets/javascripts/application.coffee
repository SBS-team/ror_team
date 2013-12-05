#= require jquery_new
#= require jquery-ui
#= require jquery_ujs
#= require jquery.localscroll-1.2.7-min
#= require jquery.modal
#= require jquery.mousewheel
#= require jquery.parallax-1.1.3
#= require jquery.scrollTo-1.4.2-min
#= require main
#= require skrollr
#= require underscore
#= require jquery.validate
#= require additional-methods
#= require jquery-cookie
#= require lib/ajax_notice
#= require lib/timer
#= require jquery.cssemoticons.min
#= require jquery.remotipart
#= require jquery.iframe-transport
#= require jobs

$(document).ready ->
  $('.carousel').carousel()

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