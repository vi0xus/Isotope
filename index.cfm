<cfset app = createObject("component", "base.foundation.application").init() />

<cfset router = app.make("router") />

<cfset router.get("home", "base.tr3nx.controllers.PagesController", "homepage") />
<cfset router.get("signup", "base.tr3nx.controllers.RegisterController", "store") />

<cfset router.route() />