<cfcomponent>

	<cfset variables.bus = createObject("component", "base.bus.CommandBusValidate") />
	<cfset variables.input = createObject("component", "base.input.input") />

	<cffunction name="store">
		<cfset return = bus.execute("base.jacob.users.RegisterUserCommand", variables.input.all()) />

	</cffunction>

</cfcomponent>
