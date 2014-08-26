<cfcomponent>

	<cfset variables.container = "" />

	<cffunction name="init">
		<cfset variables.container = {
			"app" = This
		} />

		<cfreturn this />
	</cffunction>

	<cffunction name="make">
		<cfargument name="key" required="true" type="string" />

		<cfif not checkExists(arguments.key)>
			<cfoutput>#arguments.key# does not exist.</cfoutput>
			<cfreturn false />
		</cfif>

		<cfreturn variables.container[arguments.key] />
	</cffunction>

	<cffunction name="bind">
		<cfargument name="key" required="true" type="string" />
		<cfargument name="value" required="true" />

		<cfif isObject(arguments.value)>
			<cfset structAppend(variables.container, { "#arguments.key#" = arguments.value }) />
		<cfelse>
			<cfset structAppend(variables.container, { "#arguments.key#" = createObject("component", "#arguments.value#") }) />
		</cfif>

	</cffunction>

	<cffunction name="checkExists">
		<cfargument name="key" required="true" type="string" />

		<cfif structKeyExists(variables.container, arguments.key)>
			<cfreturn true />
		</cfif>

		<cfreturn false />
	</cffunction>

</cfcomponent>