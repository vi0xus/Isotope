<cfset logger = createObject("component", "logger").init(GetDirectoryFromPath(GetCurrentTemplatePath())) />

<cfset logger.error("IT WORKS!") />
<cfset logger.notice("IT WORKS!") />
<cfset logger.success("IT WORKS!") />
<cfset logger.warning("IT WORKS!") />
<cfset logger.info("IT WORKS!") />
<cfset logger.debug("IT WORKS!") />

<cfdump var="#logger#" />