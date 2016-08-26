<!--- called by SwapHomeAway.cfm --->
<cfquery name="Q10004" datasource="#request.DSN#">
	UPDATE
		appearance
	SET
		HomeAway = <cfif Q10003.HomeAway IS 'H'>'A'<cfelse>'H'</cfif>
	WHERE
		ID = #Q10003.ID#
</cfquery>
