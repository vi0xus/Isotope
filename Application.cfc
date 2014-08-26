component {

	application.name = "isotope" & hash(getCurrentTemplatePath());
	application.applicationTimeout = CreateTimeSpan(0, 0, 5, 0);
	application.sessionmanagement = true;
	application.setclientcookie = false;
	application.sessiontimeout = CreateTimeSpan(0, 0, 5, 0);
	application.ormenabled = true;
	application.datasource = "isotope";
	application.ormsettings.dbcreate = "update";
	application.ormsettings.dialect = "MicrosoftSQLServer";
	application.benchmark = { "init" = now() };

	public void function onApplicationStart()
	{
		writeDump("CALL: onApplicationStart");
	}

	public void function onApplicationEnd()
	{
		writeDump("CALL: onApplicationEnd");
	}

	public boolean function onRequestStart(page)
	{
		application.ioc = new isotope.ioc.container();
		application.ioc.bind("config", "isotope.config.configManager");

		registerServiceProviders();

		variables.router = application.ioc.make("router");

		variables.router.get(route="home", controller="PagesController", method="home");

		variables.router.get(route="login", controller="AuthController", method="index");
		variables.router.post(route="login", controller="AuthController", method="login");

		variables.router.get(route="signup", controller="RegisterController", method="index");
		variables.router.post(route="signup", controller="RegisterController", method="store");

		return true;
	}

	public void function onRequest(page)
	{
		variables.router.route();
	}

	public void function onRequestEnd()	{}

	private void function registerServiceProviders()
	{
		config = application.ioc.make("config");

		providers = config.get("serviceProviders");

		for(service in providers)
		{
			application.ioc.bind("#service#", new "#providers[service]#"().register());
		}
	}
}