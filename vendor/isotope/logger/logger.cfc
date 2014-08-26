component {

	variables.logFile = "messages.log";

	variables.types = {
		"warning" = "! Warning: ",
		"error" = "- Error: ",
		"notice" = "* Notice: ",
		"info" = "## Info: ",
		"debug" = "? Debug: ",
		"success" = "+ Success: "
	};

	public component function init(logFolder)
	{
		variables.logPath = arguments.logFolder;

		variables.fs = application.ioc.make("file");

		variables.logFile = variables.logPath & variables.logFile;

		this.checkLogFile();

		return this;
	}

	public void function checkLogFile()
	{
		if ( ! variables.fs.exists(variables.logFile))
		{
			variables.fs.makeFile(variables.logFile);
		}
	}

	public void function setLogFile(file)
	{
		variables.logFile = arguments.file;

		this.checkLogFile();
	}

	public void function log(type, message)
	{
		local.message = variables.types[arguments.type] & arguments.message & Chr(13) & Chr(10);

		variables.fs.append(variables.logFile, local.message);
	}

	public void function error(message)
	{
		this.log("error", arguments.message);
	}

	public void function info(message)
	{
		this.log("info", arguments.message);
	}

	public void function success(message)
	{
		this.log("success", arguments.message);
	}

	public void function debug(message)
	{
		this.log("debug", arguments.message);
	}

	public void function warning(message)
	{
		this.log("warning", arguments.message);
	}

	public void function notice(message)
	{
		this.log("notice", arguments.message);
	}
}