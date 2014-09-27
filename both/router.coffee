Router.configure
  layoutTemplate: "masterLayout"
  loadingTemplate: "Loading"
  notFoundTemplate: "NotFound"
  routeControllerNameConverter: "camelCase"

Router.onBeforeAction "loading"
Router.map ->
  
  @route "home",
    path: "/"
    layoutTemplate: "homeLayout"

  @route "profile",
    path: "/profile"

  @route "languages",
    path: "/languages/"
    layoutTemplate: "dashboardLayout"
    action: ->
      Session.set 'title', 'Languages'
      Session.set 'subtitle', 'What are you trying to learn?'
      @render()

  @route "test",
    path: "/test/"
    layoutTemplate: "testLayout"
    action: ->
      if Session.get('TestQueue').length > Config.testLength
        Session.set 'Testing', Session.get('TestQueue').splice(0,Config.testLength) 
      else
        Session.set 'Testing', Session.get('TestQueue')
      Session.set('CurrentTestItem',Session.get('Testing')[0])
      @render()


  @route "add",
    path: "/:username/add"
    layoutTemplate: "dashboardLayout"
    action: ->
      Session.set 'language', @params.language
      @render()

  @route "addL",
    template: 'add'
    path: "/:username/:language/add"
    layoutTemplate: "dashboardLayout"
    action: ->
      Session.set 'language', @params.language
      @render()

  @route "dashboard",
    path: "/:username"
    layoutTemplate: "dashboardLayout"
    action: ->
      Session.set 'title','Dashboard'
      Session.set 'subtitle','Learn learn learn'
      Session.set 'language',null
      @render()
      
  @route "language",
    path: "/:username/:language/"
    layoutTemplate: "dashboardLayout"
    action: ->
      Session.set 'language', @params.language
      Session.set 'title', Languages[@params.language].name
      Session.set 'subtitle', 'Learning ' + 666 + ' of ' + Session.get('Words').length + ' words'
      Session.set 'set', null
      @render()

  @route "words",
    path: "/:username/:language/all"
    template: 'language'
    layoutTemplate: "dashboardLayout"
    action: ->
      Session.set 'language', @params.language
      Session.set 'title', Languages[@params.language].name
      Session.set 'subtitle', 'Learning ' + 666 + ' of ' + Session.get('Words').length + ' words'
      Session.set 'set', null
      @render()

  @route "set",
    path: "/:username/:language/:set"
    template: 'language'
    layoutTemplate: "dashboardLayout"
    action: ->
      Session.set 'language', @params.language
      Session.set 'title', @params.set
      Session.set 'subtitle', 'Learning ' + 666 + ' of ' + Session.get('Words').length + ' words'
      Session.set 'set', @params.set
      @render()

Router.waitOn ->
  Meteor.subscribe 'user'