<!--- called by LUList.cfm --->
<!--- Insert row into table so as to suppress ORANGE duplicate warning --->
<cfquery name="InsertPlayerDuplicateWarnings2" datasource="#request.DSN#" >
	INSERT INTO 
		playerduplicatewarnings 
		(RegNo1, 
		RegNo2, 
		Reason, 
		LeagueCode	)
		VALUES
		( #ThisRegNo1#, 
		  #ThisRegNo2#, 
		  2, 
		  '#request.filter#'	)
</cfquery>
