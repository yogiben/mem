Template.testLayout.events
	'click a.session-set,button.session-set': (e,t) ->
		key = $(e.currentTarget).attr('key')
		value =  $(e.currentTarget).attr('value')
		Session.set key, value
	'keyup input.session-set': (e,t)->
		key = $(e.currentTarget).attr('key')
		value = $(e.currentTarget).val()
		Session.set key, value
		if Test.isCorrect(value, Session.get('answer')) and Session.equals 'correct', ''
			console.log 'CORRECT!'
			Session.set 'correct', true

			Test.correct()

			setTimeout (->
				  Test.next()
				), 100
	'keydown': (e,t)->
		if e.which == 13
			if Reveal.getIndices().v == 0
				Test.multiple()
			else if Reveal.getIndices().v == 1
				Test.incorrect()
			else if Reveal.getIndices().v == 2
				Test.next()


	'click .test-input-skip': (e,t)->
		Test.multiple()
	'click .test-multiple-answer': (e,t)->
		value =  $(e.currentTarget).val()
		if Test.isCorrect value, Session.get('answer')
			Session.set('correct',true)
			console.log 'MULTIPLE CHOICE CORRECT'

			Test.correct()

			setTimeout (->
				  Test.next()
				), 100
		else
			
			setTimeout (->
				  Test.incorrect()
				), 100
	'click .accept-incorrect': (e,t)->
		Test.next()

	'click .speak-prompt': (e,t)->
		Test.speakPrompt()

Template.testLayout.rendered = () ->
	setTimeout (->
		$(Reveal.getCurrentSlide()).find('input').focus()
	), 500

Template.testLayout.destroyed = () ->
	console.log 'test layout destroyed'
	Session.set 'Testing', null
	Session.set 'test_index', 0

Template.registerHelper 'currentFalse', (_id) ->
		if Session.equals('correct', false) and Session.get('CurrentTestItem')._id == _id
			console.log _id
			true

Template.testLayout.helpers
	testCount: () ->
		Session.get('test_index') + 1