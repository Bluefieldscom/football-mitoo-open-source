<!---
..................../FACharterStandardTypeUpdate.cfm?LeagueCode=xxxx2010&OldYearString=2010&NewYearString=2011&NextYearString=2012


ONE OFF program to fix missing updates of FACharterStandardType, ParentCountyFA and AffiliationNo

now all done -  the  update code for FACharterStandardType, ParentCountyFA and AffiliationNo is now placed within NewSeason.cfm
--->
<cfabort>



<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>
<cfif StructKeyExists(url, "OldYearString") AND StructKeyExists(url, "NewYearString")  AND StructKeyExists(url, "NextYearString")>
<cfelse>
	&amp;OldYearString=2010&amp;NewYearString=2011&amp;NextYearString=2012     <br /><br /><br /><br /><br /><br />Aborting..........
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
<!---
FACharterStandardType 


Unspecified = 0
FA Charter Standard Club (Adult) = 1
A Charter Standard Club (Youth) = 2
FA Charter Standard Development Club = 3
FA Charter Standard Community Club = 4
none of the above = 9
--->
<cfquery name="TeamOld" datasource="#NewDatabase#">
	SELECT 
		longcol, mediumcol, shortcol, notes, LeagueCode, FACharterStandardType, ParentCountyFA, AffiliationNo
		FROM
		 `#OldDatabase#`.`team`
		WHERE
		leaguecode='#LeagueCodePrefix#'
		AND FACharterStandardType > 0
		ORDER BY longcol;
</cfquery>

<cfoutput query="TeamOld">
	<cfquery name="TeamNew" datasource="#NewDatabase#">
		SELECT 
			ID
			FROM
			 `#NewDatabase#`.`team`
			WHERE
			leaguecode='#LeagueCodePrefix#'
			AND FACharterStandardType = 0
			AND longcol = '#TeamOld.longcol#'
	</cfquery>
	<cfif TeamNew.RecordCount IS 1>
		<cfquery name="TeamNew" datasource="#NewDatabase#">
		UPDATE `#NewDatabase#`.`team`
		SET FACharterStandardType = #TeamOld.FACharterStandardType# WHERE leaguecode='#LeagueCodePrefix#' AND ID=#TeamNew.ID#
		</cfquery>
		#TeamOld.longcol#  #TeamOld.FACharterStandardType#<br>
	</cfif>
		

</cfoutput>
<!---
ParentCountyFA 
--->
<cfquery name="TeamOld" datasource="#NewDatabase#">
	SELECT 
		longcol, mediumcol, shortcol, notes, LeagueCode, FACharterStandardType, ParentCountyFA, AffiliationNo
		FROM
		 `#OldDatabase#`.`team`
		WHERE
		leaguecode='#LeagueCodePrefix#'
		AND NOT (ParentCountyFA IS NULL)
		ORDER BY longcol;
</cfquery>

<cfoutput query="TeamOld">
	<cfquery name="TeamNew" datasource="#NewDatabase#">
		SELECT 
			ID
			FROM
			 `#NewDatabase#`.`team`
			WHERE
			leaguecode='#LeagueCodePrefix#'
			AND ParentCountyFA IS NULL
			AND longcol = '#TeamOld.longcol#'
	</cfquery>
	<cfif TeamNew.RecordCount IS 1>
		<cfquery name="TeamNew" datasource="#NewDatabase#">
		UPDATE `#NewDatabase#`.`team`
		SET ParentCountyFA = '#TeamOld.ParentCountyFA#' WHERE leaguecode='#LeagueCodePrefix#' AND ID=#TeamNew.ID#
		</cfquery>
		#TeamOld.longcol#  #TeamOld.ParentCountyFA#<br>
	</cfif>
		

</cfoutput>
<!---
AffiliationNo 
--->
<cfquery name="TeamOld" datasource="#NewDatabase#">
	SELECT 
		longcol, mediumcol, shortcol, notes, LeagueCode, FACharterStandardType, ParentCountyFA, AffiliationNo
		FROM
		 `#OldDatabase#`.`team`
		WHERE
		leaguecode='#LeagueCodePrefix#'
		AND NOT (AffiliationNo IS NULL)
		ORDER BY longcol;
</cfquery>

<cfoutput query="TeamOld">
	<cfquery name="TeamNew" datasource="#NewDatabase#">
		SELECT 
			ID
			FROM
			 `#NewDatabase#`.`team`
			WHERE
			leaguecode='#LeagueCodePrefix#'
			AND AffiliationNo IS NULL
			AND longcol = '#TeamOld.longcol#'
	</cfquery>
	<cfif TeamNew.RecordCount IS 1>
		<cfquery name="TeamNew" datasource="#NewDatabase#">
		UPDATE `#NewDatabase#`.`team`
		SET AffiliationNo = '#TeamOld.AffiliationNo#' WHERE leaguecode='#LeagueCodePrefix#' AND ID=#TeamNew.ID#
		</cfquery>
		#TeamOld.longcol#  #TeamOld.AffiliationNo#<br>
	</cfif>
		

</cfoutput>
