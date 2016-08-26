<!--- called twice (Add & Add Many) by Action.cfm --->

<cfif TblName IS "Player">
	<!--- <cfinclude template = "queries/qry_QCheckDuplicatePlayer.cfm">
	 Check to see if this is already in the table 
	<cfif QCheckDuplicatePlayer.RecordCount IS NOT "0"> 
		<LINK REL="stylesheet" type="text/css" href="fmstyle.css">
		<cfoutput query="QCheckDuplicatePlayer">
			<span class="pix24boldred">#Surname#, #Forename# is already in the #TblName#  table<BR><BR></span>
		</cfoutput>
		<span class="pix13">An existing player has the same name. If there really are two players with the same name then differentiate between them by modifying the name of the second player.<BR><BR>
		<span class="pix24boldred">Press the Back button on your browser.....<BR><BR></span>
		<cfabort>
	</cfif>
	--->
<cfelseif TblName IS "Noticeboard">
	<!--- do nothing, Noticeborad is not in the fm200x database --->
<cfelse>
	<cfinclude template = "queries/qry_QCheckDuplicateL.cfm">
	<!--- Check to see if this is already in the table --->
	<cfif QCheckDuplicateL.RecordCount IS NOT "0">
		<LINK REL="stylesheet" type="text/css" href="fmstyle.css">
		<cfoutput query="QCheckDuplicateL">
			<span class="pix24boldred">#LongCol# is already in the #TblName#  table<BR><BR></span>
		</cfoutput>
		<span class="pix24boldred">Press the Back button on your browser.....<BR><BR></span>
	<CFABORT>
	</cfif>
</cfif>


<cfif TblName IS "Player">
	<cfinclude template="queries/ins_Player.cfm">
<cfelseif TblName IS "Referee">
	<cfinclude template="queries/ins_Referee.cfm">
<cfelseif TblName IS "Team">
	<cfinclude template="queries/ins_Team.cfm">	
<cfelseif TblName IS "MatchReport">
	<cfinclude template="queries/ins_MatchReport.cfm">
<cfelseif TblName IS "Noticeboard">
	<cfinclude template="queries/ins_Noticeboard.cfm">
<cfelseif TblName IS "Ordinal" OR TblName IS "Division">
	<cfinclude template="queries/ins_LUTblName_new.cfm">
<cfelse>
	<cfinclude template="queries/ins_LUTblName.cfm">
</cfif>
