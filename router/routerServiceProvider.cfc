<cfcomponent>

	<cffunction name="register">
		<cfreturn createObject("component", "base.router.router").init() />
	</cffunction>

</cfcomponent>