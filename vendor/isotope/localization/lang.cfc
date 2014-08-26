component {

	public component function init()
	{
		variables.langFolder = application.ioc.make("config").get("langFolder");
		variables.locale = application.ioc.make("config").get("locale");

		return this;
	}

	public any function get(key, with)
	{
		keys = listToArray("#arguments.key#", ".");

		variables.langFile = variables.langFolder & variables.locale & "/" & keys[1];

		local.file = createObject("component", variables.langfile);

		return local.file.lang[keys[2]];
	}

	public boolean function has(lang, key)
	{
		variables.langFile = variables.langFolder & arguments.lang;

		local.file = createObject("component", variables.langfile);

		if (arraylen(structFindKey(local.file, arguments.key)) gt 0)
		{
			return true;
		}

		return false;
	}
}