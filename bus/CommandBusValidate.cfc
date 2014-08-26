<cfcomponent>

	<cffunction name="execute">
		<cfargument name="command" required="true" type="string" />
		<cfargument name="input" required="true" type="struct" />

		<cfset local.command = createObject("component", arguments.command).init(arguments.input) />
		<cfset local.handler = createObject("component", "CommandBusTranslator").toHandler(local.command) />
		<cfset local.validate = createObject("component", "CommandBusTranslator").toValidator(local.command) />

		<cfset local.validator = createObject("component", local.validate).validate(local.command, arguments.input) />

		<cfif not structIsEmpty(local.validator)>
			<cfdump var="#local.validator#" />
		</cfif>

		<cfreturn createObject("component", local.handler).handle(local.command) />
	</cffunction>

</cfcomponent>