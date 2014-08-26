<cfcomponent>

	<cffunction name="toHandler" returnType="string">
		<cfargument name="command" required="true" type="component" />

		<cfset local.commandClass = getMetaData(arguments.command).fullname />

		<cfreturn replace(local.commandClass, "Command", "CommandHandler") />
	</cffunction>

	<cffunction name="toValidator" returnType="string">
		<cfargument name="command" required="true" type="component" />

		<cfset local.commandClass = getMetaData(arguments.command).fullname />

		<cfreturn replace(local.commandClass, "Command", "Validator") />
	</cffunction>

</cfcomponent>