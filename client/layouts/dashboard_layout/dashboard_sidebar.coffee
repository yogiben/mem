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
			[0,1,'Today']
			[1,1,'Yesterday']
			[2,1,'2 days ago']
			[3,1,'3 days ago']
			[0,7,'This week']
		]

		combis = _.map combis, (combi)->
			ago = combi[0]
			gap = combi[1]
			combi[0] = moment().subtract(ago + gap,'days').format('YYYY-MM-DD')
			combi[1] = moment().subtract(ago,'days').format('YYYY-MM-DD')
			combi
		console.log combis

		combis