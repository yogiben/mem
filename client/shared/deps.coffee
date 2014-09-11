Deps.autorun ->
	Meteor.subscribe 'user'
	Meteor.subscribe 'words'
	Meteor.subscribe 'sets'
	Meteor.subscribe 'tests'

	if Session.get 'word'
		Session.set 'Word',Words.findOne {_id:Session.get('word')}

	if Session.get 'language'
		Session.set 'Language', Languages[Session.get 'language']
		Session.set 'Sets', Sets.find({language: Session.get 'language'}).fetch()
		Session.set 'sets', _.map Sets.find({language: Session.get 'language'}).fetch(), (set)->
			set._id
	else
		Session.set 'Language', null
		Session.set 'Sets', null

	if Session.get 'set'
		Session.set 'Set', Sets.findOne 
			$and: [
				owner: Meteor.userId()
				name: Session.get 'set'
			]
	else
		Session.set 'Set', null

	if Meteor.user()
		Session.set 'learning', Meteor.user().learning

	if Session.get 'learning'
		Session.set 'Learning', _.map Session.get('learning'), (string)->
			Languages[string]

	Session.set 'Words', Words.find( Session.get('filter') , {sort : {createdAt:-1}} ).fetch()
	Session.set 'Sets', Sets.find( Session.get('languageFilter') ).fetch()
	Session.set 'Tests', Tests.find( Session.get('languageFilter') ).fetch()

	#Word Filter
	Session.setDefault 'filter', {}

	if Session.get('language') and Session.get('set')
		filter =
			$and : [
				{language: Session.get 'language'}
				{sets: { $all : [ Session.get('Set')._id ] }}
			]
		Session.set 'filter', filter
	else if Session.get 'language'
		filter =
			language: Session.get 'language'
		Session.set 'filter', filter
	# else if Session.get 'set'
	# 	filter =
	# 		set: Session.get 'set'
	# 	Session.set 'filter', filter
	else
		Session.set 'filter', {}

	#Sets and Test filter
	if Session.get 'language'
		languageFilter =
			language: Session.get 'language'
		Session.set 'languageFilter', languageFilter
	else
		Session.set 'languageFilter', {}

	Session.setDefault 'addType','quick'

	if Session.get 'Words'
		if Session.get('Words').length > Config.testLength
			Session.set 'Testing', Session.get('Words').splice(0,Config.testLength) 
		else
			Session.set 'Testing', Session.get('Words')

	Session.setDefault 'test_index', 0
	Session.set('CurrentTesting',Session.get('Testing')[Session.get('test_index')])

	Session.setDefault 'prompt', 'target'
	Session.setDefault 'multiple', false

	if Session.get 'multiple'
		Session.set 'Multiples', App.getMultiples()

	if Session.get 'response'
		Session.set 'correct', App.isCorrect Session.get('response'), Session.get('answer')

	if Session.get 'CurrentTesting'
		if Session.equals 'prompt', 'target'
			Session.set 'answer', Session.get('CurrentTesting').source
		else
			Session.set 'answer', Session.get('CurrentTesting').target


	#Accounts entry routing bug
	if Meteor.userId() and not _.isNull(Router.current()) and Router.current().route.name == 'entrySignIn'
		Router.go 'dashboard'

	if Meteor.userId() and not _.isNull(Router.current()) and Router.current().route.name == 'entrySignUp'
		Router.go 'dashboard'

	if Meteor.user()
		Session.set 'User', Meteor.user()

	if Meteor.user() and typeof Meteor.user() == 'object'
		Session.set 'username', Meteor.user().username

	if Session.get 'learning'
		_.each Session.get('learning'), (learning)->
			Session.setDefault learning, {
				sets: []
			}

	Session.setDefault 'addSets',[]
	Session.setDefault 'languageAddSets',[]

	if Session.get('addSets') and Session.get('language')
		languageAddSets = _.filter Session.get('addSets'), (addSet)->
			Sets.findOne({_id:addSet}).language == Session.get('language')
		Session.set 'languageAddSets', languageAddSets

	Session.setDefault 'multiple', []
	Session.setDefault 'multipleNew',[]
	Session.setDefault 'multipleDuplicates',[]

	if Session.get 'multiple' and typeof 'App' != 'undefined'
		Session.set 'multipleDuplicates', App.getDuplicates Session.get('multiple')
