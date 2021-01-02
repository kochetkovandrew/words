jQuery ->
  $('.word-player').dblclick ->
    putResult($(this).context.innerText)
  if $('#page').val() == 'field'
    updateResults()
    window.setInterval(updateResults, 2000);
  $('.reset_timer').click ->
    resetTimer($(this).data('seconds'))

resetTimer = (seconds) ->
  $.ajax
    url: '/games/' + $('#game-id').val() + '/reset_timer?seconds=' + seconds
    dataType: 'json'
    method: 'PUT'
    data:
      authenticity_token: $('[name="csrf-token"]')[0].content
    success: (data) ->
      console.log 'yyy'
      updateResults()

putResult = (clicked_word) ->
  $.ajax
    url: '/games/' + $('#game-id').val()
    dataType: 'json'
    method: 'PUT'
    data:
      word: clicked_word
      authenticity_token: $('[name="csrf-token"]')[0].content
      viewer: $('#viewer').val()
    success: (data) ->
      $.each data.words, (word, result) ->
        $('.word-item[data-word="' + word + '"] button').removeClass('red')
        $('.word-item[data-word="' + word + '"] button').removeClass('blue')
        $('.word-item[data-word="' + word + '"] button').removeClass('white')
        $('.word-item[data-word="' + word + '"] button').removeClass('black')
        $('.word-item[data-word="' + word + '"] button').addClass('word-' + result)

updateResults = () ->
  $.ajax
    url: '/games/' + $('#game-id').val() + '/field.json?viewer=' + $('#viewer').val()
    dataType: 'json'
    method: 'GET'
    success: (data) ->
      $.each data.words, (word, result) ->
        $('.word-item[data-word="' + word + '"] button').removeClass('red')
        $('.word-item[data-word="' + word + '"] button').removeClass('blue')
        $('.word-item[data-word="' + word + '"] button').removeClass('white')
        $('.word-item[data-word="' + word + '"] button').removeClass('black')
        $('.word-item[data-word="' + word + '"] button').addClass('word-' + result)
      if data.results.game_over
        $('.score button').removeClass('word-red')
        $('.score button').removeClass('word-green')
        $('.score button').removeClass('word-blue')
        $('.score button').addClass('word-black')
      else
        $.each data.results, (color, result) ->
          if color != 'game_over'
            $('.score .word-' + color)[0].innerText = result
        $('#rest_time').text('Осталось ' + data.rest_time + ' секунд')
