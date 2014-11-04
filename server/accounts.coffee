Accounts.onCreateUser (options, user) ->
  user.learning = []
  user.profile = {}

  console.log user

  if user.services.twitter
  	user.username = user.services.twitter.screenName

  if user.services.google
  	user.username = user.services.google.name.split(' ').join('.');

  if user.services.facebook
  	user.username = user.services.facebook.name.split(' ').join('.');
  user