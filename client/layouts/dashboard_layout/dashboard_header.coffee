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

Template.dashboardHeader.events
	'click .logo': (e,t) ->
		$('html, body').animate({
		        scrollTop: $('body').offset().top
		    }, 500)
