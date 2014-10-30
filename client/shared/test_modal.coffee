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
      console.log 'before'

      Words = Session.get 'Words'

      console.log doc
      console.log Words.length

      if doc.quantity > Words.length
        alert 'Not enough words!'
        false

      if doc.order == 'random'
        Words = shuffle(Words)
      else if doc.order == 'oldest'
        Words = Words.reverse()

      Testing = Words.splice(0,doc.quantity)
      Session.set 'Testing', Testing

      $('.modal-backdrop.fade.in').remove()
      Router.go 'test'

      false




      

  # after:
  #   insert: (error, result, template) ->

  #   update: (error, result, template) ->

  #   methodName: (error, result, template) ->

  onSubmit: (insertDoc, updateDoc, currentDoc) ->
    console.log 'submit'

  
  # Called when any operation succeeds, where operation will be
  # "insert", "update", or the method name.
  onSuccess: (operation, result, template) ->
    console.log 'success'

  
  # # Called when any operation fails, where operation will be
  # # "validation", "insert", "update", or the method name.
  # onError: (operation, error, template) ->

  # formToDoc: (doc, ss, formId) ->

  # docToForm: (doc, ss, formId) ->

  
  # # Called at the beginning and end of submission, respectively.
  # # This is the place to disable/enable buttons or the form,
  # # show/hide a "Please wait" message, etc. If these hooks are
  # # not defined, then by default the submit button is disabled
  # # during submission.
  # beginSubmit: (formId, template) ->

  # endSubmit: (formId, template) ->

