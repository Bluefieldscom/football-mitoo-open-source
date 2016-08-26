<!--- called by InclInsrtEmailAddr.cfm --->

<cfquery name="InsrtEmailAddress" datasource="ZMAST" >
	INSERT INTO
		userdetail ( EmailAddr, DateTimeStamp )
		VALUES     ('#request.EmailAddr#', #CreateODBCDateTime(Now())# )
</cfquery>
