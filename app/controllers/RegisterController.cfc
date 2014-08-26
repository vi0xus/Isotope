component extends = "baseController" {

	public component function init()
	{
		Super.init();

		return this;
	}

	public any function index()
	{
		return application.ioc.make("view").make("register.form");
	}

	public any function store()
	{
		user = variables.bus.execute("app.users.RegisterUserCommand", variables.input.all());

		return variables.redirect.to("home");
	}
}