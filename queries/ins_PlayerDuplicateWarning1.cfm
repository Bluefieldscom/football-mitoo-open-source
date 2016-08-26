<!--- called by LUList.cfm --->
<!--- Insert row into table so as to suppress RED duplicate warning --->
<cfquery name="InsertPlayerDuplicateWarnings1" datasource="#request.DSN#" >
	INSERT INTO 
		playerduplicatewarnings 
		(RegNo1, 
		RegNo2, 
		Reason, 
		LeagueCode	)
		VALUES
		( #ThisRegNo1#, 
		  #ThisRegNo2#, 
		  1, 
		  '#request.filter#'	)
</cfquery>
