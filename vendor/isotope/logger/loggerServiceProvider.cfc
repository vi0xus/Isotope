component {

	public component function register()
	{
		return new isotope.logger.logger(application.ioc.make("config").get("logFolder"));
	}
}