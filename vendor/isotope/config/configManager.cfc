component {

	variables.configFile = "/app/config/config";

	public any function get(key)
	{
		local.config = createObject("component", variables.configFile);

		return local.config.config[arguments.key];
	}
}