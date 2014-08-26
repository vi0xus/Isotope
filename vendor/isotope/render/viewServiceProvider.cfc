component {

	public component function register()
	{
		return new isotope.render.view(application.ioc.make("config").get("viewsFolder"));
	}
}