<!--- Called by LUList.cfm --->
<cfparam name="request.DSN" default="fm2003">
<cfparam name="request.filter" default="MDX">
<cfparam name="Firstnumber" default="">
<cfparam name="Lastnumber" default="">
<cfparam name="FirstLetter" default="">
<cfparam name="Transfer" default="N">
<cfparam name="Suspended" default="Y">


<CFQUERY NAME="PlayerSuspensionList" datasource="#request.DSN#">
	SELECT
		s.ID as SI, 
		s.FirstDay as FirstDayOfSuspension, 
		s.LastDay as LastDayOfSuspension, 
		p.Surname,
		p.Forename,
		p.ID as ID, 
		p.Notes as PlayerNotes, 
		p.MediumCol as DOB, 
		p.ShortCol as RegNo
	FROM
		player AS p LEFT OUTER JOIN suspension AS s 
				ON s.PlayerID = p.ID
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND p.surname IS NOT NULL
		AND p.shortcol <> 0 

		<cfif FirstNumber IS NOT "" AND LastNumber IS NOT "">
			AND p.ShortCol 
				BETWEEN  
				<cfqueryparam value = #FirstNumber# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
				AND 
				<cfqueryparam value = #LastNumber# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">
		<cfelseif FirstLetter IS NOT "">
			<!--- AND LEFT(p.LongCol,1) = <cfqueryparam value = '#FirstLetter#' 
										cfsqltype="CF_SQL_VARCHAR" maxlength="1"> --->
			AND LEFT(p.surname,1) = <cfqueryparam value = '#FirstLetter#' 
										cfsqltype="CF_SQL_VARCHAR" maxlength="1">	
		<cfelseif Transfer IS "Y">
			AND p.notes LIKE '%TRANSF%'
		<cfelseif Suspended IS "Y">
			AND (s.ID IS NOT NULL AND s.FirstDay IS NOT NULL)
		<cfelse>
		</cfif>
	ORDER BY
		<cfif FirstNumber IS NOT "" AND LastNumber IS NOT "">
			RegNo, FirstDayOfSuspension
		<cfelse>
			Surname, Forename, RegNo, FirstDayOfSuspension
		</cfif>
</CFQUERY>
<!--- <cfdump var="#PlayerSuspensionList#">  --->
