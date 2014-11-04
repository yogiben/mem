@Test = 
	correct: ->
		if Session.get 'multiple'
			Answers.new Session.get('CurrentTestItem')._id, 'multiple'
		else
			Answers.new Session.get('CurrentTestItem')._id, 'string'
	incorrect: ->
		Answers.new Session.get('CurrentTestItem')._id, 'incorrect'
		Session.set 'correct', false
		Reveal.down()


	next: ->
		console.log 'next'
		Session.set 'response', ''
		Session.set 'test_input', ''
		Session.set 'correct', ''
		Session.set 'multiple', false
		Session.set 'Multiples', null
		Session.set 'test_index', Session.get('test_index') + 1
		Reveal.right()
		$(Reveal.getCurrentSlide()).find('input').focus()

		@speakPrompt()
		
	getMultiples: ->
		currentTestItem = Session.get('CurrentTestItem')
		Multiples = []
		Multiples.push currentTestItem

		if Session.get('Words').length >= 5
			i = 0
			while i < 5
				word = Random.choice(Session.get('Words'))
				if word._id != currentTestItem._id
					Multiples.push word
					i++
		# else
		# 	i = 0
		# 	while i < 5
		# 		Multiples.push Words.find({_id: { $not: Session.get('CurrentTestItem')._id}}).fetch()[i]
		# 		i++
		Utils.shuffle(Multiples)
	isCorrect: (response,answer)->
		response = @parseTestString(response)
		answer = @parseTestString(answer)

		if answer.indexOf('/') > -1
			answer = answer.split('/')
			_.contains answer, response
		else
			response == answer

	multiple: ->
		Session.set 'multiple', true
		Session.set 'Multiples', @getMultiples()
		Reveal.down()

	speakPrompt: ->
		CurrentTestItem = Session.get('Testing')[Session.get('test_index')]
		if CurrentTestItem.promptType == 'both' || CurrentTestItem.promptType == 'voice'
			if CurrentTestItem.prompt == 'target'
				tl = Languages[CurrentTestItem.language].code
				text = CurrentTestItem.target
			else
				tl = 'en'
				text = CurrentTestItem.source
			tts.speak text, tl

	parseTestString: (str)->
		str.toLowerCase()
		str = str.replace(/\(.*?\)/g, '');
		str = str.replace(' /','/')
		str = str.replace('/ ','/')
		str = str.replace(/^\s+|\s+$/g,'')
		str