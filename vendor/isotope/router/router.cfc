component {

	variables.objRequest = GetPageContext().GetRequest();

	public component function init()
	{
		variables.routes = {
			"get" = structNew(),
			"post" = structNew()
		};

		parseUrl();

		return this;
	}

	public void function get(route, controller, method)
	{
		local.newRoute = {
			"#arguments.route#" = {
				"controller" = application.ioc.make("config").get("controllersFolder") & arguments.controller,
				"method" = arguments.method
			}
		};

		structappend(variables.routes.get, local.newRoute, false);
	}

	public void function post(route, controller, method)
	{
		local.newRoute = {
			"#arguments.route#" = {
				"controller" = application.ioc.make("config").get("controllersFolder") & arguments.controller,
				"method" = arguments.method
			}
		};

		structappend(variables.routes.post, local.newRoute, false);
	}

	public any function route()
	{
		local.headers = getHTTPRequestData();

		if (local.headers.method == "GET")
		{
			if (arraylen(structFindKey(variables.routes.get, variables.uri)) > 0)
			{
				local.route = variables.routes.get[#variables.uri#];
			}
		}
		else if (local.headers.method == "POST")
		{
			if (arraylen(structFindKey(variables.routes.post, variables.uri)) > 0)
			{
				local.route = variables.routes.post[#variables.uri#];
			}
		}

		//local.newController = createObject("component", local.route.controller).init();

		//call = newController[local.route.method];
		//call();

		local.newController = new "#local.route.controller#"();

		return evaluate("local.newController.#local.route.method#()");
	}

	private void function parseUrl()
	{
		local.uri = reReplace("#variables.objRequest.GetRequestUrl()#", ".+\.cfm", "");

		if (len(local.uri) > 1)
		{
			local.uri = reReplace("#local.uri#", "\/", "");
		}

		if (len(local.uri) <= 1)
		{
			local.uri = "home";
		}

		variables.uri = local.uri;
		variables.query = variables.objRequest.GetQueryString();
	}
}