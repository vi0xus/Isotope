component extends = "baseController" {

	public component function init()
	{
		Super.init();

		return this;
	}

	public any function home()
	{
		return variables.view.make("home");
	}
}