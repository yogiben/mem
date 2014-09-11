UI.registerHelper 'Config', ->
	Config

UI.registerHelper 'niceName',->
	if Session.get('User')
		if Session.get('User').profile.firstName
			Session.get('User').profile.firstName
		else
			Session.get('User').emails[0].address

UI.registerHelper 'Users', ->
	Meteor.users

UI.registerHelper 'Word', ->
	Session.get 'Word'

UI.registerHelper 'Language', ->
	Session.get 'Language'

UI.registerHelper 'Languages', ->
	Languages

UI.registerHelper 'learning', ->
	Session.get 'learning'

UI.registerHelper 'Learning', ->
	Session.get 'Learning'

UI.registerHelper 'toArray', ->
	_.map Languages, (Language)->
		Language

UI.registerHelper 'set', ->
	Session.get 'set'

UI.registerHelper 'Set', ->
	Session.get 'Set'

UI.registerHelper 'multiple', ->
	Session.get 'multiple'

UI.registerHelper 'Testing',->
	Session.get 'Testing'

UI.registerHelper '_', ->
	_

UI.registerHelper 'User', ->
	Meteor.user()

UI.registerHelper 'username', ->
	Session.get 'username'

UI.registerHelper 'Words', ->
	Session.get 'Words'

UI.registerHelper 'Sets', ->
	Session.get 'Sets'

UI.registerHelper 'Tests', ->
	Session.get 'Tests'

UI.registerHelper 'addType',->
	Session.get 'addType'

UI.registerHelper 'addSets',->
	Session.get 'addSets'

UI.registerHelper 'getSets', (language)->
	Sets.find({language:language}).fetch()

UI.registerHelper 'getDoc', (_id,collection)->
	window[collection].findOne {_id:_id}

UI.registerHelper 'allSets', ->
	Session.get 'sets'

UI.registerHelper 'currentTesting', ->
	Session.get 'currentTesting'