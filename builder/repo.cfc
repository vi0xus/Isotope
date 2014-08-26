<cfcomponent extends="db2" output="false">

	<cfset variables.table = "" />

	<cffunction name="init">
		<cfargument name="table" required="true" type="string" />

		<cfset variables.table = arguments.table />

		<cfreturn this />
	</cffunction>

	<cffunction name="all">
		<cfreturn Super.from("#variables.table#").get() />
	</cffunction>

	<cffunction name="findById">
		<cfargument name="id" required="true" type="numeric" />

		<cfreturn Super.from("#variables.table#").first() />
	</cffunction>

	<cffunction name="findWhere">
		<cfargument name="where" required="true" type="string" />

		<cfreturn Super.from("#variables.table#").where("#arguments.where#").get() />
	</cffunction>

</cfcomponent>