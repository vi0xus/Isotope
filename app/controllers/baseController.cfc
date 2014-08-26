component {

	public component function init()
	{
		variables.bus = new isotope.bus.CommandBusValidate();

		variables.view = application.ioc.make("view");
		variables.input = application.ioc.make("input");
		variables.session = application.ioc.make("session");
		variables.redirect = application.ioc.make("redirect");

		return this;
	}
}