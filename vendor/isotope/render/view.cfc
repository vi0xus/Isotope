component {

	public component function init(viewFolder)
	{
		variables.defaultViewsFolder = arguments.viewFolder;

		return this;
	}

	public component function with(carry)
	{
		structAppend(variables.with, arguments.carry, false);

		return this;
	}

	public void function make(filename)
	{
		local.splits = "";

		if (find(".", arguments.filename))
		{
			local.split = listToArray(arguments.filename, ".");
			arguments.filename = removechars(arguments.filename, 1, reFind("([^.]*)$", arguments.filename)-1);

			for (var i=1; i <= ArrayLen(local.split); i++)
			{
				if (local.split[i] == arguments.filename)
				{
					continue;
				}

				local.splits = local.splits & local.split[i] & "/";
			}
		}

		local.location = variables.defaultViewsFolder & local.splits & arguments.filename & ".cfm";

		include local.location;
	}
}