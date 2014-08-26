<cfset container = createObject("component", "container") />

<cfset container.bind("logger", "base.logger.logger") />

<cfset return = container.make("logger") />

<cfdump var="#return#" />
