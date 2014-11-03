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

      #Order of Words
      if doc.order == 'random'
        Words = Utils.shuffle(Words)
      else if doc.order == 'oldest'
        Words = Words.reverse()

      Testing = Words.splice(0,doc.quantity)

      $('.modal-backdrop.fade.in').remove()
      $('body').removeClass('modal-open')
      Session.set 'testOptions', doc

      testOptions = Session.get 'testOptions'

      randoms = []
      randoms.push(Random.choice([true,false])) for x in [1..Testing.length]

      #Prompt of words
      Testing = _.map Testing, (testing, index)->
        if testOptions.prompt == 'target' or testOptions.prompt == 'source'
          testing.prompt = testOptions.prompt
        else if testOptions.prompt == 'random'
          if Random.choice([true,false])
            testing.prompt = 'target'
          else
            testing.prompt = 'source'
        console.log testing
        testing
      Session.set 'Testing', Testing

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

