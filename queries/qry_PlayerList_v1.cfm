<!--- Called by LUList.cfm --->
<cfparam name="request.DSN" default="fm2003">
<cfparam name="request.filter" default="MDX">
<cfparam name="Firstnumber" default="">
<cfparam name="Lastnumber" default="">
<cfparam name="FirstLetter" default="">
<cfparam name="Transfer" default="N">
<cfparam name="Suspended" default="Y">
<cfparam name="Unregistered" default="Y">


<!--- added July 18 2010 to get rid of any uunwanted suspensions --->
<!--- get rid of any unused suspensions --->
<cfinclude template = "del_QDeleteAllEmptySuspension.cfm">


<!--- <cfif Firstletter IS "">
	<cfset FirstLetter = "A">
</cfif> --->
<cfif Transfer IS "Y">
	<CFQUERY NAME="MultipleRegistrations" datasource="#request.DSN#">
		SELECT PlayerID FROM register
		WHERE leaguecode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		GROUP BY PlayerID HAVING count(PlayerID) > 1 
	</cfquery>
	<cfset PlayerIDList = ValueList(MultipleRegistrations.PlayerID)>
	<cfif PlayerIDList IS "">
		<cfset PlayerIDList = ListAppend(PlayerIDList,0)>
	</cfif>
	<CFQUERY NAME="PlayerList" datasource="#request.DSN#">
		SELECT
			r.ID as RI, 
			r.RegType,
			r.FirstDay as FirstDayOfRegistration,
			r.LastDay as LastDayOfRegistration,
			s.ID as SI, 
			s.FirstDay as FirstDayOfSuspension, 
			s.LastDay as LastDayOfSuspension,
			s.NumberOfMatches,
			s.SuspensionNotes,
			p.Surname,
			p.Forename,
			p.ID as ID, 
			<!--- applies to season 2012 onwards only --->
			<cfif RIGHT(request.dsn,4) GE 2012>
				p.AddressLine1, p.AddressLine2, p.AddressLine3, p.Postcode, Email1,
			</cfif>
			p.Notes as PlayerNotes, 
			t.LongCol as TeamName, 
			t.ID as TeamID,
			IF(p.MediumCol IS NULL, '', p.MediumCol) as DOB,
			p.ShortCol as RegNo
		FROM
			((player AS p LEFT OUTER JOIN register AS r 
				ON p.ID = r.PlayerID) 
				LEFT OUTER JOIN team AS t 
					ON r.TeamID = t.ID) 
				LEFT OUTER JOIN suspension AS s 
					ON s.PlayerID = p.ID
		WHERE
			p.LeagueCode = <cfqueryparam value = '#request.filter#' 
								cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
			AND NOT (r.PlayerID IS NOT NULL AND r.TeamID  IS NULL)
			AND p.shortcol <> 0 <!--- ignore Own Goal --->
			AND p.ID IN (#PlayerIDList#)
		ORDER BY
				Surname, Forename, RegNo, FirstDayOfRegistration, FirstDayOfSuspension
	</CFQUERY>

<cfelse>

	<CFQUERY NAME="PlayerList" datasource="#request.DSN#">
		SELECT
			r.ID as RI, 
			r.RegType,
			r.FirstDay as FirstDayOfRegistration,
			r.LastDay as LastDayOfRegistration,
			s.ID as SI, 
			s.FirstDay as FirstDayOfSuspension, 
			s.LastDay as LastDayOfSuspension, 
			s.NumberOfMatches,
			s.SuspensionNotes,
			p.Surname,
			p.Forename,
			p.ID as ID, 
			<!--- applies to season 2012 onwards only --->
			<cfif RIGHT(request.dsn,4) GE 2012>
				p.AddressLine1, p.AddressLine2, p.AddressLine3, p.Postcode, p.Email1,
			</cfif>
			p.Notes as PlayerNotes, 
			t.LongCol as TeamName, 
			t.ID as TeamID,
			IF(p.MediumCol IS NULL, '', p.MediumCol) as DOB,
			p.ShortCol as RegNo
		FROM
			((player AS p LEFT OUTER JOIN register AS r 
				ON p.ID = r.PlayerID) 
				LEFT OUTER JOIN team AS t 
					ON r.TeamID = t.ID) 
				LEFT OUTER JOIN suspension AS s 
					ON s.PlayerID = p.ID
		WHERE
			p.LeagueCode = <cfqueryparam value = '#request.filter#' 
								cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
			AND NOT (r.PlayerID IS NOT NULL AND r.TeamID  IS NULL)
			AND p.shortcol <> 0 <!--- ignore Own Goal --->
			<cfif FirstNumber IS NOT "" AND LastNumber IS NOT "">
				AND p.ShortCol 
					BETWEEN  
					<cfqueryparam value = #FirstNumber# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
					AND 
					<cfqueryparam value = #LastNumber# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
			<cfelseif FirstLetter IS NOT "">
				AND LEFT(p.surname,1) = <cfqueryparam value = '#FirstLetter#' 
											cfsqltype="CF_SQL_VARCHAR" maxlength="1">	
			<cfelseif Suspended IS "Y">
				AND s.ID IS NOT NULL AND s.FirstDay IS NOT NULL
			<cfelseif Suspended IS "MB">
				AND s.ID IS NOT NULL AND s.FirstDay IS NOT NULL AND	s.NumberOfMatches > 0
			<cfelseif Unregistered IS "Y">
				AND r.TeamID IS NULL
			<cfelse>
			</cfif>
		ORDER BY
			<cfif FirstNumber IS NOT "" AND LastNumber IS NOT "">
				RegNo, FirstDayOfRegistration, FirstDayOfSuspension
			<cfelse>
				Surname, Forename, RegNo, FirstDayOfRegistration, FirstDayOfSuspension
			</cfif>
	</CFQUERY>
</cfif>



 <!--- <cfdump var="#PlayerList#">  --->
