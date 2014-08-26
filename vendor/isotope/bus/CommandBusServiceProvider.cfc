component {
	
	public component function register()
	{
		return new isotope.bus.CommandBus();
	}
}