AutoForm.hooks add:
  formToDoc: (doc) ->
    doc.sets = Session.get('languageAddSets')
    doc

Template.words.events
	# 'change input[type="checkbox"]': (e,t) ->
	# 	set = $(e.currentTarget).attr('set')
	# 	word = $(e.currentTarget).attr('word')
	# 	console.log word
	# 	console.log set
	'click .toggle-set': (e,t)->
		set = $(e.currentTarget).attr('set')
		word = $(e.currentTarget).attr('word')
		App.toggleSet word, set