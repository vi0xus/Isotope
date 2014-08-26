<cfinclude template="core.cfm" />

<cfif not structKeyExists(url, "id")>
	Error no id given.
	<a href="index.cfm">Back</a><br>
	<cfreturn />
</cfif>

<cfset id = url['id'] />

<cfset return = art.where(col="artid", val=#variables.id#).update(col="issold", val="1") />

Bought <a href="index.cfm">Back</a><br>

<br><br><br>
<cfdump var="#return#" />