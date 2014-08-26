<cfcomponent>

	<cffunction name="execute">
		<cfargument name="command" required="true" type="string" />
		<cfargument name="input" required="true" type="struct" />

		<cfset local.command = createObject("component", arguments.command).init(arguments.input) />
		<cfset local.handler = createObject("component", "CommandBusTranslator").toHandler(local.command) />

		<cfreturn createObject("component", local.handler).handle(local.command) />
	</cffunction>

</cfcomponent>