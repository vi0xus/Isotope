component {

	public struct function all()
	{
		structAppend(variables.input, url, false);
		structAppend(variables.input, form, false);

		structDelete(variables.input, "FIELDNAMES");

		return variables.input;
	}

	public struct function get()
	{
		structAppend(variables.input, url, false);

		return variables.input;
	}

	public struct function post()
	{
		structAppend(variables.input, form, false);
		structDelete(variables.input, "FIELDNAMES");

		return variables.input;
	}
}