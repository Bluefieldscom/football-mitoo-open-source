<cfif ListFind("Silver,Skyblue,Orange,Yellow",request.SecurityLevel) >
<!--- if currently logged in as JAB (Silver) or supervisor (Skyblue) or restricted admin (Orange) or Three Character password (Yellow) then Log Out immediately --->
	<cfset request.SecurityLevel = "White" >
	<cfset request.DropDownTeamName = "">
	<cfset request.DropDownTeamID = 0>
	<cfset request.DropDownRefereeName = "">
	<cfset request.DropDownRefereeID = 0>
	<cfset request.YellowKey = "">
	<cflock scope="session" timeout="10" type="exclusive">
		<cfset session.SecurityLevel    = request.SecurityLevel >
		<cfset session.DropDownTeamName = request.DropDownTeamName >
		<cfset session.DropDownTeamID   = request.DropDownTeamID >
		<cfset session.DropDownRefereeName = request.DropDownRefereeName >
		<cfset session.DropDownRefereeID   = request.DropDownRefereeID >
		<cfset session.YellowKey   = request.YellowKey >
	</cflock>
	<cflocation url="News.cfm?LeagueCode=#LeagueCode#&NB=0" ADDTOKEN="no">
	<cfabort>
<cfelse> 
<!--- request.SecurityLevel is White and the user is invited to enter a password --->
	<cflocation url="SecurityCheck.cfm?DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" ADDTOKEN="no">
	<cfabort>
</cfif>
