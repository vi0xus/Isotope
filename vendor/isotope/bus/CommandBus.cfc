component {

	public component function execute(command, input)
	{
		local.command = new "#arguments.command#"(arguments.input);
		local.handler = new CommandBusTranslator().toHandler(local.command);

		return new local.handler().handle(local.command);
	}
}