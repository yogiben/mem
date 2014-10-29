@App = 
	getDuplicates: (array)->
		array
	toggleSet: (word,set)->
		word = Words.findOne {_id: word}
		if _.contains word.sets, set
			sets = _.without word.sets, set
		else
			sets = _.union word.sets, set
		Words.update({_id:word._id},{$set: {sets: sets}})
	getMultiples: ->
		Multiples = []
		Multiples.push Session.get('CurrentTestItem')
		if Session.get('Words').length >= 5
			i = 0
			while i < 5
			  Multiples.push Words.find( {_id: { $not: Session.get('CurrentTestItem')._id}} ).fetch()[i]
			  i++
		else
			i = 0
			while i < 5
			  Multiples.push Words.find({_id: { $not: Session.get('CurrentTestItem')._id}}).fetch()[i]
			  i++
		Multiples
	isCorrect: (response,answer)->
		response = response.toLowerCase()
		answer = answer.toLowerCase()
		response == answer
	next: ->
		console.log 'next'
		Session.set 'response', ''
		Session.set 'test_input', ''
		Session.set 'correct', ''
		Session.set 'multiple', false
		Session.set 'test_index', Session.get('test_index') + 1
		Reveal.right()
		$(Reveal.getCurrentSlide()).find('input').focus()
	multiple: ->
		Session.set 'multiple', true
		Session.set 'Multiples', @getMultiples()
		Reveal.down()
	correct: ->
		if Session.get 'multiple'
			Answers.new Session.get('CurrentTestItem')._id, 'multiple'
			console.log 'correct multiple'
		else
			Answers.new Session.get('CurrentTestItem')._id, 'string'
			console.log 'correct string'

	incorrect: ->
		Answers.new Session.get('CurrentTestItem')._id, 'incorrect'
		Session.set 'correct', false
		Reveal.down()

	getPoints: (_id)->
		points = 0
		_.each Config.points, (array)->
			status = array[0]
			value = array[1]
			points += value * Answers.find({$and: [{word:_id},{status: status}]}).fetch().length
		points
	getLastPoints: (_id)->
		answer = Answers.findOne {word:_id}, {sort: {createdAt: -1}}
		if typeof answer != 'undefined'
			points = 0
			_.each Config.points, (array)->
				points = array[1] if array[0] == answer.status
			points

	wordsDaysAgo: (ago,gap)->
		end = new Date()
		end.setDate(end.getDate() - ago)

		#+1 is wild guess
		start = new Date()
		start.setDate(start.getDate() - (ago + gap))

		Words.find({createdAt: {$gte: start, $lt: end}}).fetch()

	#Parsing functions
	parseMultiple: (text)->
		words = text.split("\n")
		words = _.map words, (word)->
			word = word.replace('－','-')
			word = word.replace(' - ','-')
			word = word.replace(' -','-')
			word = word.replace('- ','-')
			word = word.split('-')
		words = _.filter words, (word)->
			word.length == 3 or word.length == 2
		words

	parseTranslator: (target,source, transliteration) ->
		targets = target.split("\n")
		sources = source.split("\n")

		if transliteration
			transliterations = transliteration.split("\n")

			if targets.length != sources.length or transliterations.length != sources.length
				return alert 'The three inputs need to have the same number of lines'
		else
			transliterations = null
			if targets.length != sources.length
				return alert 'Both sides need to have the same number of lines'

		if targets.length == 0
			return alert 'Input empty'

		console.log 'great'

		words = []

		if transliterations
			for x, index in targets
				if targets[index] && sources[index]
					word = [
						targets[index]
						sources[index]
						transliterations[index]
					]
					words.push word
		else
			for x, index in targets
				if targets[index] && sources[index]
					word = [
						targets[index]
						sources[index]
					]
					words.push word

		words






