component {

	public component function make(struct rules, struct input)
	{
		this.parseInput(arguments.input);
		this.parseRules(arguments.rules);

		return this;
	}

	public struct function getErrors()
	{
		return variables.errors;
	}

	public boolean function passes()
	{
		this.validate();

		if (structIsEmpty(variables.errors))
		{
			return true;
		}

		return false;
	}

	public boolean function fails()
	{
		return ( ! this.passes());
	}

	private void function validate()
	{
		for (var name in variables.rules)
		{
			for (var i = 1; i < arrayLen(variables.rules[name]); i++)
			{
				this.parseRule(rule, name);
			}
		}
		/*
		<cfloop collection="#variables.rules#" item="name">
			<cfloop array="#variables.rules[name]#" index="rule">
				<cfinvoke method="parseRule" rule="#rule#" inputname="#name#">
			</cfloop>
		</cfloop>
		*/
	}

	private void function parseInput(struct input)
	{
		if (structIsEmpty(arguments.input))
		{
			throw (message="No input was passed");
		}

		variables.input = arguments.input;
	}

	private void function parseRule(rule, inputName)
	{
		if (rule == "required")
		{
			this.required(variables.inputName);
		}

		if (reFind("\bbetween", rule) > 0)
		{
			local.range = reReplace("#rule#", "\bbetween:", "");

			this.between(arguments.inputName, local.range);
		}

		if (rule == "email")
		{
			this.email(arguments.inputName);
		}

		if (reFind("\bmin", rule) > 0)
		{
			local.range = reReplace("#rule#", "\bmin:", "");

			this.validateMin(arguments.inputName, local.range);
		}

		if (reFind("\bmax", rule) > 0)
		{
			local.range = reReplace("#rule#", "\bmax:", "");

			this.validateMax(arguments.inputName, local.range);
		}
	}

	private void function parseRules(struct rules)
	{
		for(var i = 1; i < structlen(arguments.rules); i++)
		{
			local.rules = listToArray(arguments.rules[i], "|");

			structAppend(variables.rules, { "#arguments.rules[i]#" = local.rules });
		}
		/*
		<cfloop array="#StructKeyArray(arguments.rules)#" index="name">

			<cfset local.rules = listToArray(#arguments.rules[name]#, "|") />
			
			<cfset structAppend(variables.rules, { "#name#" = local.rules }) />

		</cfloop>
		*/
	}

	private void function required(inputName)
	{
		if ( ! structKeyExists(variables.input, arguments.inputName))
		{
			structAppend(variables.errors, { "#arguments.inputName#" = "#arguments.inputName# is required." });
		}
	}

	private void function email(inputName)
	{
		if (arrayLen(reMatchNoCase("[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,32}", variables.input[arguments.inputName])) == 0)
		{
			structAppend(variables.errors, { "#arguments.inputName#" = "#arguments.InputName# must be a valid email address" });
		}
	}

	private void function between(inputName, range)
	{
		local.range = listToArray(arguments.range, ",");
		local.length = len(variables.input[arguments.inputName]);

		if ((local.length < local.range[1]) or (local.length > local.range[2]))
		{
			structAppend(variables.errors, { "#arguments.inputName#" = "#arguments.inputName# must be between #local.range[1]# and #local.range[2]# characters" });
		}
	}

	private void function validateMin(inputName, range)
	{
		local.key = variables.input[arguments.inputName];

		if (len(key) < arguments.range)
		{
			structAppend(variables.errors, { "#arguments.inputName#" = "#arguments.inputName# must be at least #arguments.range# characters" });
		}
	}

	private void function validateMax(inputName, range)
	{
		local.key = variables.input[arguments.inputName];

		if (len(key) > arguments.range)
		{
			structAppend(variables.errors, { "#arguments.inputName#" = "#arguments.inputName# can not be more than #arguments.range# characters." });
		}
	}

	private void function ip(inputName)
	{
		local.ip_regex = "\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b";

		local.key = variables.input[arguments.inputName];

		if (arrayLen(reMatch(local.ip_regex, key)) == 0)
		{
			structAppend(variables.errors, { "#arguments.inputName#" = "#arguments.inputName# must be a valid ip address." });
		}
	}

	private void function exists() {}

	private void function unique() {}

	private void function integer() {}

	private void function accepted() {}

	private void function boolean() {}

	private void function same() {}
}