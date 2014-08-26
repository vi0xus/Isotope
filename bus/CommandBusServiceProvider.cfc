<cfcomponent>
	<cffunction name="register">
		<cfreturn createObject("component", "base.bus.CommandBus") />
	</cffunction>
</cfcomponent>