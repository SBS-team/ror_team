(->
  class AjaxNotice
    _parent: null
    _error_div: null
    _count: null
    _base_div_class: null
    _notice_div_class: null

    constructor: (parent, base_class, notice_class)->
      @_parent = $(parent)
      @_base_div_class =  base_class
      @_notice_div_class =  notice_class
      @_error_div = $('<div class="' + @_base_div_class + '"></div>')
      @_count = 1

    add: (text) ->
      @_count++
      @_error_div.append '<div class="' + @_notice_div_class + '">' + text + '</div>'

    show_first: ->
      @errors_remove()
      @_parent.prepend @_error_div

    show_last: ->
      @errors_remove()
      @_parent.append @_error_div

    errors_remove: ->
      if @_parent.find('.' + @_base_div_class).length > 0
        @_parent.find('.' + @_base_div_class).remove()

  window.AjaxNotice = AjaxNotice
)()