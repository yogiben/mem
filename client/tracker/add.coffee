Tracker.autorun ->
	if Session.get 'quick-target' 
		target = Session.get 'quick-target'
		Session.set 'quick-duplicate', Words.findOne {target:target}
	else
		Session.set 'quick-duplicate', null