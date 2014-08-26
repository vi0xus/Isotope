<cfcomponent>
	<cfset variables.errors = structNew() />
	<cfset variables.rules = structNew() />
	<cfset variables.input = "" />

	<cffunction name="make">
		<cfargument name="rules" required="true" type="struct" />
		<cfargument name="input" required="true" type="struct" />

		<cfinvoke method="parseInput" input="#arguments.input#" />

		<cfinvoke method="parseRules" rules="#arguments.rules#" />

		<cfreturn this />
	</cffunction>

	<cffunction name="getErrors" returnType="struct">
		<cfreturn variables.errors />
	</cffunction>

	<cffunction name="fails" returnType="boolean">
		<cfinvoke method="validate" />

		<cfif not structIsEmpty(variables.errors)>
			<cfreturn true />
		</cfif>

		<cfreturn false />
	</cffunction>

	<cffunction name="passes" returnType="boolean">
		<cfinvoke method="validate" />

		<cfif structIsEmpty(variables.errors)>
			<cfreturn true />
		</cfif>

		<cfreturn false />
	</cffunction>

	<cffunction name="validate">
		<cfloop collection="#variables.rules#" item="name">
			<!--- validate input exists in struct --->

			<cfloop array="#variables.rules[name]#" index="rule">
				<cfinvoke method="parseRule" rule="#rule#" inputname="#name#">
			</cfloop>

		</cfloop>

	</cffunction>

	<cffunction name="parseInput">
		<cfargument name="input" required="true" type="struct" />

		<cfif structIsEmpty(arguments.input)>
			<cfthrow message="No input was passed" />
		</cfif>

		<cfset variables.input = arguments.input />

	</cffunction>

	<cffunction name="parseRule">
		<cfargument name="rule" required="true" type="string" />
		<cfargument name="inputName" required="true" />

		<cfif rule eq "required">
			<cfinvoke method="required" inputName="#arguments.inputName#" />
		</cfif>

		<cfif reFind("\bbetween", rule) gt 0>
			<cfset local.range = reReplace("#rule#", "\bbetween:", "") />
			<cfinvoke method="between" range="#local.range#" inputName="#arguments.inputName#" />
		</cfif>

		<cfif rule eq "email">
			<cfinvoke method="email" inputName="#arguments.inputname#" />
		</cfif>

		<cfif reFind("\bmin", rule) gt 0>
			<cfset local.range = reReplace("#rule#", "\bmin:", "") />
			<cfinvoke method="min" range="#local.range#" inputName="#arguments.inputName#" />
		</cfif>

		<cfif reFind("\bmax", rule) gt 0>
			<cfset local.range = reReplace("#rule#", "\bmax:", "") />
			<cfinvoke method="max" range="#local.range#" inputName="#arguments.inputName#" />
		</cfif>
<!---
		<cfif reFind("\bip", rule) gt 0>
			<cfinvoke method="ip" inputName="#arguments.inputName#" />
		</cfif>
--->
	</cffunction>

	<cffunction name="parseRules">
		<cfargument name="rules" required="true" type="struct" />

		<cfloop array="#StructKeyArray(arguments.rules)#" index="name">
			<cfset local.rules = listToArray(#arguments.rules[name]#, "|") />

			<cfset structAppend(variables.rules, { "#name#" = local.rules }) />
		</cfloop>

	</cffunction>

	<cffunction name="required">
		<cfargument name="inputName" required="true" type="string" />

		<cfif not structKeyExists(variables.input, arguments.inputName)>
			<cfset structAppend(variables.errors, { "#arguments.inputName#" = "#arguments.inputName# is required." }) />
		</cfif>

	</cffunction>

	<cffunction name="email">
		<cfargument name="inputName" required="true" type="string" />

		<cfif arrayLen(reMatchNoCase("[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,32}", variables.input[arguments.inputName])) eq 0>
			<cfset structAppend(variables.errors, { "#arguments.inputName#" = "#arguments.InputName# must be a valid email address" }) />
		</cfif>

	</cffunction>

	<cffunction name="exists">
	</cffunction>

	<cffunction name="unique">
	</cffunction>

	<cffunction name="between">
		<cfargument name="range" required="true" type="string" />
		<cfargument name="inputName" required="true" type="string" />

		<cfset local.range = listToArray(arguments.range, ",") />
		<cfset local.length = len(variables.input[arguments.inputName]) />

		<cfif (local.length lt local.range[1]) or (local.length gt local.range[2])>
			<cfset structAppend(variables.errors, { "#arguments.inputName#" = "#arguments.inputName# must be between #local.range[1]# and #local.range[2]# characters" }) />
		</cfif>

	</cffunction>

	<cffunction name="min">
		<cfargument name="inputName" required="true" type="string" />
		<cfargument name="range" required="true" type="string" />

		<cfset local.key = variables.input[arguments.inputName] />

		<cfif len(key) lt arguments.range>
			<cfset structAppend(variables.errors, { "#arguments.inputName#" = "#arguments.inputName# must be at least #arguments.range# characters" }) />
		</cfif>

	</cffunction>

	<cffunction name="max">
		<cfargument name="inputName" required="true" type="string" />
		<cfargument name="range" required="true" type="string" />

		<cfset local.key = variables.input[arguments.inputName] />

		<cfif len(key) gt arguments.range>
			<cfset structAppend(variables.errors, { "#arguments.inputName#" = "#arguments.inputName# can not be more than #arguments.range# characters." }) />
		</cfif>

	</cffunction>

	<cffunction name="ip">
		<cfargument name="inputName" required="true" type="string" />

		<cfset local.ip_regex = "\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b" />

		<cfset local.key = variables.input[arguments.inputName] />

		<cfif arrayLen(reMatch(local.ip_regex, key)) eq 0>
			<cfset structAppend(variables.errors, { "#arguments.inputName#" = "#arguments.inputName# must be a valid ip address." }) />
		</cfif>

	</cffunction>

	<cffunction name="integer">
	</cffunction>

	<cffunction name="accepted">
	</cffunction>

	<cffunction name="boolean">
	</cffunction>

	<cffunction name="same">
	</cffunction>

</cfcomponent>