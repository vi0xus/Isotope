<cfcomponent>

	<cfset variables.fs = "" />
	<cfset variables.logFile = "messages.log" />
	<cfset variables.logPath = "" />

	<cfset variables.types = {
		"warning" = "! Warning: ",
		"error" = "- Error: ",
		"notice" = "* Notice: ",
		"info" = "## Info: ",
		"debug" = "? Debug: ",
		"success" = "+ Success: "
	} />

	<cffunction name="init">
		<cfargument name="logPath" required="true" type="string" />
		<cfset variables.logPath = arguments.logPath />

		<cfset variables.fs = createObject("component", "base.filesystem.filesystem") />

		<cfset variables.logFile = variables.logPath & variables.logFile />

		<cfinvoke method="checkLogFile" />

		<cfreturn this />
	</cffunction>

	<cffunction name="checkLogFile" returnType="void">
		<cfif not variables.fs.exists(variables.logFile)>
			<cfset variables.fs.makeFile(variables.logFile) />
		</cfif>
	</cffunction>

	<cffunction name="setLogFile" returnType="void">
		<cfargument name="file" required="true" type="string" />

		<cfset variables.logFile = arguments.file />

		<cfinvoke method="checkLogFile" />
	</cffunction>

	<cffunction name="log">
		<cfargument name="type" required="true" type="string" />
		<cfargument name="message" required="true" type="string" />

		<cfset local.message = variables.types[arguments.type] & arguments.message & Chr(13) & Chr(10) />

		<cfset variables.fs.append(variables.logFile, local.message) />
	</cffunction>

	<cffunction name="error">
		<cfargument name="message" required="true" type="string" />

		<cfinvoke method="log" type="error" message="#arguments.message#" />
	</cffunction>

	<cffunction name="info">
		<cfargument name="message" required="true" type="string" />

		<cfinvoke method="log" type="info" message="#arguments.message#" />
	</cffunction>

	<cffunction name="success">
		<cfargument name="message" required="true" type="string" />

		<cfinvoke method="log" type="success" message="#arguments.message#" />
	</cffunction>

	<cffunction name="debug">
		<cfargument name="message" required="true" type="string" />

		<cfinvoke method="log" type="debug" message="#arguments.message#" />
	</cffunction>

	<cffunction name="warning">
		<cfargument name="message" required="true" type="string" />

		<cfinvoke method="log" type="warning" message="#arguments.message#" />
	</cffunction>

	<cffunction name="notice">
		<cfargument name="message" required="true" type="string" />

		<cfinvoke method="log" type="notice" message="#arguments.message#" />
	</cffunction>

</cfcomponent>