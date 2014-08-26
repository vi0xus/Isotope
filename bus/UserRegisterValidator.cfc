<cfcomponent>

	<cfset variables.errors = structNew() />

	<cfset variables.rules = {
		"username" = "required|between:3,24",
		"email" = "required|email",
		"password" = "required|min:4|max:120"
	} />

	<cffunction name="validate" returnType="struct">
		<cfargument name="command" required="true" type="struct" />
		<cfargument name="input" required="true" type="struct" />

		<!--- handle valdiation --->
		<cfset validator = createObject("component", "base.validation.validator").init(variables.rules, arguments.command) />
		
		<cfif validator.fails()>
			<cfset variables.errors = validator.getErrors() />
		</cfif>

		<cfreturn variables.errors />
	</cffunction>

</cfcomponent>