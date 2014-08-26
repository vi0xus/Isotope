component {

	public component function init()
	{
		return this;
	}

	public boolean function put(key, value)
	{
		lock timeout="10" scope="Session" type="Exclusive" {
			Session[arguments.key] = arguments.value;
		}

		return this.has(arguments.key);
	}

	public any function get(key)
	{
		lock timeout="10" scope="Session" type="Exclusive" {
			if (this.has(arguments.key))
			{
				return Session[arguments.key];
			}
		}

		return false;
	}

	public any function pull(key)
	{
		lock timeout="10" scope="Session" type="Exclusive" {
			if (this.has(arguments.key))
			{
				local.value = get(arguments.key);

				this.forget(arguments.key);

				return local.value;
			}
		}

		return false;
	}

	public boolean function has(key)
	{
		lock timeout="10" scope="Session" type="Exclusive" {
			if (arrayLen(structFindKey(Session, arguments.key)) > 0)
			{
				return true;
			}
		}

		return false;
	}

	public boolean function flush()
	{
		local.keep = { "cfid" = 0, "cftoken" = 0, "sessionid" = 0, "urltoken" = 0 };
		
		lock timeout="10" scope="Session" type="Exclusive" {
			for (key in Session)
			{
				if ( ! structKeyExists(local.keep, key))
				{
					this.forget(key);
				}
			}
		}

		return true;
	}

	public boolean function forget(key)
	{
		lock timeout="10" scope="Session" type="Exclusive" {
			StructDelete(Session, arguments.key);
		}

		return this.has(arguments.key);
	}

	public boolean function end()
	{
		StructClear(Session);

		if (structIsEmpty(Session))
		{
			return true;
		}

		return false;
	}

	public void function flash() {}

	public void function reflash() {}
}