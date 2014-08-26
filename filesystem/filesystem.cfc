<cfcomponent>

	<cffunction name="exists" returnType="boolean">
		<cfargument name="file" required="true" type="string" />

		<cfif fileExists("#arguments.file#")>
			<cfreturn true />
		</cfif>

		<cfreturn false />
	</cffunction>

	<cffunction name="put">
		<cfargument name="file" required="true" type="string" />
		<cfargument name="content" required="true" />

		<cfset fileWrite(arguments.file, arguments.content) />
	</cffunction>

	<cffunction name="makeFile" returnType="boolean">
		<cfargument name="file" required="true" type="string" />

		<cfset local.file = fileOpen(arguments.file, "write") />
		<cfset fileClose(local.file) />

		<cfif exists(arguments.file)>
			<cfreturn true />
		</cfif>

		<cfreturn false />
	</cffunction>

	<cffunction name="prepend">
		<cfargument name="file" required="true" type="string" />

	</cffunction>

	<cffunction name="append">
		<cfargument name="file" required="true" type="string" />
		<cfargument name="content" required="true" />

		<cfset local.file = fileOpen(arguments.file, "append") />
		<cfset fileWrite(local.file, arguments.content) />
		<cfset fileClose(local.file) />

	</cffunction>

	<cffunction name="delete" returnType="boolean">
		<cfargument name="file" required="true" type="string" />

		<cfset fileDelete(arguments.file) />

		<cfreturn exists(arguments.file) />
	</cffunction>

	<cffunction name="move" returnType="boolean">
		<cfargument name="file" required="true" type="string" />
		<cfargument name="location" required="true" type="string" />

		<cfif isDirectory(arguments.location)>
			<cfoutput>#arguments.location# is not a valid location.</cfoutput>
		</cfif>

		<cfset fileMove(arguments.file, arguments.location) />

		<cfreturn exists(arguments.file) />
	</cffunction>

	<cffunction name="copy" returnType="boolean">
		<cfargument name="file" required="true" type="string" />
		<cfargument name="destination" required="true" type="string" />

		<cfif isDirectory(arguments.destination)>
			<cfset arguments.destination = arguments.destination & "/" & arguments.file />
		</cfif>

		<cfif exists(arguments.file) and not exists(arguments.destination)>
			<cfset fileCopy(arguments.file, arguments.destination) />
		</cfif>

		<cfreturn exists(arguments.destination) />
	</cffunction>

	<cffunction name="extension" returnType="string">
		<cfargument name="file" required="true" type="string" />

		<cfreturn ListLast(arguments.file, ".") />
	</cffunction>

	<cffunction name="size" returnType="integer">
		<cfargument name="file" required="true" type="string" />

		<cfreturn getFileInfo(arguments.file).size />
	</cffunction>

	<cffunction name="isImage" returnType="boolean">
		<cfargument name="file" required="true" type="string" />

		<cfreturn isImageFile(arguments.file) />
	</cffunction>

	<cffunction name="lastModified">
		<cfargument name="file" required="true" type="string" />

		<cfreturn getFileInfo(arguments.file).lastmodified />
	</cffunction>

	<cffunction name="isDirectory" returnType="boolean">
		<cfargument name="file" required="true" type="string" />

		<cfif getFileInfo(arguments.file).type eq "directory">
			<cfreturn true />
		</cfif>

		<cfreturn false />
	</cffunction>

	<cffunction name="isWritable" returnType="boolean">
		<cfargument name="file" required="true" type="string" />

		<cfreturn getFileInfo(arguments.file).canwrite />
	</cffunction>

	<cffunction name="isReadable" returnType="integer">
		<cfargument name="file" required="true" type="string" />

		<cfreturn getFileInfo(arguments.file).canread />
	</cffunction>

	<cffunction name="isHidden" returnType="integer">
		<cfargument name="file" required="true" type="string" />

		<cfreturn getFileInfo(arguments.file).ishidden />
	</cffunction>

	<cffunction name="isFile" returnType="boolean">
		<cfargument name="file" required="true" type="string" />

		<cfif getFileInfo(arguments.file).type eq "file">
			<cfreturn true />
		</cfif>

		<cfreturn false />
	</cffunction>

	<cffunction name="files">
		<cfargument name="path" required="true" type="string" />
		<cfargument name="recurse" required="false" type="boolean" />
		<cfargument name="type" required="false" type="string" />

		<cfreturn directoryList(arguments.path, arguments.recurse, arguments.type) />
	</cffunction>

	<cffunction name="directories">
		<cfargument name="directory" required="true" type="string" />
	</cffunction>

	<cffunction name="makeDirectory" returnType="boolean">
		<cfargument name="directory" required="true" type="string" />

		<cfif not existsDirectory(arguments.directory)>
			<cfset directoryCreate(arguments.directory) />
		</cfif>

		<cfreturn existsDirectory(arguments.directroy) />
	</cffunction>

	<cffunction name="existsDirectory" returnType="boolean">
		<cfargument name="directory" reuqired="true" type="string" />

		<cfreturn directoryExists(arguments.directory) />
	</cffunction>

	<cffunction name="copyDirectory" returnType="boolean">
		<cfargument name="directory" required="true" type="string" />
	</cffunction>

	<cffunction name="deleteDirectory" returnType="boolean">
		<cfargument name="directory" required="true" type="string" />
		<cfargument name="preserve" required="false" type="boolean" />

		<!--- delete all files in directory and directory itself unless "preserve" is true --->
	</cffunction>

	<cffunction name="cleanDirectory" returnType="boolean">
		<cfargument name="directory" required="true" type="string" />

		<cfreturn deleteDirectory(arguments.directory, true) />
	</cffunction>

</cfcomponent>