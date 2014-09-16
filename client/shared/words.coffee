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
	'click input.select-word': (e,t)->
		# selected = Session.get('selected')
		# selected.push $(e.currentTarget).val()
		# console.log selected
		# Session.set 'selected', selected

		selected = []
		_.each $('input.select-word:checked'), (input)->
			selected.push $(input).val()

		Session.set 'selected', selected

Template.words.rendered = ->
	Session.set 'selected', []

Template.multipleControls.helpers
	isSelection: () ->
		Session.get('selected').length > 0

Template.multipleControls.events
	'click #delete-multiple': ->
		_.each Session.get('selected'), (_id)->
			Words.remove _id
	'click .add-set-multiple': (e,t)->
		set = $(e.currentTarget).attr('set')
		console.log set
		_.each Session.get('selected'), (_id)->
			Words.update _id, { $addToSet: { sets: set  }} , (e,r)->
				console.log e,r