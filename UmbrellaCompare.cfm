<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<cfinclude template="InclBegin.cfm">
<cfflush>
<cfsetting requestTimeOut = "180" >
<cfset ThisYear = #LeagueCodeYear# >
<cfset PreviousYear = #LeagueCodeYear#-1 >
<!---
We will be doing a classic two file match between umbrella_a and umbrella_b.

**************************************************************
* umbrella_a data comes mainly from the zmast.teaminfo table *
**************************************************************
--->
<cfquery name="umbrella_a001" datasource="zmast">
	DELETE FROM umbrella_a WHERE LeagueCodeYear = #ThisYear#
</cfquery>
<cfquery name="umbrella_a002" datasource="zmast">
	INSERT INTO umbrella_a
			(fmTeamID,
			LeagueInfoID,
			ClubInfoID,
			ClubName,
			Location,
			LeagueCodeYear,
			Matching,
			NameSort,
			CountiesList)
		SELECT
			ti.fmTeamID,
			ti.LeagueInfoID,
			ti.ClubInfoID,
			ci.ClubName,
			ci.Location,
			#ThisYear#,
			0,
			li.NameSort,
			li.CountiesList
		FROM
			teaminfo ti,
			clubinfo ci,
			leagueinfo li
		WHERE
			li.LeagueCodeYear = #ThisYear#
			AND ci.id = ti.ClubInfoID
			AND li.id = ti.LeagueInfoID
</cfquery>
<!---

******************************************************
* umbrella_b comes mainly from the fm2008.team table *
******************************************************
--->
<cfquery name="umbrella_b001" datasource="zmast">
	DELETE FROM umbrella_b WHERE LeagueCodeYear = #ThisYear#
