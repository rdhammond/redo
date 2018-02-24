$ () ->
  $('#search-button').click () ->
    url = $(this).data('url')
    searchText = $('#search-text').val()
    $('#tasks').load "#{url}?search=#{searchText}"
