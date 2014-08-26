component {

	public component function init()
	{
		variables.dispatch = createObject("component", "isotope.events.dispatch").init();
		variables.handler = createObject("component", "isotope.events.handler").init();

		return this;
	}

	public void function listen(event, handle) {}
}