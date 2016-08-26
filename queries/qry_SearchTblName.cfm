<!--- called from SearchAction.cfm --->

<cfif Form.TblName IS "Player">
	<cfif LEN(TRIM(Form.Name)) IS 0 AND LEN(TRIM(Form.PlayerRegNo)) GT 0 AND LEN(TRIM(Form.FAN)) IS 0>
		<cfset SearchPlayerRegNo = TRIM(Form.PlayerRegNo) >
		<cfif NOT IsNumeric(SearchPlayerRegNo) >
			<span class="pix13bold"><cfoutput>#SearchPlayerRegNo#</cfoutput></span><span class="pix13boldred"> unique player number must be numeric</span>
			<cfabort>
		</cfif>
		<cfif SearchPlayerRegNo IS 0 >
			<span class="pix13bold"><cfoutput>#SearchPlayerRegNo#</cfoutput></span><span class="pix13boldred"> unique player number must not be zero</span>
			<cfabort>
		</cfif>
		<cfquery name="SearchTblName" datasource="#request.DSN#">
			SELECT 
				Surname,
				Forename,
				mediumcol, 
				shortcol, 
				ID,
				NULL as firstday, 
				NULL as lastday, 
				NULL as TeamName
			FROM	
				player
			WHERE	
				LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
				AND ShortCol = #SearchPlayerRegNo#
		</cfquery>
	<cfelseif LEN(TRIM(Form.Name)) IS 0 AND LEN(TRIM(Form.PlayerRegNo)) IS 0 AND LEN(TRIM(Form.FAN)) GT 0>
		<cfset SearchFAN = TRIM(Form.FAN) >
		<cfif NOT IsNumeric(SearchFAN) >
			<span class="pix13bold"><cfoutput>#SearchSearchFAN#</cfoutput></span><span class="pix13boldred"> FAN must be numeric</span>
			<cfabort>
		</cfif>
		<cfif SearchFAN IS 0 >
			<span class="pix13bold"><cfoutput>#SearchFAN#</cfoutput></span><span class="pix13boldred"> FAN must not be zero</span>
			<cfabort>
		</cfif>
		<cfquery name="SearchTblName" datasource="#request.DSN#">
			SELECT 
				Surname,
				Forename,
				mediumcol, 
				shortcol, 
				ID,
				NULL as firstday, 
				NULL as lastday, 
				NULL as TeamName
			FROM	
				player
			WHERE	
				LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
				AND FAN = #SearchFAN#
		</cfquery>
	<cfelse>
		<cfif LEN(TRIM(Form.Name)) LT 2 >
			<strong>Search string too short - minimum 2 characters required</strong>
			<cfabort>
		</cfif>
		<cfquery name="SearchTblName" datasource="#request.DSN#">
			SELECT 
				p.Surname, 
				p.Forename, 
				p.mediumcol, 
				p.shortcol, 
				p.ID,
				r.firstday, 
				r.lastday, 
				t.Longcol as TeamName
			FROM
				player p LEFT JOIN register r ON p.ID = r.PlayerID
				LEFT JOIN team t ON r.TeamID=t.ID
			WHERE	
				p.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
				AND p.Surname <> 'OwnGoal'
				AND (	p.Surname LIKE '%#TRIM(Form.Name)#%' OR p.Forename LIKE '%#TRIM(Form.Name)#%')
			ORDER BY
				p.Surname, p.Forename, r.firstday				
		</cfquery>
	</cfif>
<cfelseif Form.TblName IS "Team">
	<cfif LEN(TRIM(Form.Longcol)) LT 2 >
		<strong>Search string too short - minimum 2 characters required</strong>
		<cfabort>
	</cfif>
	<cfquery name="SearchTblName" datasource="#request.DSN#">
	SELECT 	ID, LongCol, shortcol
	FROM	team
	WHERE	
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND LEFT(LongCol, 17) <> 'Winners of Match '
			AND team.LongCol LIKE '%#TRIM(Form.LongCol)#%'
		ORDER BY
			LongCol
	</cfquery>
<cfelseif Form.TblName IS "Noticeboard">
	<cfif LEN(TRIM(Form.Longcol)) LT 2 >
		<strong>Search string too short - minimum 2 characters required</strong>
		<cfabort>
	</cfif>
	<cfquery name="SearchTblName" datasource="marketplace">
	SELECT 	ID, AdvertTitle, StartDate
	FROM <cfif form.SubmitButton IS "Search Old">noticeboard_old<cfelse>noticeboard</cfif> nb
	WHERE	
			nb.AdvertTitle LIKE '%#TRIM(Form.LongCol)#%'
		ORDER BY
			StartDate
	</cfquery>	
<cfelse>
	<cfif LEN(TRIM(Form.Longcol)) LT 2 >
		<strong>Search string too short - minimum 2 characters required</strong>
		<cfabort>
	</cfif>
	<cfset thistblname = LCase(Form.TblName)>
	<cfquery name="SearchTblName" datasource="#request.DSN#">
	SELECT 	ID, LongCol
	FROM	#LCase(Form.TblName)#
	WHERE	
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
					AND #thistblname#.LongCol LIKE '%#TRIM(Form.LongCol)#%'
	ORDER BY
		LongCol
	</cfquery>
</cfif>
