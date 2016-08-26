<!--- called by RegisterPlayer.cfm --->
<cfif GetRegistration.FirstDay IS ''>
	<cfset FD = "1900-01-01" >
	<cfset FDate = "01/01/1900" >	
<cfelse>
	<cfset FD = DateFormat(GetRegistration.FirstDay, 'YYYY-MM-DD') >
	<cfset FDate = DateFormat(GetRegistration.FirstDay, 'DD/MM/YYYY') >	
</cfif>
<cfif GetRegistration.LastDay IS ''>
	<cfset LD = "2999-12-31" >
	<cfset LDate = "31/12/2999" >
<cfelse>
	<cfset LD = DateFormat(GetRegistration.LastDay, 'YYYY-MM-DD') >
	<cfset LDate = DateFormat(GetRegistration.LastDay, 'DD/MM/YYYY') >	
</cfif>

<cfquery name="QAppearanceC" datasource="#request.DSN#" >
	SELECT
		COUNT(a.ID) as AppCount
	FROM
		appearance a,
		fixture f
	WHERE
		a.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND a.PlayerID = #PlayerID#
		AND a.FixtureID = f.ID
		AND f.FixtureDate BETWEEN '#FD#' AND '#LD#'
	GROUP BY
		a.PlayerID
		
</cfquery>
