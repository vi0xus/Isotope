component {

	this.config = {
		"hostname" = "jacob",
		"password" = "pass",
		"hostaddress" = "127.0.0.1",
		"viewsFolder" = "/app/views/",
		"langFolder" = "/app/lang/",
		"logFolder" = "app.storage.logs",
		"controllersFolder" = "/app/controllers/",
		"locale" = "en",
		"serviceProviders" = {
			"file" = "isotope.filesystem.filesystemServiceProvider",
			"input" = "isotope.input.inputServiceProvider",
			"redirect" = "isotope.redirection.redirectServiceProvider",
			"lang" = "isotope.localization.langServiceProvider",
			"cryptor" = "isotope.security.cryptorServiceProvider",
			"logger" = "isotope.logger.loggerServiceProvider",
			"router" = "isotope.router.routerServiceProvider",
			"db" = "isotope.db.dbServiceProvider",
			//"bus" = "isotope.bus.commandBusServiceProvider",
			"session" = "isotope.session.storeServiceProvider",
			"validation" = "isotope.validation.validatorServiceProvider",
			"view" = "isotope.render.viewServiceProvider"
		}
	};
}