<cfcomponent output="false">

	<cfset variables.database = "cfartgallery" />
	<cfset variables.query = "" />


	<!--- select --->
	<cffunction name="select" output="false">
		<cfinvoke method="setQuery" query="select * " />
	</cffunction>


	<!--- from --->
	<cffunction name="from" output="false">
		<cfinvoke method="setQuery" query=" from #arguments.table#" />
	</cffunction>


	<!--- where --->
	<cffunction name="where" output="false">
		<cfinvoke method="setQuery" query=" where " />
	</cffunction>


	<!--- get --->
	<cffunction name="get" output="false">
		<cfinvoke method="select" />
		<cfinvoke method="from" table="#arguments.table#" />

		<cfoutput>#variables.query#</cfoutput>
	</cffunction>


	<!--- first --->
	<cffunction name="first">
		<cfinvoke method="select" />
		<cfinvoke method="from" table="#arguments.table#" />
		<cfinvoke method="setQuery" query=" where issold=0 " />

		<cfquery name="results" datasource="#variables.database#" maxrows=1>
			#variables.query#
		</cfquery>

		<cfreturn results />
	</cffunction>


	<!--- setQuery --->
	<cffunction name="setQuery">
		<cfargument name="query" required="true" />
		<cfset variables.query = variables.query & arguments.query />
	</cffunction>


</cfcomponent>