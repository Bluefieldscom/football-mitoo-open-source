<!--- called by PlayerDuplicateNoWarning.cfm --->
<!--- Insert row into table so as to suppress ORANGE duplicate warning --->
<cfquery name="InsertPlayerDuplicateNoWarnings2" datasource="#request.DSN#" >
	INSERT INTO 
		playerduplicatenowarnings 
		(RegNo1, 
		RegNo2, 
		Reason, 
		LeagueCode	)
		VALUES
		( #url.RegNo1#, 
		  #url.RegNo2#, 
		  2, 
		  '#request.filter#'	)
</cfquery>
