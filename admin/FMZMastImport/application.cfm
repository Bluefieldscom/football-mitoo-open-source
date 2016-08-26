
<cfapplication 
	name="FMZMastImports" 
	sessionmanagement="Yes" 
	sessiontimeout="#CreateTimeSpan(0,0,20,0)#" 
	applicationtimeout="#CreateTimeSpan(0,2,20,0)#"
>
<!--- remember to switch OFF the slow query notification in CFAdmin --->

<!--- set defaults ---> 
<cfif NOT IsDefined("application.init")>
	<cflock scope="APPLICATION" type="EXCLUSIVE" timeout="10">
	<cfscript>
		application.dataroot		   = 'E:\www.football.mitoo.co.uk\database'; 
		application.csvroot			   = 'E:\\CSVFiles\\';
		application.init               = 1;
	</cfscript>
	</cflock>
</cfif>

<cfsetting showdebugoutput="yes">