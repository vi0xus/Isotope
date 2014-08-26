component extends = "baseController" {

	public component function init()
	{
		Super.init();

		return this;
	}

	public any function index()
	{
		return variables.view.make("login.form");
	}

	public any function login()
	{
		writeDump(variables.input.all());
	}

	public any function logout()
	{
		variables.session.end();

		variables.redirect.to("home");
	}
}