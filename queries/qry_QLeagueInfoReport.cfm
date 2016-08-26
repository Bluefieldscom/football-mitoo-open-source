<!--- various counting queries called by LeagueInfoReport.cfm --->
<cfquery name="QHowManyPlayers" datasource="#request.DSN#">	
	SELECT COUNT(*) as pcount FROM player WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
</cfquery>
<cfquery name="QHowManyReferees" datasource="#request.DSN#">	
	SELECT COUNT(*) as rcount FROM referee WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
</cfquery>
<cfquery name="QHowManyMemberClubs" datasource="#request.DSN#">	
	SELECT COUNT(*) as tcount FROM team WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND ID NOT IN (SELECT ID FROM team WHERE LeagueCode=LeagueCode AND Left(notes,7)='NoScore')
</cfquery>
<cfquery name="QHowManyGuestClubs" datasource="#request.DSN#">	
	SELECT COUNT(*) as tcount FROM team WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND ShortCol = 'GUEST'
	AND ID NOT IN (SELECT ID FROM team WHERE LeagueCode=LeagueCode AND Left(notes,7)='NoScore')
</cfquery>
<cfquery name="QHowManyNOTICE" datasource="#request.DSN#">	
	SELECT COUNT(*) as ncount, notes FROM newsitem WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND LongCol='NOTICE'
</cfquery>
<cfquery name="QHowManyNewsitems" datasource="#request.DSN#">	
	SELECT COUNT(*) as ncount FROM newsitem WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND LongCol<>'NOTICE' AND shortcol IS NULL
</cfquery>
<cfquery name="QHowManyHiddenNewsitems" datasource="#request.DSN#">	
	SELECT COUNT(*) as ncount FROM newsitem WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND LongCol<>'NOTICE' AND shortcol = 'HIDE'
</cfquery>
<cfif VenueAndPitchAvailable IS 1>
	<cfquery name="QHowManyVenues" datasource="#request.DSN#">	
		SELECT COUNT(*) as vcount FROM venue WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	</cfquery>
	<cfquery name="QHowManyVenuesWithMaps" datasource="#request.DSN#">	
		SELECT COUNT(*) as vcount FROM venue WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND MapURL LIKE '%http://%'
	</cfquery>
</cfif>
