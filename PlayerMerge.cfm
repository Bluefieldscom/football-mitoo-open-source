<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!---
<cfinclude template="queries/upd_MergeAppearances.cfm">

<cfinclude template="queries/upd_MergeRegister.cfm">
<cfinclude template="queries/qry_MergePlayer.cfm">
<cfinclude template="queries/del_MergePlayer.cfm">
<cfinclude template="queries/upd_MergePlayer.cfm">
<cflocation url="LUList.cfm?TblName=Player&LeagueCode=#url.LeagueCode#&FirstNumber=#url.RegNo2#&LastNumber=#url.RegNo2#" ADDTOKEN="NO">
--->
<cfabort>
