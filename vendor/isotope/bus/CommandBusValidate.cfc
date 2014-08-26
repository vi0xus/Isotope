component {

	public component function execute(command, input)
	{
		local.command = new "#arguments.command#"(arguments.input);
		local.handler = new CommandBusTranslator().toHandler(local.command);
		local.validate = new CommandBusTranslator().toValidator(local.command);

		local.validator = new "#local.validate#"().validate(local.command, arguments.input);

		if ( ! structIsEmpty(local.validator))
		{
			writeDump("#local.validator#");
		}

		return new "#local.handler#"().handle(local.command);
	}
}