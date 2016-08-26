<!--- called by PlayerDuplicateNoWarning.cfm --->
<!--- Insert row into table so as to suppress RED duplicate warning --->
<cfquery name="InsertPlayerDuplicateNoWarnings1" datasource="#request.DSN#" >
	INSERT INTO 
		playerduplicatenowarnings 
		(RegNo1, 
		RegNo2, 
		Reason, 
		LeagueCode	)
		VALUES
		( #url.RegNo1#, 
		  #url.RegNo2#, 
		  1, 
		  '#request.filter#'	)
</cfquery>