</cfquery>
<cfquery name="umbrella_b002" datasource="zmast">
	INSERT INTO umbrella_b
			(fmTeamID, 
			LeagueInfoID, 
			TeamName, 
			LeagueCodePrefix, 
			LeagueCodeYear, 
			Matching,
			NameSort,
			CountiesList)
	SELECT
			t.ID,
			li.ID,
			t.LongCol,
			t.LeagueCode,
			#ThisYear#,
			0,
			li.NameSort,
			li.CountiesList
		FROM
			#request.DSN#.team t,
			leagueinfo li
		WHERE
			li.LeagueCodeYear = #ThisYear#
			AND t.ID NOT IN (SELECT ID FROM #request.DSN#.team WHERE ShortCol='Guest')
			AND t.ID NOT IN (SELECT ID FROM #request.DSN#.team WHERE LEFT(Notes,7) = 'NoScore')
			AND li.LeagueCodePrefix = t.LeagueCode
</cfquery>

<!--------------------------------------------------------------------------->

<cfquery name="umbrella_a003" datasource="zmast">
	SELECT fmTeamID FROM umbrella_a WHERE LeagueCodeYear = #ThisYear# ORDER BY fmTeamID
</cfquery>
<cfset umbrella_aList = ValueList(umbrella_a003.fmTeamID)>
<cfif ListLen(umbrella_aList) IS 0 >
	<cfset AKey = 16777215 >
<cfelse>
	<cfset AKey = 0 >
</cfif>
<cfset IndexA = 1 >

<cfquery name="umbrella_b003" datasource="zmast">
	SELECT fmTeamID FROM umbrella_b WHERE LeagueCodeYear = #ThisYear# ORDER BY fmTeamID
</cfquery>
<cfset umbrella_bList = ValueList(umbrella_b003.fmTeamID)>
<cfif ListLen(umbrella_bList) IS 0 >
	<cfset BKey = 16777215 >
<cfelse>
	<cfset BKey = 0 >
</cfif>
<cfset IndexB = 1 >


<table>
	<tr>
		<td><span class="pix10bold">Message</span></td>
		<td><span class="pix10bold">fmTeamID</span></td>
		<td><span class="pix10bold">Club Umbrella Name</span></td>
		<td><span class="pix10bold">Location</span></td>
		<td><span class="pix10bold">TeamName</span></td>
		<td><span class="pix10bold">League Name</span></td>
		<td><span class="pix10bold">Counties</span></td>
	</tr>	
<cfloop condition="AKey LT 16777215 OR BKey LT 16777215" >
		<!--- --->
		<cfif IndexA GT ListLen(umbrella_aList)>
			<cfset AKey = 16777215 >
		<cfelse>
			<cfset AKey = ListGetAt(umbrella_aList,IndexA) >
		</cfif>
		<!--- --->
		<cfif IndexB GT ListLen(umbrella_bList)>
			<cfset BKey = 16777215 >
		<cfelse>
			<cfset BKey = ListGetAt(umbrella_bList,IndexB) >
		</cfif>
		
		
		<cfif AKey LT BKey>
			<cfquery name="Lookup" datasource="zmast">
				SELECT * FROM umbrella_a WHERE fmTeamID=#AKey# AND LeagueCodeYear = #ThisYear#
			</cfquery>
			<cfoutput query="Lookup">
				<tr bgcolor="silver">
					<td><span class="pix10">Redundant</span></td>
					<td><span class="pix10">#AKey#</span></td>
					<td><span class="pix10">#ClubName#</span></td>
					<td><span class="pix10">#Left(Location,15)#<cfif Len(Trim(Location)) GT 15>... etc.</cfif></span></td>
					<td><span class="pix10">-</span></td>
					<td><span class="pix10">#NameSort#</span></td>
					<td><span class="pix10">#Left(CountiesList,15)#<cfif Len(Trim(CountiesList)) GT 15>... etc.</cfif></span></td>
				</tr>
			</cfoutput>
			<cfflush>
			<cfset IndexA = IndexA + 1 >
		<cfelseif BKey LT AKey >
			<cfquery name="Lookup" datasource="zmast">
				SELECT * FROM umbrella_b WHERE fmTeamID=#BKey# AND LeagueCodeYear = #ThisYear#
			</cfquery>
			<cfoutput query="Lookup">
				<tr>
					<td><span class="pix10">Missing</span></td>
					<td><span class="pix10">#BKey#</span></td>
					<td><span class="pix10">-</span></td>
					<td><span class="pix10">-</span></td>
					<td><span class="pix10">#TeamName#</span></td>
					<td><span class="pix10">#NameSort#</span></td>
					<td><span class="pix10">#Left(CountiesList,15)#<cfif Len(Trim(CountiesList)) GT 15>... etc.</cfif></span></td>
				</tr>
			</cfoutput>
			
			<cfquery name="LookupPreviousB" datasource="zmast">
				SELECT * FROM umbrella_b WHERE TeamName='#Lookup.TeamName#' AND NameSort='#Lookup.NameSort#' AND LeagueCodeYear = #PreviousYear#
			</cfquery>
			<cfoutput query="LookupPreviousB">
				<tr>
					<td><span class="pix10navy">Found in #PreviousYear#</span></td>
					<td><span class="pix10navy">#fmTeamID#</span></td>
					<td><span class="pix10navy">-</span></td>
					<td><span class="pix10navy">-</span></td>
					<td><span class="pix10navy">#TeamName#</span></td>
					<td><span class="pix10navy">#NameSort#</span></td>
					<td><span class="pix10navy">#Left(CountiesList,15)#<cfif Len(Trim(CountiesList)) GT 15>... etc.</cfif></span></td>
				</tr>
			</cfoutput>
			<cfquery name="LookupPreviousA" datasource="zmast">
				SELECT * FROM umbrella_a WHERE fmTeamID='#LookupPreviousB.fmTeamID#' AND LeagueCodeYear = #PreviousYear#
			</cfquery>
			<cfoutput query="LookupPreviousA">
				<tr>
					<td><span class="pix10red">Umbrella</span></td>
					<td><span class="pix10red">#fmTeamID#</span></td>
					<td><span class="pix10red">#ClubName#</span></td>
					<td><span class="pix10red">#Left(Location,15)#<cfif Len(Trim(Location)) GT 15>... etc.</cfif></span></td>
					<td><span class="pix10red">-</span></td>
					<td><span class="pix10red">#NameSort#</span></td>
					<td><span class="pix10red">#Left(CountiesList,15)#<cfif Len(Trim(CountiesList)) GT 15>... etc.</cfif></span></td>
				</tr>
			</cfoutput>
			
			<cfflush>
			<cfset IndexB = IndexB + 1 >
		<cfelseif AKey IS BKey >
			<cfset IndexA = IndexA + 1 >
			<cfset IndexB = IndexB + 1 >
		<cfelse>
			????????????????????????????????
			<cfabort>
		</cfif>
</cfloop>
</table>
<cfsetting requestTimeOut = "60" >
