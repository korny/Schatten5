choiceName = (choice) ->
  window.priorities.translate[choice]

choiceData = (choice) ->
  window.priorities[choiceName(choice)]

window.App =
  initialize: ->
    $('.priority-choices').sortable
      axis: 'x'
      containment: 'parent'
      tolerance: 'pointer'
      handle: 'h2'
      update: => @fill()
    @fill()
  
  fill: ->
    $('.priority-choices li').each ->
      choice = $(@).data('choice')
      $('h2', @).text choiceName(choice)
      
      priority = String.fromCharCode(65 + $(@).index())
      data = choiceData(choice)[priority]
      
      subchoice = null
      if $.isPlainObject(data)
        $.each data, (key, value) ->
          subchoice = key
          data = value
          false
      
      data = data.join('</p><p>') if $.isArray(data)
      
      $('p', @).html data || ''
      $('h3', @).text subchoice || ''
