shuffle = (array) ->
  currentIndex = array.length
  temporaryValue = undefined
  randomIndex = undefined
  
  # While there remain elements to shuffle...
  while 0 isnt currentIndex
    
    # Pick a remaining element...
    randomIndex = Math.floor(Math.random() * currentIndex)
    currentIndex -= 1
    
    # And swap it with the current element.
    temporaryValue = array[currentIndex]
    array[currentIndex] = array[randomIndex]
    array[randomIndex] = temporaryValue
  array


AutoForm.hooks 'test-form':
  before:
    # insert: (doc, template) ->

    # update: (docId, modifier, template) ->

    null: (doc, template) ->
      Words = Session.get 'Words'

      if doc.quantity > Words.length
        alert 'Not enough words!'
        false

      #Order of Words
      if doc.order == 'random'
        Words = shuffle(Words)
      else if doc.order == 'oldest'
        Words = Words.reverse()

      Testing = Words.splice(0,doc.quantity)

      $('.modal-backdrop.fade.in').remove()
      $('body').removeClass('modal-open')
      Session.set 'testOptions', doc

      testOptions = Session.get 'testOptions'

      #Prompt of words
      Testing = _.map Testing, (testing, index)->
        if testOptions.prompt == 'target' or testOptions.prompt == 'source'
          testing.prompt = testOptions.prompt
        else if testOptions.prompt == 'both'
          if Random.choice([true,false])
            testing.prompt = 'target'
          else
            testing.prompt = 'source'
        testing
      Session.set 'Testing', Testing

      Router.go 'test'
      false