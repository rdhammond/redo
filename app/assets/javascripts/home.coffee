$(document).ready ->
  $('#add-form').on "ajax:success", (e) ->
    $('#add-form')[0].reset()

    # ** HACK: This cannot POSSIBLY be right, but it works for now.
    data = e.originalEvent.detail[2].responseText
    $('#tasks .card-deck').append data
