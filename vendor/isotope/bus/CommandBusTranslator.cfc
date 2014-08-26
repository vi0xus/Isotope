component {

	public string function toHandler(component command)
	{
		local.commandClass = getMetaData(arguments.command).fullname;

		return replace(local.commandClass, "Command", "CommandHandler");
	}
	
	public string function toValidator(command)
	{
		local.commandClass = getMetaData(arguments.command).fullname;

		return replace(local.commandClass, "Command", "Validator");
	}
}