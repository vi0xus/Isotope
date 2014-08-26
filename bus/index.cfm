<cfset bus = createObject("component", "CommandBusValidate") />

<cfset input = createObject("component", "base.input.input") />

<cfset return = bus.execute("UserRegisterCommand", input.all()) />

<cfdump var="#return#" />