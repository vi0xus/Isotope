component {

	public boolean function exists(file)
	{
		if (fileExists("#arguments.file#"))
		{
			return true;
		}

		return false;
	}

	public void function put(file, content)
	{
		fileWrite(arguments.file, arguments.content);
	}

	public boolean function makeFile(file)
	{
		local.file = fileOpen(arguments.file, "write");
		fileClose(local.file);

		if (this.exists(arguments.file))
		{
			return true;
		}

		return false;
	}

	public void function prepend(file) {}

	public void function append(file, content)
	{
		local.file = fileOpen(arguments.file, "append");

		fileWrite(local.file, arguments.content);
		fileClose(local.file);
	}

	public boolean function delete(file)
	{
		fileDelete(arguments.file);

		return exisits(arguments.file);
	}

	public boolean function move(file, location)
	{
		if ( ! this.isDirectory(arguments.location))
		{
			writeOutput("#arguments.location# is not a valid location.");

			return false;
		}

		fileMove(arguments.file, arguments.location);

		return this.exists(arguments.location & arguments.file);
	}

	public boolean function copy(file, destination)
	{
		if (this.isDirectory(arguments.destination))
		{
			arguments.destination = arguments.destination & "/" & arguments.file;
		}

		if (exists(arguments.file) and not exists(arguments.destination))
		{
			fileCopy(arguments.file, arguments.destination);
		}

		return exists(arguments.destination);
	}

	public string function extension(file)
	{
		return ListLast(arguments.file, ".");
	}

	public integer function size(file)
	{
		return getFileInfo(arguments.file).size;
	}

	public boolean function isImage(file)
	{
		return isImageFile(arguments.file);
	}

	public any function lastModified(file)
	{
		return getFileInfo(arguments.file).lastmodified;
	}

	public boolean function isDirectory(file)
	{
		if (getFileInfo(arguments.file).type eq "directory")
		{
			return true;
		}

		return false;
	}

	public boolean function isWritable(file)
	{
		return getFileInfo(arguments.file).canwrite;
	}

	public integer function isReadable()
	{
		return getFileInfo(arguments.file).canread;
	}

	public integer function isHidden(file)
	{
		return getFileInfo(arguments.file).ishidden;
	}

	public boolean function isFile(file)
	{
		if (getFileInfo(arguments.file).type eq "file")
		{
			return true;
		}

		return false;
	}

	public any function files(path, recurse=true, type="query")
	{
		return directoryList(arguments.path, arguments.recurse, arguments.type);
	}

	public void function directories(directory) {}

	public boolean function makeDirectory(directory)
	{
		if ( ! this.existsDirectory(arguments.directory))
		{
			directoryCreate(arguments.directory);
		}

		return this.existsDirectory(arguments.directroy);
	}

	public boolean function existsDirectory(directroy)
	{
		return directoryExists(arguments.directory);
	}

	public boolean function copyDirectory(directroy) {}

	public booealn function deleteDirectory(directroy, preserve=false) {}

	public booealn function cleanDirectory(directroy)
	{
		return this.deleteDirectory(arguments.directroy, true);
	}
}