<cfcomponent>

	<cffunction name="handle">
		<cfargument name="command" required="true" type="component" />

		<cfset return = arguments.command.username />

		<cfreturn return />
	</cffunction>

</cfcomponent>