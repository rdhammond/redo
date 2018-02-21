# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class CardsControl
  constructor: (id) ->
    @element = $ ('#' + id)
    @element.on 'submit', '.card form', @submit

  submit: () ->
    card = $ this
    done = card.find('.done-hidden').first().val()
    url = card.attr 'action'
    $.post url, {done: done}, (data) ->
      submit_done data, card
    false

  submit_done: (data, card) ->
    html = $ data
    card.replaceWith html


class SearchControl 
  constructor: (id, cardsId, @controlsDict) ->
    @form = $ ('#' + id)
    @url = $form.attr 'action'
    @cards = $ ('#' + cardsId)
    @form.submit @submit

  submit: () ->
    searchText = @controlsDict.searchText.val()
    $.get "#{@url}?q=#{searchText}", @search_done
    false

  search_done: (data) ->
    newElem = $ data
    cards.html newElem.html()

class TaskControl extends HomeControl
  constructor: (id, cardsId, @controlsDict) ->
    @form = $ ('#' + id)
    @url = $form.attr 'action'
    @cards = $ ('#' + cardsId)
    @form.submit @submit

  submit: () ->
    data =
      description: @controlDict.description.val()
      type: @controlDict.type.val()

    $.post @url, data, @search_done

  search_done: (data) ->
    new_card = $ data
    @cards.append new_card

$.document () ->
  cards = new CardsControl 'task-cards'
  search = new SearchControl 'search-form', 'task-cards', {searchText: $ '#search-text'}
  task = new TaskControl 'task-form', 'task-cards',
    description: $ '#description',
    type: $ '#type'
