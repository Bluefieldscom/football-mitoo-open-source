<cfif ListFind("Silver",request.SecurityLevel) > <!--- JAB Only --->
	<cfset DeletionIDs = Left(url.DeletionIDs,Len(url.DeletionIDs)-1) >
	<cfinclude template="queries/del_UnwantedTeams.cfm">
	<cflocation	url="ClubList.cfm?LeagueCode=#LeagueCode#" ADDTOKEN="NO">
</cfif>

