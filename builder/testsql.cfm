<cfset id = 1 />

<cfquery datasource="cfartgallery" name="artFindById">
	select * from art where artid = <cfqueryparam value="#id#" cfsqltype="cf_sql_tinyint" />
</cfquery>

<cfset results = "#artFindById#" />

<cfoutput>#results.artid#</cfoutput>
