<cflock scope="session" timeout="10" type="exclusive">
	<cfif session.LoggedIn IS "No" OR session.LoggedInLeague IS NOT #LeagueCode#>
		<cfset session.LoggedIn = "No">
		<cflocation addtoken="no" url="NoAuthority.cfm">
		<cfabort>
	</cfif>
</cflock>
