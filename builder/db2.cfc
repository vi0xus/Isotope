<cfcomponent>
	<cfset variables.database = "cfartgallery" />
	<cfset variables.table = "" />
	<cfset variables.query = "" />
	<cfset variables.from = "" />


	<!--- Init --->
	<cffunction name="init">
		<cfargument name="table" required="true" type="string" />

		<cfset variables.table = arguments.table />
		<cfset variables.from = "select * from " & #variables.table# />

		<cfreturn this />
	</cffunction>

	<!--- From ---> 
	<cffunction name="from">
		<cfargument name="table" required="true" type="string" />

		<cfset variables.table = arguments.table />
		<cfset variables.from = "select * from " & #variables.table# />

		<cfreturn this />
	</cffunction>

	<!--- Where --->
	<cffunction name="where">
		<cfargument name="where" required="false" />
		<cfargument name="col" required="false" />
		<cfargument name="val" required="false" />
		<cfargument name="op" required="false" />

		<cfset var local.where = "" />
		<cfset var local.syntax = "" />

		<cfif structKeyExists(arguments, "col") and structKeyExists(arguments, "val") and not structKeyExists(arguments, "where")>
			<cfif structKeyExists(arguments, "op")>
				<cfset local.where = arguments.col & arguments.op & arguments.val />
			<cfelse>
				<cfset local.where = arguments.col & " = " & arguments.val />
			</cfif>
		<cfelse>
			<cfset local.where = arguments.where />
		</cfif>
		
		<cfif find(" where ", "#variables.query#")>
			<cfset local.syntax = " and " />
		<cfelse>
			<cfset local.syntax = " where " />
		</cfif>

		<cfset variables.query = variables.query & local.syntax & local.where />

		<cfreturn this />
	</cffunction>

	<!--- First --->
	<cffunction name="first">
		<cfquery name="returnFirst" datasource="#variables.database#" maxrows="1">
			#variables.from# #variables.query#
		</cfquery>

		<cfreturn returnFirst />
	</cffunction>

	<!--- Get --->
	<cffunction name="get">
		<cfquery name="returnFirst" datasource="#variables.database#">
			#variables.from# #variables.query#
		</cfquery>

		<cfreturn returnFirst />
	</cffunction>

	<!--- Test --->
	<cffunction name="test">
		<cfoutput>#variables.from# #variables.query#</cfoutput>
	</cffunction>


	<!--- Update --->
	<cffunction name="update">
		<cfargument name="col" required="false" />
		<cfargument name="val" required="false" />

		<cfquery datasource="#variables.database#">
			update #variables.table# set #arguments.col# = #arguments.val# #variables.query#
		</cfquery>

		<cfreturn this />
	</cffunction>


	<!--- associate --->
	<cffunction name="associate">
		<cfargument name="table" required="true" />
		<cfargument name="parentKey" required="true" />
		<cfargument name="childKey" required="false" />

		<!--- duplicate artistid colums bug --->
		<!--- ," & #arguments.table# & "." & #arguments.parentKey# & " --->
		<cfset variables.from = "select * from " & #variables.table# & ", " & #arguments.table# & " " />

		<cfif structKeyExists(arguments, "childKey")>
			<cfset variables.query = variables.query & " where " & #variables.table# & "." & #arguments.parentKey# & "=" & #arguments.table# & "." & #arguments.childKey# />
		<cfelse>
			<cfset variables.query = variables.query & " where " & #variables.table# & "." & #arguments.parentKey# & "=" & #arguments.table# & "." & #arguments.parentKey# />
		</cfif>

		<cfreturn this />
	</cffunction>

</cfcomponent>