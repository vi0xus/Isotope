<cfcomponent>

	<cfset variables.configFile = "config" />

	<cffunction name="get">
		<cfargument name="key" required="true" string="true" />

		<cfset local.config = createObject("component", variables.configFile) />

		<cfreturn local.config.config[arguments.key] />
	</cffunction>

</cfcomponent>