<!--- Remember to keep this list up to date!   --->
<cfset HTMLLeagueList = "YORK,WLANC,WDFL,SMID,SDWFL,ROTH,ORSFL,NWCFL,MSUS,MORD,HLNC,EIFL,ECRNW,ECFL,DONC,CRNTH,COMC,BDFL,BATH7" >		 

<!--- <cfset x = StructDelete(session, "SplashLeagueList") >  --->


<cfif ListFindNoCase(HTMLLeagueList,request.filter)>
	<cfif RIGHT(request.LeagueCode,4) IS "2009">
		<cfif StructKeyExists(session, "SplashLeagueList")>
			<cflock scope="session" timeout="10" type="readonly" >
				<cfset SplashLeagueList = session.SplashLeagueList >
			</cflock>
			<cfif ListFindNoCase(SplashLeagueList,request.filter)>
				<!--- go straight to mitoo --->
			<cfelse>
				<cfset SplashLeagueList = ListAppend(SplashLeagueList,request.filter) >
				<cflock scope="session" timeout="10" type="exclusive">
					<cfset session.SplashLeagueList = SplashLeagueList >
				</cflock>
				<cfinclude template="#request.filter#.html">
				<cfabort>
			</cfif>
		<cfelse>
			<cfset SplashLeagueList = request.filter >
			<cflock scope="session" timeout="10" type="exclusive">
				<cfset session.SplashLeagueList = SplashLeagueList >
			</cflock>
			<cfinclude template="#request.filter#.html">
			<cfabort>
		</cfif>
	</cfif>
</cfif>