class CardsControl
  constructor: (id) ->
    @element = $ "##{id}"
    @element.on 'submit', 'form', @submit

  submit: () ->
    form = $ this
    url = form.attr 'action'
    card = form.closest '.card'
    $.post url, form.serialize(), (data) ->
      card.replaceWith $(data)
    false

class SearchControl 
  constructor: (id, cardsId, @controls) ->
    @form = $ "##{id}"
    @url = @form.attr 'action'
    @cards = $ "##{cardsId}"
    @form.submit @submit

  submit: () =>
    $.get "#{@url}?search=#{@controls.searchText.val()}", (data) =>
      @cards.html $(data)
    false


class TaskControl
  constructor: (id, cardsId) ->
    @form = $ "##{id}"
    @url = @form.attr 'action'
    @cards = $ "##{cardsId}"
    @form.submit @submit

  submit: () =>
    $.post @url, @form.serialize(), (data) =>
      @cards.find('.card-deck').append $(data)
    false


$(document).ready () ->
  cards = new CardsControl 'task-cards'
  search = new SearchControl 'search-form', 'task-cards', {searchText: $ '#search-text'}
  task = new TaskControl 'task-form', 'task-cards',
    description: $ '#description',
    task_type: $ '#task-type'
