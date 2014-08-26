<cfset router = createObject("component", "router").init() />

<cfset router.get(route="home", controller="PagesController", method="home") />
<cfset router.get(route="about", controller="PagesController", method="about") />

<cfset router.route() />