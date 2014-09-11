# Template.dashboardSidebar.rendered = ->
#   console.log 'rendered'
#   $(".treeview").tree()
#   return

Template.dashboardLayout.events
	'click [href="#afModal"]': (e,t) ->
		collection = $(e.currentTarget).attr('collection')
		operation = $(e.currentTarget).attr('operation')
		_id = $(e.currentTarget).attr('doc')
		omitFields = $(e.currentTarget).attr('omitFields')
		buttonClasses = $(e.currentTarget).attr('buttonClasses')
		html = $(e.currentTarget).html()
		title = html
		buttonContent = html
		
		if $(e.currentTarget).attr('title')
			title = $(e.currentTarget).attr('title')

		if $(e.currentTarget).attr('buttonContent')
			buttonContent = $(e.currentTarget).attr('buttonContent')

		if _id
			doc = window[collection].findOne _id:_id

		Session.set('cmCollection',collection)
		Session.set('cmOperation',operation)
		Session.set('cmDoc',doc)
		Session.set('cmButtonHtml',html)
		Session.set('cmOmitFields',omitFields)
		Session.set('cmTitle',title)
		Session.set('cmButtonContent',buttonContent)
		Session.set('cmButtonClasses',buttonClasses)


Template.dashboardHeader.rendered = ->
  $("[data-toggle='offcanvas']").click (e) ->
    e.preventDefault()
    
    if $(window).width() <= 992
      $(".row-offcanvas").toggleClass "active"
      $(".left-side").removeClass "collapse-left"
      $(".right-side").removeClass "strech"
      $(".row-offcanvas").toggleClass "relative"
    else
      
      #Else, enable content streching
      $(".left-side").toggleClass "collapse-left"
      $(".right-side").toggleClass "strech"
    return

  return

Template.dashboardLayout.events
	'click .session-set': (e,t) ->
		key = $(e.currentTarget).attr('key')
		value =  $(e.currentTarget).attr('value')
		Session.set key, value
	'click .addSet': (e,t) ->
		addSet = $(e.currentTarget).attr('set')
		addSets = Session.get 'addSets'
		if not _.contains addSets
			addSets.push addSet
			Session.set 'addSets',addSets
			refreshSets()
	'click .addSet.active': (e,t) ->
		addSet = $(e.currentTarget).attr('set')
		addSets = Session.get 'addSets'
		addSets = _.without addSets, addSet
		Session.set 'addSets',addSets
		refreshSets()


refreshSets = ->
	addSets = []
	_.each Session.get('addSets'), (addSet)->
		addSets.push addSet
	$('input[name="sets"]').val(addSets.toString())

if Meteor.isClient
	window['refreshSets'] = refreshSets