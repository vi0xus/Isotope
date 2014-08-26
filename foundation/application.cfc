<cfcomponent>

	<cfset variables.container = structNew() />

	<cffunction name="init">
		<cfset variables.container = createObject("component", "base.ioc.container").init() />
		<cfset variables.container.bind("config", "base.config.configManager") />

		<cfinvoke method="register" />

		<cfreturn variables.container.make("app") />
	</cffunction>

	<cffunction name="register">
		<cfset config = variables.container.make("config") />

		<cfset providers = config.get("serviceProviders")>

		<cfloop collection="#providers#" item="service">
			<cfset variables.container.bind("#service#", createObject("component", providers[service]).register()) />
		</cfloop>
	</cffunction>

</cfcomponent>