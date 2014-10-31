Template.dashboardSidebar.rendered = () ->
	self = @

	$('section.sidebar').affix
		offset:
			top: 1

	@autorun ->
		self.$('.treeview').tree()

Template.dashboardSidebar.helpers
	dayCombinations: () ->
		combis = [
			[0,0,'Today']
			[1,0,'Yesterday']
			[2,0,'2 days ago']
			[3,0,'3 days ago']
			[0,7,'This week']
			[0,30,'Last 30 days']
		]

		combis = _.map combis, (combi)->
			ago = combi[0]
			gap = combi[1]
			combi[0] = moment().subtract(ago + gap,'days').format('YYYY-MM-DD')
			combi[1] = moment().subtract(ago,'days').format('YYYY-MM-DD')
			combi