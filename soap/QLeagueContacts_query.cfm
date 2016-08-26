<!--- called from getLeagueContactsByLeaguePrefix method of webServices.cfc --->

<cfinclude template="QgetLeagueYearFromDates.cfm">

<cfquery name="QLeagueContacts_query" datasource="#variables.dsn#">
	SELECT
		*
	FROM
		committee
	WHERE
		LeagueCode = '#arguments.LeagueCode#'
	ORDER BY
		shortCol
</cfquery>
<cfset i=1>
<cfloop query="QLeagueContacts_query">
	<cfscript>
		QLeagueContacts[#i#] = StructNew();
		QLeagueContacts[#i#].league_contact_id 			= #ID#;
		QLeagueContacts[#i#].league_contact_title 		= #longCol#;
		QLeagueContacts[#i#].league_contact_name 		= #mediumCol#;
		QLeagueContacts[#i#].league_contact_notes 		= #notes#;
		QLeagueContacts[#i#].league_contact_rank 		= #shortCol#;
		QLeagueContacts[#i#].mitoo_league_prefix 		= #LeagueCode#;
		
		QLeagueContacts[#i#].league_contact_email 		= #EmailAddress1#;
		QLeagueContacts[#i#].league_contact_home_tel 	= #HomeTel#;
		QLeagueContacts[#i#].league_contact_work_tel 	= #WorkTel#;
		QLeagueContacts[#i#].league_contact_mobile_tel 	= #MobileTel#;
		QLeagueContacts[#i#].league_contact_add1 		= #AddressLine1#;
		QLeagueContacts[#i#].league_contact_add2 		= #AddressLine2#;
		QLeagueContacts[#i#].league_contact_add3 		= #AddressLine3#;
		QLeagueContacts[#i#].league_contact_postcode 	= #PostCode#;
		QLeagueContacts[#i#].league_show_email 			= #ShowHideEmailAddress1#;
		QLeagueContacts[#i#].league_show_home_tel 		= #ShowHideHomeTel#;
		QLeagueContacts[#i#].league_show_work_tel 		= #ShowHideWorkTel#;
		QLeagueContacts[#i#].league_show_mobile_tel 	= #ShowHideMobileTel#;
		QLeagueContacts[#i#].league_show_address 		= #ShowHideAddress#;
		i++;
	</cfscript>
</cfloop>