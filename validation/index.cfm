<cfset input = createObject("component", "base.input.input").all() />
<cfset rules = structNew() />

<cfset rules = {
	"username" = "required|between:3,24",
	"email" = "email",
	"password" = "required|min:4|max:120",
	"tos" = "accepted",
	"remember_me" = "boolean",
	"id" = "integer",
	"ip_address" = "ip"
} />

<cfset validator = createObject("component", "validator").make(rules, input) />

<cfif validator.fails()>
	<cfdump var="#validator.getErrors()#" />
</cfif>

<cfif validator.passes()>
	passes
</cfif>
