<cfcomponent>

	<cfset this.username = "" />
	<cfset this.email = "" />
	<cfset this.password = "" />

	<cffunction name="init">
		<cfargument name="input" required="true" type="struct" />

		<cfset this.username = arguments.input.username />
		<cfset this.email = arguments.input.email />
		<cfset this.password = arguments.input.password />

		<cfreturn this />
	</cffunction>

</cfcomponent>