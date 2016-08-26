<!--- Called by TeamsNotPlayingToday.cfm --->
<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<!--- ThisTOID is passed as a parameter. It is the corresponding TeamID and OrdinalID for the button that was clicked.
      They are joined with a - dash. e.g. 14907-107 --->
<cfset LengthThisTOID = Len(ThisTOID)>	                <!--- e.g. 9 --->
<cfset DashPosition = Find("-", ThisTOID)>              <!--- e.g. 6 --->
<cfset LengthTID = DashPosition - 1 >                   <!--- e.g. 6 - 1 = 5 --->
<cfset LengthOID = LengthThisTOID - DashPosition>       <!--- e.g. 9 - 6 = 3 --->
<cfset FreeTID = Left(ThisTOID,LengthTID) >             <!--- e.g. 14907 --->
<cfset FreeOID = Right(ThisTOID,LengthOID) >            <!--- e.g. 107 --->
<cfinclude template="queries/qry_QGetFreeDay.cfm">
<cfif QGetFreeDay.RecordCount IS 1> <!--- Turn OFF - UNAVAILABLE/FREE DAY by deleting table row --->
	<cfinclude template="queries/del_FreeDay.cfm">
<cfelseif QGetFreeDay.RecordCount IS 0 > <!--- Turn ON - UNAVAILABLE/FREE DAY by inserting table row --->
	<cfinclude template="queries/ins_FreeDay.cfm">
<cfelse>
	ERROR in UpdateFreeDay.cfm
	<cfabort>
</cfif>
<cflocation url="MtchDay.cfm?TblName=Matches&MDate=#MDate#&LeagueCode=#LeagueCode#" addtoken="no">
<cfabort>