<cfcomponent output="false">
	 <cffunction name="init">
		<cfset this.version = "1.0.0">
		
		<cfreturn this>
	</cffunction>
	
	<cffunction name="javaLoader" returntype="Any" access="public" output="false"  hint="I return the javaloader object ready for you to create ???">
		<cfargument name="loadPathsArray" default="#ArrayNew(1)#" type="array" hint="an array of absolute paths to jar files" />
		
		<cfscript>
			var loadPaths = createLoadPath(arguments.loadPathsArray);
			var javaloader = createJavaLoaderObject(loadPaths);
		</cfscript>
		
		<cfreturn javaloader />
	</cffunction>
	
	<cffunction name="createJavaLoaderObject" hint="I return the javaloader object with the jars loaded" returntype="Any">
		<cfargument name="loadPaths" required="true" type="array" />
		
		<cfscript>
			var javaloader = createObject("component", "plugins.javaloader.JavaLoader.Javaloader").init(arguments.loadPaths, 'true');
		</cfscript>
		
		<cfreturn javaloader />
	</cffunction>
	
	<cffunction name="createLoadPath" returntype="array" hint="I return an array of all the jars to load">
		<cfargument name="loadPathsArray" type="array" default="" />
		
		<cfscript>
			var loadMe = "";
			var i = "";
		    // create loadPath array
			var loadPaths = ArrayNew(1); 
			var dirPath = ReturnWebRootTranslated() & "/lib/";
			var proxyJar = ReturnWebRootTranslated() & "/plugins/javaloader/javaLoader/support/cfcdynamicproxy/lib/cfcdynamicproxy.jar";
		</cfscript>
		
		<!--- read directory for jar files --->
		<cfdirectory 
		   action = "list"
		   directory = "#dirPath#"
		   name = "loadMe"
		   filter = "*.jar">
		 
		<!--- add default jars in lib folder --->
		<cfloop index="i" from="1" to="#loadMe.RecordCount#">
		 	<cfset loadPaths[#i#] = dirPath & loadMe.Name[i] />
		</cfloop>
		
		<!--- add explicitily set jars --->
		<cfloop array="#arguments.loadPathsArray#" index="i">
			<!--- check if jar exists --->
			<cfif fileExists(#i#)>
		 		<cfset ArrayAppend(loadPaths, "#i#") />
			</cfif>
		</cfloop>

		<cfset ArrayPrepend(loadPaths, "#proxyJar#") />

		<cfreturn loadPaths />
	</cffunction>
	
	<cffunction name="ReturnWebRootTranslated" access="public" returntype="string" hint="Returns the translated (file system) location of the web root directory">
		<cfscript>
		/**
		* Returns the translated (file system) location of the web root directory.
		*
		* @return Returns a string.
		* @author David Whiterod (whiterod.david@saugov.sa.gov.au)
		* @version 1, May 9, 2003
		*/
		var tmpPath = Replace(CGI.SCRIPT_NAME, "/", "\", "ALL");
		return Replace(ReplaceNoCase(CGI.PATH_TRANSLATED, tmpPath, "", "ALL"), "\", "/", "ALL");
		</cfscript>
	</cffunction>
</cfcomponent>