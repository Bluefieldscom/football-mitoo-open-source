<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>
<!---
                                                ****************************************************************************
                                                * Update the New Team Details with the corresponding VenueID and PitchNoId *
                                                ****************************************************************************
--->
<cfif StructKeyExists(url, "OldYearString") AND StructKeyExists(url, "NewYearString")  AND StructKeyExists(url, "NextYearString")>
<cfelse>
	&amp;OldYearString=2011&amp;NewYearString=2012&amp;NextYearString=2013   <br /><br /><br /><br /><br /><br />Aborting..........
<cfabort>
</cfif>

<cfset LeagueCodePrefix = UCASE(request.filter) >
<cfset OldYearString = #url.OldYearString# > <!--- e.g. 2005 --->
<cfset NewYearString = #url.NewYearString# > <!--- e.g. 2006 --->
<cfset NextYearString = #url.NextYearString# > <!--- e.g. 2007 --->
<cfset NewDatabase = "fm#NewYearString#"> <!--- e.g. fm2006 --->
<cfset OldDatabase = "fm#OldYearString#"> <!--- e.g. fm2005 --->
<cfset defaultleaguecode = "#LeagueCodePrefix##NewYearString#" > <!--- e.g. MDX2006 --->
<cfset OldDefaultleaguecode = "#LeagueCodePrefix##OldYearString#" > <!--- e.g. MDX2005 --->

<cfquery name="QTeamDetails" datasource="#NewDatabase#">
	SELECT
		td_new.id as NewTeamDetailsID,
		td_new.teamid as NewTeamID,
		td_new.ordinalid as NewOrdinalID,
		td_new.venueid as NewVenueID,
		td_new.pitchnoid
	FROM 
		`#NewDatabase#`.`teamdetails` td_new
	WHERE
		td_new.leaguecode='#LeagueCodePrefix#'
	ORDER BY
		td_new.teamid, td_new.ordinalid;
</cfquery>

<cfoutput query="QTeamDetails">
	<cfset OString=''>
	<cfquery name="Q999" datasource="#NewDatabase#">select longcol from `#NewDatabase#`.`ordinal` where id=#NewOrdinalID#</cfquery>
	<cfif Q999.longcol IS ''>
		<cfquery name="Q21" datasource="#OldDatabase#">
			select id from `#OldDatabase#`.`ordinal` where leaguecode='#LeagueCodePrefix#' and longcol is null;
		</cfquery>
		<cfset OldOrdinalID=#Q21.id# >
	<cfelse>
		<cfquery name="Q22" datasource="#OldDatabase#">
			select id, longcol from `#OldDatabase#`.`ordinal` where leaguecode='#LeagueCodePrefix#' and longcol = '#Q999.longcol#';
		</cfquery>
		<cfset OldOrdinalID=#Q22.id# >
		<cfset OString='#Q22.longcol#'>
	</cfif>
	<cfif IsNumeric(NewTeamID)>
		<cfquery name="Q1" datasource="#OldDatabase#">
			select id, longcol from `#OldDatabase#`.`team` where leaguecode='#LeagueCodePrefix#' and longcol = (select longcol from `#NewDatabase#`.`team` where id=#NewTeamID#);
		</cfquery>
		NewTeamDetailsID=#NewTeamDetailsID# 
		NewTeamID=#NewTeamID#
		NewOrdinalID=#NewOrdinalID#
		OldOrdinalID=#OldOrdinalID#
		<cfset OldTeamID=#Q1.id# >
		OldTeamID=#OldTeamID#
		<cfif IsNumeric(OldTeamID) >		
			<strong>#Q1.longcol# #OString#</strong>
			<cfquery name="Q3" datasource="#OldDatabase#">
				select venueid, pitchnoid from `#OldDatabase#`.`teamdetails` where leaguecode='#LeagueCodePrefix#' and OrdinalID=#OldOrdinalID# and TeamID=#OldTeamID#
			</cfquery>
			<cfset OldVenueID= #Q3.venueid# >
			<cfset OldPitchNoID= #Q3.pitchnoid# >
			OldVenueID=#OldVenueID#
			OldPitchNoID=#OldPitchNoID#
			<cfif IsNumeric(OldVenueID) AND IsNumeric(OldPitchNoID) >
				<cfquery name="Q4" datasource="#OldDatabase#">	
					select longcol from `#OldDatabase#`.`venue` where leaguecode='#LeagueCodePrefix#' and ID=#OldVenueID#
				</cfquery>
				<cfset VenueName='#Q4.longcol#'>
				<br>VenueName=#VenueName#
				<cfquery name="Q5" datasource="#NewDatabase#">	
					select id as NewVID from `#NewDatabase#`.`venue` where leaguecode='#LeagueCodePrefix#' and longcol='#VenueName#'
				</cfquery>
				<cfset NewVID=#Q5.NewVID# >
				NewVID=#NewVID#
				<cfif IsNumeric(NewVID)>
					<cfquery name="Q6" datasource="#NewDatabase#">
						UPDATE `#NewDatabase#`.`teamdetails` 
						SET VenueID=#NewVID#, PitchNoID=#OldPitchNoID#
						WHERE leaguecode='#LeagueCodePrefix#' and ID=#NewTeamDetailsID#
					</cfquery>
				</cfif>
			</cfif>
		</cfif>
	<cfelse>
	</cfif>
	<hr>
</cfoutput>
