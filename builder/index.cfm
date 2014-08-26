<cfinclude template="core.cfm" />

<cfset return = art.associate("artists", "artistid").where("issold = 0").get() />

<ul>
<cfoutput query="return">
	<li><a href="view.cfm?id=#artid#">#artname#</li></a>
</cfoutput>
</ul>

<br><br><br>
<cfdump var="#return#" />