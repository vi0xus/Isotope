component {

	public component function init()
	{
		variables.seed = seed();

		return this;
	}

	public any function encrypt(value, algorithm="AES")
	{
		return Encrypt(arguments.value, variables.seed, arguments.algorithm);
	}

	public any function decrypt(value, algorithm="AES")
	{
		return Decrypt(arguments.value, variables.seed, arguments.algorithm);
	}

	private any function seed(algorithm="AES", keysize="32")
	{
		return GenerateSecretKey(arguments.algorithm);
	}

	public any function make(value, algorithm="SHA")
	{
		return Hash(arguments.value, UCase(arguments.algorithm));
	}

	public boolean function needsRehash()
	{
		return false;
	}

	public boolean function check(value, hash)
	{
		if (make(arguments.value) == arguments.hash)
		{
			return true;
		}

		return false;
	}
}