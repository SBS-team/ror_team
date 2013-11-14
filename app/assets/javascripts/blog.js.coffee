#= require jquery
#= require jquery.tagcanvas
#= require jquery.highlight-4
#= require jquery.validate

$(document).ready ->

  $(".form-search").validate
    rules:
      "search":
        maxlength: 50

  $("#myCanvas").tagcanvas(
    textColour: "#E80202"
    outlineColour: "#E80202"
    weight: true
    outlineThickness: 1
    zoom: 1
    maxSpeed: -0.04
    depth: 0.75
    textHeight: 14
  , "tagcloud")

  if RorTeam.searchText
    $('#post-content').highlight(RorTeam.searchText.toString())