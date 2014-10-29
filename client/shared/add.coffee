Template.quick.rendered = () ->
	Session.set 'quick-target', ''

Template.quick.destroyed = () ->
	Session.set 'quick-target', ''

Template.quick.events
	'keyup input[name="target"]': (e,t)->
		Session.set 'quick-target', $(e.currentTarget).val()

Template.multiple.events
	'click #addMultiple': () ->
		console.log 'addMultiple'
		words = Session.get 'multiple'
		_.each words, (word)->
			doc = {}
			doc.target = word[0]
			doc.language = Session.get 'language'
			doc.sets = Session.get 'languageAddSets'
			if word.length == 3
				doc.transliteration = word[1]
				doc.source = word[2]
			else
				doc.source = word[1]
			Words.insert doc, (e,r)->
				if e
					alert 'Could not add ' + doc.target '.'
		$('textarea[name="multiple"]').val('')

	'keyup textarea[name="multiple"],change textarea[name="multiple"]': (e,t)->
		if $(e.currentTarget).val() != ''
			multiple = App.parseMultiple $(e.currentTarget).val()
			Session.set 'multiple', multiple
		else
			Session.set 'multiple', []

Template.translator.events
	'click #addTranslator': () ->
		translatorTarget = $('#translatorTarget').val()
		translatorSource = $('#translatorSource').val()
		translatorTransliteration = $('#translatorTransliteration').val()

		unless translatorTarget && translatorSource
			return alert 'Target or source inputs can\'t be empty'

		words = App.parseTranslator translatorTarget, translatorSource, translatorTransliteration
		_.each words, (word)->
			doc = {}
			doc.target = word[0]
			doc.language = Session.get 'language'
			doc.sets = Session.get 'languageAddSets'
			if word.length == 3
				doc.transliteration = word[1]
				doc.source = word[2]
			else
				doc.source = word[1]
			Words.insert doc, (e,r)->
				if e
					alert 'Could not add ' + doc.target '.'
			$('textarea[name="translatorTarget"]').val('')
			$('textarea[name="translatorSource"]').val('')
			$('textarea[name="translatorTransliteration"]').val('')

focusInput = ->
    if Session.equals 'addType', 'quick'
    	$('input[name="target"]').focus()
    else if Session.equals 'addType', 'multiple'
    	$('input[name="multiple"]').focus()

AutoForm.hooks add:
  onSuccess: ->
  	Session.set 'quick-target', null
  	focusInput()

Template.add.rendered = ->
  	focusInput()