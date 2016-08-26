
<cfapplication 
	name="FMImports" 
	sessionmanagement="Yes" 
	sessiontimeout="#CreateTimeSpan(0,0,20,0)#" 
	applicationtimeout="#CreateTimeSpan(0,2,20,0)#"
>

<!--- remember to switch OFF the slow query notification in CFAdmin --->

<!--- set defaults ---> 
<cfif NOT StructKeyExists(application, "init")>
	<cflock scope="APPLICATION" type="EXCLUSIVE" timeout="10">
	<cfscript>
		/*application.dataroot		   = 'C:\CFusionMX\wwwroot\FMAccessData'; 
		application.csvroot			   = 'C:\\CFusionMX\\wwwroot\\FMAccessData\\CSV\\';*/

		application.dataroot		   = 'E:\www.football.mitoo.co.uk\database';
		application.csvroot			   = 'E:\\CSVFiles\\';
		
		application.DSN                = 'FM2004';
		application.year               = '2003';
		application.newyear            = '2004';
		application.newseasonname      = '2004-2005 Season';
		application.newseasonstartdate = '2004-08-31';
		application.newseasonenddate   = '2005-05-31';
		application.init               = 1;
		application.failedlist         = '';
	</cfscript>
	</cflock>
</cfif>

<cfsetting showdebugoutput="no">