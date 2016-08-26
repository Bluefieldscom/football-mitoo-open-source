<cfquery name="ChangeLeagueCodePrefix" datasource="#request.DSN#">
SET FOREIGN_KEY_CHECKS=0
</cfquery>

<cfquery name="ChangeLeagueCodePrefix" datasource="#request.DSN#">
UPDATE appearance SET LeagueCode='#NewLeagueCodePrefix#' WHERE LeagueCode='#OldLeagueCodePrefix#'
</cfquery>

<cfquery name="ChangeLeagueCodePrefix" datasource="#request.DSN#">
UPDATE committee SET LeagueCode='#NewLeagueCodePrefix#' WHERE LeagueCode='#OldLeagueCodePrefix#'
</cfquery>

<cfquery name="ChangeLeagueCodePrefix" datasource="#request.DSN#">
UPDATE constitution SET LeagueCode='#NewLeagueCodePrefix#' WHERE LeagueCode='#OldLeagueCodePrefix#'
</cfquery>

<cfquery name="ChangeLeagueCodePrefix" datasource="#request.DSN#">
UPDATE division SET LeagueCode='#NewLeagueCodePrefix#' WHERE LeagueCode='#OldLeagueCodePrefix#'
</cfquery>

<cfquery name="ChangeLeagueCodePrefix" datasource="#request.DSN#">
UPDATE event SET LeagueCode='#NewLeagueCodePrefix#' WHERE LeagueCode='#OldLeagueCodePrefix#'
</cfquery>

<cfquery name="ChangeLeagueCodePrefix" datasource="#request.DSN#">
UPDATE fixture SET LeagueCode='#NewLeagueCodePrefix#' WHERE LeagueCode='#OldLeagueCodePrefix#'
</cfquery>

<cfquery name="ChangeLeagueCodePrefix" datasource="#request.DSN#">
UPDATE koround SET LeagueCode='#NewLeagueCodePrefix#' WHERE LeagueCode='#OldLeagueCodePrefix#'
</cfquery>

<cfquery name="ChangeLeagueCodePrefix" datasource="#request.DSN#">
UPDATE matchreport SET LeagueCode='#NewLeagueCodePrefix#' WHERE LeagueCode='#OldLeagueCodePrefix#'
</cfquery>

<cfquery name="ChangeLeagueCodePrefix" datasource="#request.DSN#">
UPDATE newsitem SET LeagueCode='#NewLeagueCodePrefix#' WHERE LeagueCode='#OldLeagueCodePrefix#'
</cfquery>

<cfquery name="ChangeLeagueCodePrefix" datasource="#request.DSN#">
UPDATE ordinal SET LeagueCode='#NewLeagueCodePrefix#' WHERE LeagueCode='#OldLeagueCodePrefix#'
</cfquery>

<cfquery name="ChangeLeagueCodePrefix" datasource="#request.DSN#">
UPDATE pitchavailable SET LeagueCode='#NewLeagueCodePrefix#' WHERE LeagueCode='#OldLeagueCodePrefix#'
</cfquery>

<cfquery name="ChangeLeagueCodePrefix" datasource="#request.DSN#">
UPDATE player SET LeagueCode='#NewLeagueCodePrefix#' WHERE LeagueCode='#OldLeagueCodePrefix#'
</cfquery>

<cfquery name="ChangeLeagueCodePrefix" datasource="#request.DSN#">
UPDATE refavailable SET LeagueCode='#NewLeagueCodePrefix#' WHERE LeagueCode='#OldLeagueCodePrefix#'
</cfquery>

<cfquery name="ChangeLeagueCodePrefix" datasource="#request.DSN#">
UPDATE referee SET LeagueCode='#NewLeagueCodePrefix#' WHERE LeagueCode='#OldLeagueCodePrefix#'
</cfquery>

<cfquery name="ChangeLeagueCodePrefix" datasource="#request.DSN#">
UPDATE register SET LeagueCode='#NewLeagueCodePrefix#' WHERE LeagueCode='#OldLeagueCodePrefix#'
</cfquery>

<cfquery name="ChangeLeagueCodePrefix" datasource="#request.DSN#">
UPDATE shirtnumber SET LeagueCode='#NewLeagueCodePrefix#' WHERE LeagueCode='#OldLeagueCodePrefix#'
</cfquery>

<cfquery name="ChangeLeagueCodePrefix" datasource="#request.DSN#">
UPDATE suspension SET LeagueCode='#NewLeagueCodePrefix#' WHERE LeagueCode='#OldLeagueCodePrefix#'
</cfquery>

<cfquery name="ChangeLeagueCodePrefix" datasource="#request.DSN#">
UPDATE team SET LeagueCode='#NewLeagueCodePrefix#' WHERE LeagueCode='#OldLeagueCodePrefix#'
</cfquery>

<cfquery name="ChangeLeagueCodePrefix" datasource="#request.DSN#">
UPDATE teamdetails SET LeagueCode='#NewLeagueCodePrefix#' WHERE LeagueCode='#OldLeagueCodePrefix#'
</cfquery>

<cfquery name="ChangeLeagueCodePrefix" datasource="#request.DSN#">
UPDATE teamfreedate SET LeagueCode='#NewLeagueCodePrefix#' WHERE LeagueCode='#OldLeagueCodePrefix#'
</cfquery>

<cfquery name="ChangeLeagueCodePrefix" datasource="#request.DSN#">
UPDATE venue SET LeagueCode='#NewLeagueCodePrefix#' WHERE LeagueCode='#OldLeagueCodePrefix#'
</cfquery>

<cfquery name="ChangeLeagueCodePrefix" datasource="zmast">
	UPDATE
		leagueinfo
	SET
		DefaultLeagueCode = '#NewDefaultLeagueCode#',
		LeagueCodePrefix = '#NewLeagueCodePrefix#',
		AltLeagueCodePrefix = '#OldLeagueCodePrefix#',
		Namesort = '#NewDefaultLeagueCode#',
		LeagueName = '#NewDefaultLeagueCode#',
		CountiesList = '#NewDefaultLeagueCode#'
	WHERE
		DefaultLeagueCode='#LeagueCode#'
</cfquery>

<cfquery name="ChangeLeagueCodePrefix" datasource="#request.DSN#">
SET FOREIGN_KEY_CHECKS=1
</cfquery>


<cfquery name="QOldIdentity" datasource="zmast">
	SELECT
		pwd
	FROM
		identity
	WHERE
		leaguecodeprefix = '#OldLeagueCodePrefix#'
</cfquery>

<cfquery name="QNewIdentity" datasource="zmast">
	SELECT
		pwd
	FROM
		identity
	WHERE
		leaguecodeprefix = '#NewLeagueCodePrefix#'
</cfquery>

<cfif QNewIdentity.RecordCount IS 0 AND QOldIdentity.RecordCount IS 1 >
	<cfquery name="InsertNewIdentity" datasource="zmast">
		INSERT INTO
			identity
			(leaguecodeprefix,
			 name, 
			 pwd)
			VALUES
			('#NewLeagueCodePrefix#',
			 '#NewDefaultLeagueCode#',
			 '#QOldIdentity.pwd#')
	</cfquery>
<cfelseif QNewIdentity.RecordCount IS 1 AND QOldIdentity.RecordCount IS 1 >
<cfelse>
	Error in identity update process. Aborted.
	<cfabort>
</cfif>
