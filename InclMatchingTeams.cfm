REDUNDANT CODE

<cfabort>


<!--- we do this fresh every time and compare the results with what exists in zmast.lk_team table --->
<!--- this query identifies matching teams across two years, Previous and This, matching is done on leaguecode and longcol (the team description) --->
<cfquery name="ABMatch" datasource="zmast">
	SELECT
		t1.id as previoustid, 
		t2.id as thistid, 
		t1.longcol as teamname, 
		t1.leaguecode 
	FROM
		fm#PreviousYear#.team t1,
		fm#ThisYear#.team t2
	WHERE 
		<cfif OnlyThisLeague IS "Yes">t1.leaguecode = '#LeagueCodePrefix#' AND</cfif>
		t1.id NOT IN (SELECT id from fm#PreviousYear#.team WHERE left(notes,7)='NoScore')
		AND t1.id NOT IN (SELECT id from fm#PreviousYear#.team where shortcol='GUEST')
		AND t1.id NOT IN (SELECT id from fm#PreviousYear#.team where LEFT(longcol,7)='Winners')
		AND t1.leaguecode = t2.leaguecode
		AND t1.longcol = t2.longcol
	ORDER BY
		t1.leaguecode, t1.longcol
</cfquery>

<cfset ABTeamMatchList1 = ValueList(ABMatch.previoustid) >
<cfset ABTeamMatchList2 = ValueList(ABMatch.thistid) >

<table>
	<tr bgcolor="silver">
		<td><span class="pix13bold">Processing Teams</span></td>
	</tr>
	<cfflush>
	<cfoutput>
	<cfif OnlyThisLeague IS "Yes">
		<tr bgcolor="silver">
			<td><span class="pix10bold">Message</span></td>
			<td><span class="pix10bold">id</span></td>
			<td><span class="pix10bold">#PreviousYearid#</span></td>
			<td><span class="pix10bold">#ThisYearid#</span></td>
			<td><span class="pix10bold">teamname</span></td>
			<td><span class="pix10bold">leaguecode</span></td>
		</tr>
	</cfif>	
	</cfoutput>
	<cfoutput query="ABMatch">
		<!--- check to see if there is a corresponding row in zmast.lk_team --->
		<cfquery name="Q_lk_team" datasource="zmast">
			SELECT
				id 
			FROM
				lk_team
			WHERE
				#PreviousYearid# = #ABMatch.previoustid#
		</cfquery>
		<cfif Q_lk_team.RecordCount IS 0>
			<!--- No, so insert a row in zmast.lk_team --->
			<cfquery name="ins_lk_team" datasource="zmast">
					INSERT INTO lk_team 
					(#PreviousYearid#,  #ThisYearid#, teamname, leaguecode)
					VALUES
					(#ABMatch.previoustid#, #ABMatch.thistid#,  '#ABMatch.teamname#', '#ABMatch.leaguecode#')
			</cfquery>
			<!--- Get the row we just inserted in zmast.lk_team --->
			<cfquery name="get_lk_team" datasource="zmast">
					SELECT
						id,
						#PreviousYearid# as PrevID,
						#ThisYearid# as ThisID,
						teamname,
						leaguecode
					FROM
						lk_team 
					WHERE 
						#PreviousYearid# = #ABMatch.previoustid#
			</cfquery>
			<cfif get_lk_team.RecordCount IS NOT 1>ABMatch: ins_lk_team error<cfabort></cfif>
			<cfif OnlyThisLeague IS "Yes">
				<tr>
					<td><span class="pix10">INSERTED MATCHING</span></td>
					<td><span class="pix10">#get_lk_team.id#</span></td>
					<td><span class="pix10">#get_lk_team.PrevID#</span></td>
					<td><span class="pix10">#get_lk_team.ThisID#</span></td>
					<td><span class="pix10">#get_lk_team.teamname#</span></td>
					<td><span class="pix10">#get_lk_team.leaguecode#</span></td>
				</tr>	
			</cfif>      
		<cfelseif Q_lk_team.RecordCount IS 1>
			<!--- Yes, so update the row in zmast.lk_team --->
			<cfquery name="upd_lk_team" datasource="zmast">
					UPDATE
						lk_team 
					SET 
						#PreviousYearid#=#ABMatch.previoustid#,
						#ThisYearid#=#ABMatch.thistid#,
						teamname='#ABMatch.teamname#',
						leaguecode='#ABMatch.leaguecode#'
					WHERE
						id = #Q_lk_team.id#
			</cfquery>
			<!--- Get the row we just updated in zmast.lk_team --->
			<cfquery name="get_lk_team" datasource="zmast">
					SELECT
						id,
						#PreviousYearid# as PrevID,
						#ThisYearid# as ThisID,
						teamname,
						leaguecode
					FROM
						lk_team 
					WHERE 
						#PreviousYearid# = #ABMatch.previoustid#
			</cfquery>
			<cfif get_lk_team.RecordCount IS NOT 1>ABMatch: upd_lk_team error<cfabort></cfif>
			<cfif OnlyThisLeague IS "Yes">
				<tr>
					<td><span class="pix10">UPDATED MATCHING</span></td>
					<td><span class="pix10">#get_lk_team.id#</span></td>
					<td><span class="pix10">#get_lk_team.PrevID#</span></td>
					<td><span class="pix10">#get_lk_team.ThisID#</span></td>
					<td><span class="pix10">#get_lk_team.teamname#</span></td>
					<td><span class="pix10">#get_lk_team.leaguecode#</span></td>
				</tr>	
			</cfif>       
		<cfelse>
			MATCHING: ERROR Q_lk_team.RecordCount is #Q_lk_team.RecordCount#<cfabort>
		</cfif>
	</cfoutput>
</table>

<!--- we do this fresh every time and compare the results with what exists in zmast.lk_team table --->
<!--- this query identifies UNMATCHED Previous Year's teams across two years, Previous and This, matching is done on leaguecode and longcol (the team description) --->
<cfquery name="AUnmatched" datasource="zmast">
	SELECT
		id as previoustid, 
		longcol as teamname, 
		leaguecode 
	FROM
		fm#PreviousYear#.team
	WHERE 
		<cfif OnlyThisLeague IS "Yes">leaguecode = '#LeagueCodePrefix#' AND</cfif>
		id NOT IN (SELECT id from fm#PreviousYear#.team WHERE left(notes,7)='NoScore')
		AND id NOT IN (SELECT id from fm#PreviousYear#.team where shortcol='GUEST')
		AND id NOT IN (SELECT id from fm#PreviousYear#.team where LEFT(longcol,7)='Winners')
		AND id NOT IN (#ABTeamMatchList1#)
	ORDER BY
		leaguecode, longcol
</cfquery>

<cfset ATeamUnmatchedList = ValueList(AUnmatched.previoustid) >

<table>
	<cfoutput>
	<cfif OnlyThisLeague IS "Yes">
		<tr bgcolor="silver">
			<td><span class="pix10bold">Message</span></td>
			<td><span class="pix10bold">id</span></td>
			<td><span class="pix10bold">#PreviousYearid#</span></td>
			<td><span class="pix10bold">#ThisYearid#</span></td>
			<td><span class="pix10bold">teamname</span></td>
			<td><span class="pix10bold">leaguecode</span></td>
		</tr>
	</cfif>	
	</cfoutput>
	<cfoutput query="AUnmatched">
		<!--- check to see if there is a corresponding row in zmast.lk_team --->
		<cfquery name="Q_lk_team" datasource="zmast">
			SELECT
				id 
			FROM
				lk_team
			WHERE
				#PreviousYearid# = #AUnmatched.previoustid#
				
		</cfquery>
		<cfif Q_lk_team.RecordCount IS 0>
			<!--- No, so insert a row in zmast.lk_team --->
			<cfquery name="ins_lk_team" datasource="zmast">
					INSERT INTO lk_team 
					(#PreviousYearid#,  #ThisYearid#, teamname, leaguecode)
					VALUES
					(#AUnmatched.previoustid#, NULL, '#AUnmatched.teamname#', '#AUnmatched.leaguecode#')
			</cfquery>
			<!--- Get the row we just inserted in zmast.lk_team --->
			<cfquery name="get_lk_team" datasource="zmast">
					SELECT
						id,
						#PreviousYearid# as PrevID,
						#ThisYearid# as ThisID,
						teamname,
						leaguecode
					FROM
						lk_team 
					WHERE 
						#PreviousYearid# = #AUnmatched.previoustid#
						AND #ThisYearid# IS NULL
						AND teamname = '#AUnmatched.teamname#'
						AND leaguecode = '#AUnmatched.leaguecode#'
			</cfquery>
			<cfif get_lk_team.RecordCount IS NOT 1>AUnmatched: ins_lk_team error<cfabort></cfif>
			<cfif OnlyThisLeague IS "Yes">
				<tr>
					<td><span class="pix10">INSERTED UNMATCHED-A</span></td>
					<td><span class="pix10">#get_lk_team.id#</span></td>
					<td><span class="pix10">#get_lk_team.PrevID#</span></td>
					<td><span class="pix10">#get_lk_team.ThisID#</span></td>
					<td><span class="pix10">#get_lk_team.teamname#</span></td>
					<td><span class="pix10">#get_lk_team.leaguecode#</span></td>
				</tr>	
			</cfif>      
		<cfelseif Q_lk_team.RecordCount IS 1>
			<!--- Yes, so update the row in zmast.lk_team --->
			<cfquery name="upd_lk_team" datasource="zmast">
					UPDATE
						lk_team 
					SET 
						#PreviousYearid#=#AUnmatched.previoustid#,
						#ThisYearid#=NULL,
						teamname='#AUnmatched.teamname#',
						leaguecode='#AUnmatched.leaguecode#'
					WHERE
						id = #Q_lk_team.id#
			</cfquery>
			<!--- Get the row we just updated in zmast.lk_team --->
			<cfquery name="get_lk_team" datasource="zmast">
					SELECT
						id,
						#PreviousYearid# as PrevID,
						#ThisYearid# as ThisID,
						teamname,
						leaguecode
					FROM
						lk_team 
					WHERE 
						#PreviousYearid# = #AUnmatched.previoustid#
						AND #ThisYearid# IS NULL
						AND teamname = '#AUnmatched.teamname#'
						AND leaguecode = '#AUnmatched.leaguecode#'
			</cfquery>
			<cfif get_lk_team.RecordCount IS NOT 1>AUnmatched: upd_lk_team error<cfabort></cfif>
			<cfif OnlyThisLeague IS "Yes">
				<tr>
					<td><span class="pix10">UPDATED UNMATCHED-A</span></td>
					<td><span class="pix10">#get_lk_team.id#</span></td>
					<td><span class="pix10">#get_lk_team.PrevID#</span></td>
					<td><span class="pix10">#get_lk_team.ThisID#</span></td>
					<td><span class="pix10">#get_lk_team.teamname#</span></td>
					<td><span class="pix10">#get_lk_team.leaguecode#</span></td>
				</tr>	
			</cfif>      
		<cfelse>
			UNMATCHED-A: ERROR Q_lk_team.RecordCount is #Q_lk_team.RecordCount#<cfabort>
		</cfif>
	</cfoutput>
</table>







<!--- we do this fresh every time and compare the results with what exists in zmast.lk_team table --->
<!--- this query identifies UNMATCHED This Year's teams across two years, Previous and This, matching is done on leaguecode and longcol (the team description) --->
<cfquery name="BUnmatched" datasource="zmast">
	SELECT
		id as thistid, 
		longcol as teamname, 
		leaguecode 
	FROM
		fm#ThisYear#.team
	WHERE 
		<cfif OnlyThisLeague IS "Yes">leaguecode = '#LeagueCodePrefix#' AND</cfif>
		id NOT IN (SELECT id from fm#ThisYear#.team WHERE left(notes,7)='NoScore')
		AND id NOT IN (SELECT id from fm#ThisYear#.team where shortcol='GUEST')
		AND id NOT IN (SELECT id from fm#ThisYear#.team where LEFT(longcol,7)='Winners')
		AND id NOT IN (#ABTeamMatchList2#)
	ORDER BY
		leaguecode, longcol
</cfquery>

<cfset BTeamUnmatchedList = ValueList(BUnmatched.thistid) >

<table>
	<cfoutput>
	<cfif OnlyThisLeague IS "Yes">
		<tr bgcolor="silver">
			<td><span class="pix10bold">Message</span></td>
			<td><span class="pix10bold">id</span></td>
			<td><span class="pix10bold">#PreviousYearid#</span></td>
			<td><span class="pix10bold">#ThisYearid#</span></td>
			<td><span class="pix10bold">teamname</span></td>
			<td><span class="pix10bold">leaguecode</span></td>
		</tr>
	</cfif>	
	</cfoutput>
	<cfoutput query="BUnmatched">
		<!--- check to see if there is a corresponding row in zmast.lk_team --->
		<cfquery name="Q_lk_team" datasource="zmast">
			SELECT
				id 
			FROM
				lk_team
			WHERE
				#ThisYearid# = #BUnmatched.thistid#
		</cfquery>
		<cfif Q_lk_team.RecordCount IS 0>
			<!--- No, so insert a row in zmast.lk_team --->
			<cfquery name="ins_lk_team" datasource="zmast">
					INSERT INTO lk_team 
					(#PreviousYearid#,  #ThisYearid#, teamname, leaguecode)
					VALUES
					(NULL, #BUnmatched.thistid#, '#BUnmatched.teamname#', '#BUnmatched.leaguecode#')
			</cfquery>
			<!--- Get the row we just inserted in zmast.lk_team --->
			<cfquery name="get_lk_team" datasource="zmast">
					SELECT
						id,
						#PreviousYearid# as PrevID,
						#ThisYearid# as ThisID,
						teamname,
						leaguecode
					FROM
						lk_team 
					WHERE 
						#PreviousYearid# IS NULL
						AND #ThisYearid# = #BUnmatched.thistid#
						AND teamname = '#BUnmatched.teamname#'
						AND leaguecode = '#BUnmatched.leaguecode#'
			</cfquery>
			<cfif get_lk_team.RecordCount IS NOT 1>BUnmatched: ins_lk_team error<cfabort></cfif>
			<cfif OnlyThisLeague IS "Yes">
				<tr>
					<td><span class="pix10">INSERTED UNMATCHED-B</span></td>
					<td><span class="pix10">#get_lk_team.id#</span></td>
					<td><span class="pix10">#get_lk_team.PrevID#</span></td>
					<td><span class="pix10">#get_lk_team.ThisID#</span></td>
					<td><span class="pix10">#get_lk_team.teamname#</span></td>
					<td><span class="pix10">#get_lk_team.leaguecode#</span></td>
				</tr>	
			</cfif>      
		<cfelseif Q_lk_team.RecordCount IS 1>
			<!--- Yes, so update the row in zmast.lk_team --->
			<cfquery name="upd_lk_team" datasource="zmast">
					UPDATE
						lk_team 
					SET 
						#PreviousYearid#=NULL,
						#ThisYearid#=#BUnmatched.thistid#,
						teamname='#BUnmatched.teamname#',
						leaguecode='#BUnmatched.leaguecode#'
					WHERE
						id = #Q_lk_team.id#
			</cfquery>
			<!--- Get the row we just updated in zmast.lk_team --->
			<cfquery name="get_lk_team" datasource="zmast">
					SELECT
						id,
						#PreviousYearid# as PrevID,
						#ThisYearid# as ThisID,
						teamname,
						leaguecode
					FROM
						lk_team 
					WHERE 
						#PreviousYearid# IS NULL
						AND #ThisYearid# = #BUnmatched.thistid#
						AND teamname = '#BUnmatched.teamname#'
						AND leaguecode = '#BUnmatched.leaguecode#'
			</cfquery>
			<cfif get_lk_team.RecordCount IS NOT 1>BUnmatched: upd_lk_team error<cfabort></cfif>
			<cfif OnlyThisLeague IS "Yes">
				<tr>
					<td><span class="pix10">UPDATED UNMATCHED-B</span></td>
					<td><span class="pix10">#get_lk_team.id#</span></td>
					<td><span class="pix10">#get_lk_team.PrevID#</span></td>
					<td><span class="pix10">#get_lk_team.ThisID#</span></td>
					<td><span class="pix10">#get_lk_team.teamname#</span></td>
					<td><span class="pix10">#get_lk_team.leaguecode#</span></td>
				</tr>	
			</cfif>      
		<cfelse>
			UNMATCHED-B: ERROR Q_lk_team.RecordCount is #Q_lk_team.RecordCount#<cfabort>
		</cfif>
	</cfoutput>
</table>
