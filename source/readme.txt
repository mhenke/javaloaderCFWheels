CFWheels with JavaLoader v0.5

http://javaloader.riaforge.org/
http://github.com/mhenke/javaloaderCFWheels

requires:
# Wheels 1.0
 
TO USE
1) Create a lib folder for your jar files under your webroot
	Exampe Of Directory Layout:
	webroot
	==index.cfm
	==IsapiRewrite4.ini
	==Application.cfc
	====wheels
	====views
	====models
	====events
	====controllers
	====lib

2) Place any jars you wish to access in the lib folder you added in step 1.

3) Place the JavaLoader-xx.xx.zip in the plugins folder of Wheels.

4) Add to events/onapplicationstart.cfm this code 
	a)for loading any default jars
		<cfset application.javaloader = javaLoader() />

	b)for loading any default jars plus other locations
		<cfset jarList = "C:\JRun4\servers\Wheels\cfusion.ear\cfusion.war\JavaLoader\lib\jtidy-r938.jar" />
		<cfset application.javaloader = javaLoader(jarList) />

You should be good to go now and able to access the jar.

EXAMPLES OF USE
<!--- example of creating java object--->
<cfset jTidy = application.javaloader.create("org.w3c.tidy.Tidy").init() />
 
ADDITIONAL FOR DEMO 
Unzip the Demo-x.x.zip file into CFWheel's webroot.
 
Reload your Wheels application.
Example: http://localhost/index.cfm?reload=true