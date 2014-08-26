<cfcomponent>

	<cfset this.config = {
		"hostname" = "jacob",
		"password" = "pass",
		"hostaddress" = "127.0.0.1",
		"serviceProviders" = {
			"file" = "base.filesystem.filesystemServiceProvider",
			"input" = "base.input.inputServiceProvider",
			"logger" = "base.logger.loggerServiceProvider",
			"router" = "base.router.routerServiceProvider",
			"validation" = "base.validation.validatorServiceProvider",
			"view" = "base.render.viewServiceProvider"
		}
	} />
</cfcomponent>