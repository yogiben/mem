Template.dashboardSidebar.rendered = () ->
	self = @

	$('section.sidebar').affix
		offset:
			top: 1

	@autorun ->
		self.$('.treeview').tree()

Template.dashboardSidebar.events
	'click .recent>a': (e,t) ->
		id = $(e.currentTarget).data('date')
		$('html, body').animate({
		        scrollTop: $('#' + id).offset().top
		    }, 500)

Template.dashboardSidebar.helpers
	dayCombinations: () ->
		[
			[0,1,'Today']
			[1,1,'Yesterday']
			[2,1,'2 days ago']
			[3,1,'3 days ago']
			[4,1,'4 days ago']
			[5,1,'5 days ago']
		]
