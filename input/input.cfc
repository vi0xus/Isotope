<cfcomponent>

	<cfset variables.input = structNew() />

	<cffunction name="all">
		<cfset structAppend(variables.input, url, false) />
		<cfset structAppend(variables.input, form, false) />

		<cfreturn variables.input />
	</cffunction>

	<cffunction name="get">
		<cfset structAppend(variables.input, url, false) />

		<cfreturn variables.input />
	</cffunction>

	<cffunction name="post">
		<cfset structAppend(variables.input, form, false) />

		<cfreturn variables.input />
	</cffunction>

</cfcomponent>