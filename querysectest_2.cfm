<cfif CGI.REMOTE_ADDR EQ SERVER_NAME>
	This file has been reached from within: <cfoutput>#CGI.REMOTE_ADDR#</cfoutput>
<cfelse>
	This file has been reached from outside: <cfoutput>#CGI.REMOTE_ADDR#</cfoutput>	
</cfif>
<br /><br />
<cfoutput>This Server: #SERVER_NAME#</cfoutput>

