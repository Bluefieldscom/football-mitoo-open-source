<!--- called by PlayerDuplicateNoWarning.cfm --->
<!--- Insert row into table so as to suppress YELLOW duplicate warning --->
<cfquery name="InsertPlayerDuplicateNoWarnings3" datasource="#request.DSN#" >
	INSERT INTO 
		playerduplicatenowarnings 
		(RegNo1, 
		RegNo2, 
		Reason, 
		LeagueCode	)
		VALUES
		( #url.RegNo1#, 
		  #url.RegNo2#, 
		  3, 
		  '#request.filter#'	)
</cfquery>
