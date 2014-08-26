<cfset config = createObject("component", "configManager") />

<cfdump var="#config#" />

<cfset return = config.get("register") />

<cfdump var="#return#" />