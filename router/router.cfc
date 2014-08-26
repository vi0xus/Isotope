<cfcomponent>

	<cfset variables.routes = "" />
	<cfset variables.input = "" />
	<cfset variables.uri = "" />
	<cfset variables.query = "" />
	<cfset variables.objRequest = GetPageContext().GetRequest() />

	<cffunction name="init">
		<cfset variables.routes = structNew() />
		<cfset variables.routes = {
			"get" = structNew(),
			"post" = structNew()
		} />

		<cfinvoke method="parseUrl" />

		<cfreturn this />
	</cffunction>

	<cffunction name="get">
		<cfargument name="route" required="true" type="string" />
		<cfargument name="controller" required="true" type="string" />
		<cfargument name="method" required="true" type="string" />

		<cfset local.newRoute = {
			"#arguments.route#"  = {
				"controller" = arguments.controller,
				"method" = arguments.method
			}
		} />

		<cfset structappend(variables.routes.get, local.newRoute, false) />

	</cffunction>

	<cffunction name="route">
		<cfset local.headers = getHTTPRequestData() />

		<cfif local.headers.method eq "GET">

			<cfif arraylen(structFindKey(variables.routes.get, variables.uri)) gt 0 >
				<cfset route = variables.routes.get[#variables.uri#] />

				<cfinvoke component="#route.controller#" method="#route.method#" />
			</cfif>

		<cfelseif local.headers.method eq "POST">

			<cfif arraylen(structFindKey(variables.routes.post, variables.uri)) gt 0 >
				<cfset route = variables.routes.post[#variables.uri#] />

				<cfinvoke component="#route.controller#" method="#route.method#" />
			</cfif>

		</cfif>

	</cffunction>

	<cffunction name="parseUrl">
		<cfset local.uri = reReplace("#objRequest.GetRequestUrl()#", ".+\.cfm", "") />

		<cfif len(local.uri) gt 1 >
			<cfset local.uri = reReplace("#local.uri#", "\/", "") />
		</cfif>

		<cfif len(local.uri) lte 1 >
			<cfset local.uri = "home" />
		</cfif>

		<cfset variables.uri = local.uri />
		<cfset variables.query = objRequest.GetQueryString() />

	</cffunction>

</cfcomponent>