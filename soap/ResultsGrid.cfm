
<!--- Check to see if the current "Division" is a Cup or Trophy i.e. a Knock-Out Competition
If it is, then we'll jump over to Knock Out History instead
--->

<cfinclude template="QgetLeagueYearFromDates.cfm">

<cfscript>
	request.DSN = variables.dsn;
	request.filter = arguments.leagueCode;
	session.fmTeamID  = 0;
	DivisionID = arguments.division_id;
</cfscript>

<cfinclude template="../queries/qry_QCompetition.cfm">

<cfparam name="KO" default="No">

<cfinclude template="../queries/qry_QKnockOut.cfm">

<cfif Left(QKnockOut.Notes,2) IS "KO" >
<!--- Jumping here.... --->
Cannot produce a result grid for Knockout competitions

<!---
	<cflocation URL=
		"KOHist.cfm?TblName=Matches&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" 
				addtoken="no">
--->
<cfabort>
</cfif>


<cfinclude template = "../queries/qry_QTeamList.cfm">
<cfinclude template = "../queries/qry_QResults.cfm">
<cfset CIDList=ValueList(QTeamList.CID)>

<cfset i = 1>
<cfset j = 1>

<cfset resultGridArray[#i#][#j#] = ''>

<cfloop query="QTeamList">
<cfscript>
	j++;
	if (#TeamNameMedium# IS "")
		teamtitle =  #TeamName#;
	else
		teamtitle = #TeamNameMedium#;
	if (#OrdinalNameShort# IS "")
		resultGridArray[#i#][#j#] = teamtitle & ' ' & #OrdinalName#;
	else
		resultGridArray[#i#][#j#] = teamtitle & ' ' & #OrdinalNameShort#;
</cfscript>
</cfloop>

<cfset i=i+1>
<cfset j = 1>	
	<cfloop query="QTeamList">
		<cfset resultGridArray[#i#][#j#] = #TeamName# & ' ' & #OrdinalName#>
		<cfset j=j+1>
		<cfloop index="ColN" from="1" to="#QTeamList.RecordCount#" step="1" >
			<cfif QTeamList.CID IS ListGetAt(CIDList, ColN)>
				<cfinclude template = "../queries/qry_QGridHomeGames.cfm">
				<cfinclude template = "../queries/qry_QGridAwayGames.cfm">
				<cfset HGCount = IIF(IsNumeric(QGridHomeGames.HomeGames),QGridHomeGames.HomeGames,0)>
				<cfset AGCount = IIF(IsNumeric(QGridAwayGames.AwayGames),QGridAwayGames.AwayGames,0)>

				<cfif HGCount IS 0 AND AGCount IS 0>
					<cfset resultGridArray[#i#][#j#] = ''>
				<cfelse>
					<cfif ABS(HGCount - AGCount) GT 2>
						<cfset resultGridArray[#i#][#j#] = 'H' & #HGCount# & ' A' & #AGCount#>
					<cfelse>
						<cfset resultGridArray[#i#][#j#] = 'H' & #HGCount# & ' A' & #AGCount#>
					</cfif>
				</cfif>
			<cfelse>
				<cfinclude template = "../queries/qry_QGetResult.cfm">
					
				<cfloop query="QGetResult">
							
					<cfif Result IS "H" ><cfset resultGridArray[#i#][#j#] = #DateFormat( FixtureDate , "D MMM")# & ' (Home Win)'>
					<cfelseif Result IS "A" ><cfset resultGridArray[#i#][#j#] = #DateFormat( FixtureDate , "D MMM")# & ' (Away Win)'>
					<cfelseif Result IS "U" ><cfset resultGridArray[#i#][#j#] = #DateFormat( FixtureDate , "D MMM")# & ' (Home Win on pens)'>
					<cfelseif Result IS "V" ><cfset resultGridArray[#i#][#j#] = #DateFormat( FixtureDate , "D MMM")# & ' (Away Win on pens)'>
					<cfelseif Result IS "D" ><cfset resultGridArray[#i#][#j#] = #DateFormat( FixtureDate , "D MMM")# & ' Draw'>
					<cfelseif Result IS "P" ><cfset resultGridArray[#i#][#j#] = #DateFormat( FixtureDate , "D MMM")# & ' Postponed'>
					<cfelseif Result IS "Q" ><cfset resultGridArray[#i#][#j#] = #DateFormat( FixtureDate , "D MMM")# & ' Abandoned'>
					<cfelse>
						<cfset resultGridArray[#i#][#j#] = #DateFormat( FixtureDate , "D MMM")#>
						<cfif HomeGoals IS "">
							<!--- add nothing --->
						<cfelse>
							<cfset resultGridArray[#i#][#j#] = resultGridArray[#i#][#j#] & ' (' & #HomeGoals# & '-' & #AwayGoals# &')'>
						</cfif>
					</cfif>

					<cfif HomePointsAdjust IS NOT "" AND HomePointsAdjust IS NOT 0 ><cfset resultGridArray[#i#][#j#] = resultGridArray[#i#][#j#] & ' (' & #NumberFormat(HomePointsAdjust,"+9")# & ' pts H)'>
					</cfif>

					<cfif AwayPointsAdjust IS NOT "" AND AwayPointsAdjust IS NOT 0 ><cfset resultGridArray[#i#][#j#] = resultGridArray[#i#][#j#] & ' (' & #NumberFormat(AwayPointsAdjust,"+9")# & ' pts A)'>
					</cfif>
						
				</cfloop>
				
				<cfif QGetResult.RecordCount IS 0>
					<cfset resultGridArray[#i#][#j#] = ''>
				</cfif>

			</cfif>
		<cfset j=j+1>	
		</cfloop>
	<cfset i=i+1>
	<cfset j=1>
	</cfloop>





