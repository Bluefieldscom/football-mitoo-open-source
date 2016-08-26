<!--- called by LUList.cfm --->
<!--- applies to season 2012 onwards only --->
<cfif RIGHT(request.dsn,4) GE 2012>
	<cfquery name="QDuplicatePlayer2" datasource="#request.DSN#" >
		SELECT
			p1.surname as surname1,
			p1.MediumCol as DOB1,
			p1.forename as Forename1,
			p1.ID as PID1,
			p1.ShortCol as RegNo1,
			p1.notes as Notes1,
			p1.AddressLine1 as AddressLine11,
			p1.AddressLine2 as AddressLine12,
			p1.AddressLine3 as AddressLine13,
			p1.Postcode as Postcode1,
			p1.Email1 as Email11,			
			p2.surname as surname2,
			p2.MediumCol as DOB2,
			p2.forename as Forename2,
			p2.ID as PID2,
			p2.ShortCol as RegNo2,
			p2.notes as Notes2,
			p2.AddressLine1 as AddressLine21,
			p2.AddressLine2 as AddressLine22,
			p2.AddressLine3 as AddressLine23,
			p2.Postcode as Postcode2 ,
			p2.Email1 as Email12 			
		FROM
			player p1,
			player p2
		WHERE
			p1.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND p2.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND p1.ShortCol = #ThisRegNo1#
			AND p2.ShortCol = #ThisRegNo2#
	</cfquery>
<cfelse>
	<cfquery name="QDuplicatePlayer2" datasource="#request.DSN#" >
		SELECT
			p1.surname as surname1,
			p1.MediumCol as DOB1,
			p1.forename as Forename1,
			p1.ID as PID1,
			p1.ShortCol as RegNo1,
			p1.notes as Notes1,
			p2.surname as surname2,
			p2.MediumCol as DOB2,
			p2.forename as Forename2,
			p2.ID as PID2,
			p2.ShortCol as RegNo2,
			p2.notes as Notes2
		FROM
			player p1,
			player p2
		WHERE
			p1.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND p2.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND p1.ShortCol = #ThisRegNo1#
			AND p2.ShortCol = #ThisRegNo2#
	</cfquery>
</cfif>