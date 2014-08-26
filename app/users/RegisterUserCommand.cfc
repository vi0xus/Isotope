component {

	public component function init(struct input)
	{
		this.username = arguments.input.username;
		this.email = arguments.input.email;
		this.password = arguments.input.password;

		return this;
	}
}