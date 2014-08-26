<cfcomponent>
	<cffunction name="register">
		<cfreturn createObject("component", "base.builder.db2").init() />
	</cffunction>
</cfcomponent>