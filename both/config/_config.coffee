Config =
	name: 'My App'
	title: 'Make Meteor Apps. Fast.'
	subtitle: 'Create beautiful and functioning Meteor apps really quick'
	logo: ->
		'<b>' + @name + '</b>'
	footer: ->
		@name + ' - Copyright 2014'
	emails:
		from: 'noreply@' + Meteor.absoluteUrl()
	twitter: 'BenPeterJones'
	facebook: 'benjaminpeterjones'
	blog: 'http://benjaminpeterjones.com'
	about: 'http://benjaminpeterjones.com'
	placeholder: 'Hello'
	testLength: 5

if Meteor.isClient
	window.Config = Config
else if Meteor.isServer
	global.Config = Config