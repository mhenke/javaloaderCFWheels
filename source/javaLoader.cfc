<cfcomponent output="false">
	 <cffunction name="init">
		<cfset this.version = "1.0">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="javaLoader" returntype="Any" access="public" output="false"  hint="I return the javaloader object ready for you to create ???">
		<cfargument name="loadPathsList" default="" type="string" hint="a list of absolute paths to jar files" />
		
		<cfscript>
			var loadPaths = createLoadPath(loadPathsList);
			var javaloader = createJavaLoaderObject(loadPaths);
		</cfscript>
		
		<cfreturn javaloader />
	</cffunction>
	
	<cffunction name="createJavaLoaderObject" hint="I return the javaloader object with the jars loaded" returntype="Any">
		<cfargument name="loadPaths" required="true" type="any" />
		
		<cfscript>
			 // access the JavaLoader CFC
			var javaloader = createObject("component", "javaloader.JavaLoader").init(loadPaths);
			// jTidy = javaloader.create("org.w3c.tidy.Tidy").init();
		</cfscript>
		
		<cfreturn javaloader />
	</cffunction>
	
	<cffunction name="createLoadPath" returntype="array" hint="I return an array of all the jars to load">
		<cfargument name="loadPathsList" type="any" default="" />
		
		<cfscript>
		    // create loadPath array
			var loadPaths = ArrayNew(1);
			var dirPath = ReturnWebRootTranslated() & "\lib\";
		</cfscript>
			
		<!--- read directory for jar files --->
		<cfdirectory 
		   action = "list"
		   directory = "#dirPath#"
		   name = "loadMe"
		   filter = "*.jar">
		 
		<!--- add default jars --->
		<cfloop index="i" from="1" to="#loadMe.RecordCount#">
		 	<cfset loadPaths[#i#] = dirPath & loadMe.Name[i] />
		</cfloop>
		
		<cfloop list="#arguments.loadPathsList#" index="i">
			<!--- check if jar exists --->
			<cfif fileExists(#i#)>
		 		<cfset ArrayAppend(loadPaths, "#i#") />
			</cfif>
		</cfloop>
		
		<cfreturn loadPaths />
	</cffunction>
	
	<cffunction name="ReturnWebRootTranslated" returntype="string" hint="Returns the translated (file system) location of the web root directory">
		<cfscript>
		/**
		* Returns the translated (file system) location of the web root directory.
		*
		* @return Returns a string.
		* @author David Whiterod (whiterod.david@saugov.sa.gov.au)
		* @version 1, May 9, 2003
		*/
		var tmpPath = Replace(CGI.SCRIPT_NAME, "/", "\", "ALL");
		return ReplaceNoCase(CGI.PATH_TRANSLATED, tmpPath, "", "ALL");
		</cfscript>
	</cffunction>
</cfcomponent>