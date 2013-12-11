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

  $('#flash_notice').modal()

  #==================== Team role filter =======================================
  $(document).on 'click', '.filter-link', ->
    $('.filter-link').removeClass('active-role')
    $(this).addClass('active-role')
    if $(this).attr('data-role') == 'all'
      $(".team-item").show('fade',600)
    else
      $('.team-item').hide()
      $(".team-item[data-team-role = '#{$(this).attr 'data-role'}']").each ->
        $(this).show('fade',600)
    false