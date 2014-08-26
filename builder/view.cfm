<cfinclude template="core.cfm" />

<cfif not structKeyExists(url, "id")>
	Error no id given.
	<a href="index.cfm">Back</a><br>
	<cfreturn />
</cfif>

<cfset id = url['id'] />

<cfset return = art.where(col="artid", val=#variables.id#).first() />

<a href="index.cfm">Back</a><br>

<cfoutput query="return">
	<h1>#artname#</h1>
	<p>#description#</p>
	<cfif #issold# eq 0>
		<p>$#price# - <a href="buy.cfm?id=#variables.id#">Buy</a></p>
	<cfelse>
		<p>This art has already been sold</p>
	</cfif>
	<img src="#largeimage#" />

</cfoutput>

<br><br><br>
<cfdump var="#return#" />