Config =
	name: 'Mem Mem'
	title: 'Manage your vocabulary'
	subtitle: 'Organize and record your foreign language vocab'
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
	recentLength: 10

if Meteor.isClient
	window.Config = Config
else if Meteor.isServer
	global.Config = Config