<!--- called by LUList.cfm --->
<!--- Insert row into table so as to suppress YELLOW duplicate warning --->
<cfquery name="InsertPlayerDuplicateWarnings3" datasource="#request.DSN#" >
	INSERT INTO 
		playerduplicatewarnings 
		(RegNo1, 
		RegNo2, 
		Reason, 
		LeagueCode	)
		VALUES
		( #ThisRegNo1#, 
		  #ThisRegNo2#, 
		  3, 
		  '#request.filter#'	)
</cfquery>
