component {

	variables.container = structNew();

	public component function init()
	{
		return this;
	}

	public any function make(key)
	{
		if ( ! checkExists(arguments.key))
		{
			writeOutput(arguments.key & " not registered.");

			return false;
		}

		return variables.container[arguments.key];
	}

	public any function bind(key, value)
	{
		if (this.checkExists(arguments.key))
		{
			writeDump(arguments.key & " is already registered.");

			return false;
		}

		if (isObject(arguments.value))
		{
			structAppend(variables.container, { "#arguments.key#" = arguments.value });
		}
		else
		{
			structAppend(variables.container, { "#arguments.key#" = new "#arguments.value#"() });
		}
	}

	public boolean function checkExists(key)
	{
		if (structKeyExists(variables.container, arguments.key))
		{
			return true;
		}

		return false;
	}
}