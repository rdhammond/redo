# This originalEvent stuff cannot POSSIBLY be right, but for now,
# it's working.
#
$(document).ready ->
  $('#add-form').on 'ajax:success', (e) ->
    $(this)[0].reset()
    xhr = e.originalEvent.detail[2]
    $('#tasks .card-deck').append xhr.responseText

  $('#search-form').on 'ajax:success', (e) ->
    $('#search-form')[0].reset()
    xhr = e.originalEvent.detail[2]
    $('#tasks .card-deck').html xhr.responseText

  $('#tasks').on 'ajax:success', 'form.task-form', (e) ->
    xhr = e.originalEvent.detail[2]
    $(this).closest('.card').replaceWith xhr.responseText
