component {

	variables.rules = {
		"username" = "required|between:3,24",
		"email" = "required|email",
		"password" = "required|min:4|max:120"
	};

	public struct function validate(command, input)
	{
		validator = application.app.make("validation").make(variables.rules, arguments.command);

		if (validator.fails())
		{
			variables.errors = validator.getErrors();
		}

		return variables.errors;
	}
}