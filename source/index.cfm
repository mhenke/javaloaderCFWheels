<cfsetting enablecfoutputonly="true">
<cfset javaLoaderMeta = {}>
<cfset javaLoaderMeta.version = "0.3">
<cfoutput>
<cfinclude template="css.cfm">
<h1>javaLoader v#javaLoaderMeta.version#</h1>
<h2>"With a Little Help from My (Java) Friends"</h2>
<p>
JavaLoader is a library that has been built to ease the use, development and integration of Java within ColdFusion applications.  This plugins add the functionally for easy use within Wheels applications.
</p>
<p>
Automatically loads any Java libraries located in a lib folder.
Specify another locations of jars
</p>
<h3>Heads up: The Details</h3>
<p>
This is easy pease to do, as long as you know how to copy a file (and since you're reading this you already know how to do that).
<ol>
<li>If there isn't already a /lib folder in the root of your ColdFusion on Wheels application, create it, all lowercase please boys and girls.</li>
<li>Place any jars you wish to access in the lib folder you added in step 1.</li>
<li>Open the events/onapplicationstart.cfm file</li>
<li>Add the following code into the events/onapplicationstart.cfm file: 
<pre>
&lt;cfset application.javaloader = javaLoader()/&gt;
</pre>
</li>
<li>To load any jars in other locations, do the following:
<pre>
&lt;cfset jarList = "C:\JRun4\servers\Wheels\cfusion.ear\cfusion.war\JavaLoader\lib\jtidy-r938.jar"/&gt;
&lt;application.javaloader = javaLoader(jarList)/&gt;
</pre>
</li>
</ol> 
</p>
<h3>Heads up: Example of Use</h3>
<p>
<pre>
&lt;cfset jTidy = application.javaloader.create("org.w3c.tidy.Tidy").init() /&gt;
</pre>
</p>
</cfoutput>
<cfsetting enablecfoutputonly="false">