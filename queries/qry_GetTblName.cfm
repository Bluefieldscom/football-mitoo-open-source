<!--- Called by UpdateForm.cfm --->

<!--- 
possible tables:
Referee, NewsItem, Committee, Division, KORound, Ordinal, Team,
Player, MatchReport, Rule,  NO default... 
--->

<cfswitch expression="#TblName#">
	<cfcase value="Division">
		<cfinclude template = "qry_GetTblNameDivision.cfm">
	</cfcase>
	
	<cfcase value="Committee">
		<cfinclude template = "qry_GetTblNameCommittee.cfm">
	</cfcase>	

	<cfcase value="newsitem">
		<cfinclude template = "qry_GetTblNameNewsItem.cfm">
	</cfcase>		

	<cfcase value="Ordinal">
		<cfinclude template = "qry_GetTblNameOrdinal.cfm">
	</cfcase>
		
	<cfcase value="KORound">
		<cfinclude template = "qry_GetTblNameKORound.cfm">
	</cfcase>	

	<cfcase value="Team">
		<cfinclude template = "qry_GetTblNameTeam.cfm">
	</cfcase>	

	<cfcase value="Player">
		<cfinclude template = "qry_GetTblNamePlayer.cfm">
	</cfcase>	

	<cfcase value="MatchReport">
		<cfinclude template = "qry_GetTblNameMatchReport.cfm">
	</cfcase>	

	<cfcase value="Referee">
		<cfinclude template = "qry_GetTblNameReferee.cfm">
	</cfcase>	

	<cfcase value="Rule">
		<cfinclude template = "qry_GetTblNameRule.cfm">
	</cfcase>	

	<cfcase value="Venue">
		<cfinclude template = "qry_GetTblNameVenue.cfm">
	</cfcase>	
</cfswitch>


