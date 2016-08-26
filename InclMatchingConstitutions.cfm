REDUNDANT CODE

<cfabort>



<!--- we do this fresh every time and compare the results with what exists in zmast.lk_constitution table --->
<!--- this query identifies matching constitutions across two years, Previous and This --->
<cfquery name="ABMatch" datasource="zmast">
	SELECT
		c1.id as previouscid,
		c2.id as thiscid,
		d.divisionname,
		t.teamname,
		o.ordinalname,
		c1.leaguecode
	FROM
		fm#PreviousYear#.constitution c1,
		fm#ThisYear#.constitution c2,
		lk_division d,
		lk_team t,
		lk_ordinal o
	WHERE 
		<cfif OnlyThisLeague IS "Yes">c1.Leaguecode='#LeagueCodePrefix#' AND</cfif>
		c1.DivisionID IN (#ABDivisionMatchList1#)
		AND c1.TeamID IN (#ABTeamMatchList1#)
		AND c1.OrdinalID IN (#ABOrdinalMatchList1#)
		AND c1.leaguecode = c2.leaguecode
		AND c1.DivisionID = d.#PreviousYearid#
		AND d.#ThisYearid# = c2.DivisionID
		AND c1.TeamID = t.#PreviousYearid#
		AND t.#ThisYearid# = c2.TeamID
		AND c1.OrdinalID = o.#PreviousYearid#
		AND o.#ThisYearid# = c2.OrdinalID
	ORDER BY
		c1.leaguecode, c1.id
</cfquery>

<cfset ABConstitutionMatchList1 = ValueList(ABMatch.previouscid) >
<cfset ABConstitutionMatchList2 = ValueList(ABMatch.thiscid) >


<table>
	<tr bgcolor="silver">
		<td><span class="pix13bold">Processing Constitutions</span></td>
	</tr>
	<cfflush>
	<cfoutput>
	<tr bgcolor="silver">
		<td><span class="pix10bold">Message</span></td>
		<td><span class="pix10bold">id</span></td>
		<td><span class="pix10bold">#PreviousYearid#</span></td>
		<td><span class="pix10bold">#ThisYearid#</span></td>
		<td><span class="pix10bold">divisionname</span></td>
		<td><span class="pix10bold">teamname</span></td>
		<td><span class="pix10bold">ordinalname</span></td>
		<td><span class="pix10bold">leaguecode</span></td>
	</tr>	
	</cfoutput>
	<cfoutput query="ABMatch">
		<!--- check to see if there is a corresponding row in zmast.lk_constitution --->
		<cfquery name="Q_lk_constitution" datasource="zmast">
			SELECT
				id,
				bypass_flag
			FROM
				lk_constitution
			WHERE
				#PreviousYearid# = #ABMatch.previouscid#
		</cfquery>
		<cfif Q_lk_constitution.RecordCount IS 0>
			<!--- No, so insert a row in zmast.lk_constitution --->
			<cfquery name="ins_lk_constitution" datasource="zmast">
					INSERT INTO lk_constitution 
					(#PreviousYearid#,  #ThisYearid#, divisionname, teamname, ordinalname, leaguecode, bypass_flag, notes)
					VALUES
					(#ABMatch.previouscid#, #ABMatch.thiscid#, '#ABMatch.divisionname#','#ABMatch.teamname#', '#ABMatch.ordinalname#', '#ABMatch.leaguecode#', 0, '')
			</cfquery>
			<!--- Get the row we just inserted in zmast.lk_constitution --->
			<cfquery name="get_lk_constitution" datasource="zmast">
					SELECT
						id,
						#PreviousYearid# as PrevID,
						#ThisYearid# as ThisID,
						divisionname, 
						teamname, 
						ordinalname,
						leaguecode
					FROM
						lk_constitution 
					WHERE 
						#PreviousYearid# = #ABMatch.previouscid#
			</cfquery>
			<cfif get_lk_constitution.RecordCount IS NOT 1>
				ABMatch: ins_lk_constitution error
				<cfabort>
			</cfif>
			<tr>
				<td><span class="pix10">INSERTED MATCHING</span></td>
				<td><span class="pix10">#get_lk_constitution.id#</span></td>
				<td><span class="pix10">#get_lk_constitution.PrevID#</span></td>
				<td><span class="pix10">#get_lk_constitution.ThisID#</span></td>
				<td><span class="pix10">#get_lk_constitution.divisionname#</span></td>
				<td><span class="pix10">#get_lk_constitution.teamname#</span></td>
				<td><span class="pix10">#get_lk_constitution.ordinalname#</span></td>
				<td><span class="pix10">#get_lk_constitution.leaguecode#</span></td>
			</tr>	
		<cfelseif Q_lk_constitution.RecordCount IS 1>
			<!--- do we bypass this one?  --->
			<cfif Q_lk_constitution.bypass_flag IS 1>
				<!--- Leave it alone for manual changes only ..... --->
				<tr>
					<td><span class="pix10">BYPASSED MATCHING</span></td>
					<td><span class="pix10">#get_lk_constitution.id#</span></td>
					<td><span class="pix10">#get_lk_constitution.PrevID#</span></td>
					<td><span class="pix10">#get_lk_constitution.ThisID#</span></td>
					<td><span class="pix10">#get_lk_constitution.divisionname#</span></td>
					<td><span class="pix10">#get_lk_constitution.teamname#</span></td>
					<td><span class="pix10">#get_lk_constitution.ordinalname#</span></td>
					<td><span class="pix10">#get_lk_constitution.leaguecode#</span></td>
				</tr>	
			<cfelse>
				<!--- Update the row in zmast.lk_constitution --->
				<cfquery name="upd_lk_constitution" datasource="zmast">
						UPDATE
							lk_constitution 
						SET 
							#PreviousYearid#=#ABMatch.previouscid#,
							#ThisYearid#=#ABMatch.thiscid#,
							divisionname='#ABMatch.divisionname#',
							teamname='#ABMatch.teamname#',
							ordinalname='#ABMatch.ordinalname#',
							leaguecode='#ABMatch.leaguecode#'
						WHERE
							id = #Q_lk_constitution.id#
				</cfquery>
				<!--- Get the row we just updated in zmast.lk_constitution --->
				<cfquery name="get_lk_constitution" datasource="zmast">
						SELECT
							id,
							#PreviousYearid# as PrevID,
							#ThisYearid# as ThisID,
							divisionname,
							teamname,
							ordinalname,
							leaguecode
						FROM
							lk_constitution 
						WHERE 
							#PreviousYearid# = #ABMatch.previouscid#
				</cfquery>
				<cfif get_lk_constitution.RecordCount IS NOT 1>
					ABMatch: upd_lk_constitution error
					<cfabort>
				</cfif>
				<tr>
					<td><span class="pix10">UPDATED MATCHING</span></td>
					<td><span class="pix10">#get_lk_constitution.id#</span></td>
					<td><span class="pix10">#get_lk_constitution.PrevID#</span></td>
					<td><span class="pix10">#get_lk_constitution.ThisID#</span></td>
					<td><span class="pix10">#get_lk_constitution.divisionname#</span></td>
					<td><span class="pix10">#get_lk_constitution.teamname#</span></td>
					<td><span class="pix10">#get_lk_constitution.ordinalname#</span></td>
					<td><span class="pix10">#get_lk_constitution.leaguecode#</span></td>
				</tr>	
			</cfif>
		<cfelse>
			MATCHING: ERROR Q_lk_constitution.RecordCount is #Q_lk_constitution.RecordCount#<cfabort>
		</cfif>
		<cfflush>
	</cfoutput>
</table>


<!--- we do this fresh every time and compare the results with what exists in zmast.lk_constitution table --->
<!--- this query identifies UNMATCHED Previous Year's constitutions across two years, Previous and This --->
<cfquery name="AUnmatched" datasource="zmast">
	SELECT
		c.id as previouscid,
		(SELECT divisionname FROM lk_division WHERE #PreviousYearid# = c.DivisionID) as divisionname,
		(SELECT teamname FROM lk_team WHERE #PreviousYearid# = c.TeamID) as teamname,
		(SELECT ordinalname FROM lk_ordinal WHERE #PreviousYearid# = c.OrdinalID) as ordinalname,
		c.leaguecode 
	FROM
		fm#PreviousYear#.constitution c
	WHERE 
		<cfif OnlyThisLeague IS "Yes">c.Leaguecode='#LeagueCodePrefix#' AND</cfif>
		c.id NOT IN (#ABConstitutionMatchList1#)
		<!--- AND c.DivisionID NOT IN (SELECT id from fm#PreviousYear#.division WHERE left(notes,2)='KO') --->
		AND c.DivisionID NOT IN (SELECT id from fm#PreviousYear#.division where longcol='Miscellaneous')
		AND c.DivisionID NOT IN (SELECT id from fm#PreviousYear#.division where longcol='Friendly')
		AND c.Teamid NOT IN (SELECT id from fm#PreviousYear#.team WHERE left(notes,7)='NoScore')
		AND c.Teamid NOT IN (SELECT id from fm#PreviousYear#.team where shortcol='GUEST')
		AND c.Teamid NOT IN (SELECT id from fm#PreviousYear#.team where LEFT(longcol,7)='Winners')
	ORDER BY
		c.leaguecode, c.id
</cfquery>

<cfset AUnmatchedList = ValueList(AUnmatched.previouscid) >

<table>
	<cfoutput>
	<tr bgcolor="silver">
		<td><span class="pix10bold">Message</span></td>
		<td><span class="pix10bold">id</span></td>
		<td><span class="pix10bold">#PreviousYearid#</span></td>
		<td><span class="pix10bold">#ThisYearid#</span></td>
		<td><span class="pix10bold">divisionname</span></td>
		<td><span class="pix10bold">teamname</span></td>
		<td><span class="pix10bold">ordinalname</span></td>
		<td><span class="pix10bold">leaguecode</span></td>
		<td><span class="pix10bold">notes</span></td>
	</tr>	
	</cfoutput>
	<cfoutput query="AUnmatched">
		<!--- check to see if there is a corresponding row in zmast.lk_constitution --->
		<cfquery name="Q_lk_constitution" datasource="zmast">
			SELECT
				id,
				bypass_flag
			FROM
				lk_constitution
			WHERE
				#PreviousYearid# = #AUnmatched.previouscid#
		</cfquery>
		<cfif Q_lk_constitution.RecordCount IS 0>
			<!--- No, so insert a row in zmast.lk_constitution --->
			<cfquery name="ins_lk_constitution" datasource="zmast">
					INSERT INTO lk_constitution 
					(#PreviousYearid#,  #ThisYearid#, divisionname, teamname, ordinalname, leaguecode, bypass_flag, notes)
					VALUES
					(#AUnmatched.previouscid#, NULL, '#AUnmatched.divisionname#', '#AUnmatched.teamname#', '#AUnmatched.ordinalname#', '#AUnmatched.leaguecode#', 0, '')
			</cfquery>
			<!--- Get the row we just inserted in zmast.lk_constitution --->
			<cfquery name="get_lk_constitution" datasource="zmast">
					SELECT
						id,
						#PreviousYearid# as PrevID,
						#ThisYearid# as ThisID,
						divisionname,
						teamname,
						ordinalname,
						leaguecode
					FROM
						lk_constitution 
					WHERE 
						#PreviousYearid# = #AUnmatched.previouscid#
						AND #ThisYearid# IS NULL
						AND divisionname = '#AUnmatched.divisionname#'
						AND teamname = '#AUnmatched.teamname#'
						AND ordinalname = '#AUnmatched.ordinalname#'
						AND leaguecode = '#AUnmatched.leaguecode#'
			</cfquery>
			<cfif get_lk_constitution.RecordCount IS NOT 1>
				AUnmatched: ins_lk_constitution error
				<cfabort>
			</cfif>
			<tr>
				<td><span class="pix10">INSERTED UNMATCHED-A</span></td>
				<td><span class="pix10">#get_lk_constitution.id#</span></td>
				<td><span class="pix10">#get_lk_constitution.PrevID#</span></td>
				<td><span class="pix10">#get_lk_constitution.ThisID#</span></td>
				<td><span class="pix10">#get_lk_constitution.divisionname#</span></td>
				<td><span class="pix10">#get_lk_constitution.teamname#</span></td>
				<td><span class="pix10">#get_lk_constitution.ordinalname#</span></td>
				<td><span class="pix10">#get_lk_constitution.leaguecode#</span></td>
			</tr>	
			        
		<cfelseif Q_lk_constitution.RecordCount IS 1>
			<!--- do we bypass this one?  --->
			<cfif Q_lk_constitution.bypass_flag IS 1>
				<!--- Leave it alone for manual changes only ..... --->
				<cfquery name="get_lk_constitution" datasource="zmast">
						SELECT
							id,
							#PreviousYearid# as PrevID,
							#ThisYearid# as ThisID,
							divisionname,
							teamname,
							ordinalname,
							leaguecode,
							notes
						FROM
							lk_constitution 
						WHERE 
							id = #Q_lk_constitution.id#
				</cfquery>
				
				<tr>
					<td><span class="pix10">BYPASSED UNMATCHED-A</span></td>
					<td><span class="pix10">#get_lk_constitution.id#</span></td>
					<td><span class="pix10">#get_lk_constitution.PrevID#</span></td>
					<td><span class="pix10">#get_lk_constitution.ThisID#</span></td>
					<td><span class="pix10">#get_lk_constitution.divisionname#</span></td>
					<td><span class="pix10">#get_lk_constitution.teamname#</span></td>
					<td><span class="pix10">#get_lk_constitution.ordinalname#</span></td>
					<td><span class="pix10">#get_lk_constitution.leaguecode#</span></td>
					<td><span class="pix10">#get_lk_constitution.notes#</span></td>					
				</tr>	
			<cfelse>
				<!--- Update the row in zmast.lk_constitution --->
				<cfquery name="upd_lk_constitution" datasource="zmast">
						UPDATE
							lk_constitution 
						SET 
							#PreviousYearid#=#AUnmatched.previouscid#,
							#ThisYearid#=NULL,
							divisionname='#AUnmatched.divisionname#',
							teamname='#AUnmatched.teamname#',
							ordinalname='#AUnmatched.ordinalname#',
							leaguecode='#AUnmatched.leaguecode#'
						WHERE
							id = #Q_lk_constitution.id#
				</cfquery>
				<!--- Get the row we just updated in zmast.lk_constitution --->
				<cfquery name="get_lk_constitution" datasource="zmast">
						SELECT
							id,
							#PreviousYearid# as PrevID,
							#ThisYearid# as ThisID,
							divisionname,
							teamname,
							ordinalname,
							leaguecode
						FROM
							lk_constitution 
						WHERE 
							#PreviousYearid# = #AUnmatched.previouscid#
							AND #ThisYearid# IS NULL
							AND divisionname = '#AUnmatched.divisionname#'
							AND teamname = '#AUnmatched.teamname#'
							AND ordinalname = '#AUnmatched.ordinalname#'
							AND leaguecode = '#AUnmatched.leaguecode#'
				</cfquery>
				<cfif get_lk_constitution.RecordCount IS NOT 1>
					AUnmatched: upd_lk_constitution error
					<cfabort>
				</cfif>
				<tr>
					<td><span class="pix10">UPDATED UNMATCHED-A</span></td>
					<td><span class="pix10">#get_lk_constitution.id#</span></td>
					<td><span class="pix10">#get_lk_constitution.PrevID#</span></td>
					<td><span class="pix10">#get_lk_constitution.ThisID#</span></td>
					<td><span class="pix10">#get_lk_constitution.divisionname#</span></td>
					<td><span class="pix10">#get_lk_constitution.teamname#</span></td>
					<td><span class="pix10">#get_lk_constitution.ordinalname#</span></td>
					<td><span class="pix10">#get_lk_constitution.leaguecode#</span></td>
				</tr>	
			</cfif>
		<cfelse>
			UNMATCHED-A: ERROR Q_lk_constitution.RecordCount is #Q_lk_constitution.RecordCount#<cfabort>
		</cfif>
		<cfflush>
	</cfoutput>
</table>




<!--- we do this fresh every time and compare the results with what exists in zmast.lk_constitution table --->
<!--- this query identifies UNMATCHED THIS Year's constitutions across two years, Previous and This --->
<cfquery name="BUnmatched" datasource="zmast">
	SELECT
		c.id as thiscid,
		(SELECT divisionname FROM lk_division WHERE #ThisYearid# = c.DivisionID) as divisionname,
		(SELECT teamname FROM lk_team WHERE #ThisYearid# = c.TeamID) as teamname,
		(SELECT ordinalname FROM lk_ordinal WHERE #ThisYearid# = c.OrdinalID) as ordinalname,
		c.leaguecode 
	FROM
		fm#ThisYear#.constitution c
	WHERE 
		<cfif OnlyThisLeague IS "Yes">c.Leaguecode='#LeagueCodePrefix#' AND</cfif>
		c.id NOT IN (#ABConstitutionMatchList2#)
		<!--- AND c.DivisionID NOT IN (SELECT id from fm#ThisYear#.division WHERE left(notes,2)='KO') --->
		AND c.DivisionID NOT IN (SELECT id from fm#ThisYear#.division where longcol='Miscellaneous')
		AND c.DivisionID NOT IN (SELECT id from fm#ThisYear#.division where longcol='Friendly')
		AND c.Teamid NOT IN (SELECT id from fm#ThisYear#.team WHERE left(notes,7)='NoScore')
		AND c.Teamid NOT IN (SELECT id from fm#ThisYear#.team where shortcol='GUEST')
		AND c.Teamid NOT IN (SELECT id from fm#ThisYear#.team where LEFT(longcol,7)='Winners')
	ORDER BY
		c.leaguecode, c.id
</cfquery>

<cfset BUnmatchedList = ValueList(BUnmatched.thiscid) >

<table>
	<cfoutput>
	<tr bgcolor="silver">
		<td><span class="pix10bold">Message</span></td>
		<td><span class="pix10bold">id</span></td>
		<td><span class="pix10bold">#PreviousYearid#</span></td>
		<td><span class="pix10bold">#ThisYearid#</span></td>
		<td><span class="pix10bold">divisionname</span></td>
		<td><span class="pix10bold">teamname</span></td>
		<td><span class="pix10bold">ordinalname</span></td>
		<td><span class="pix10bold">leaguecode</span></td>
		<td><span class="pix10bold">notes</span></td>
	</tr>	
	</cfoutput>
	<cfoutput query="BUnmatched">
		<!--- check to see if there is a corresponding row in zmast.lk_constitution --->
		<cfquery name="Q_lk_constitution" datasource="zmast">
			SELECT
				id,
				bypass_flag
			FROM
				lk_constitution
			WHERE
				#ThisYearid# = #BUnmatched.thiscid#
		</cfquery>
		<cfif Q_lk_constitution.RecordCount IS 0>
			<!--- No, so insert a row in zmast.lk_constitution --->
			<cfquery name="ins_lk_constitution" datasource="zmast">
					INSERT INTO lk_constitution 
					(#PreviousYearid#,  #ThisYearid#, divisionname, teamname, ordinalname, leaguecode, bypass_flag, notes)
					VALUES
					(NULL, #BUnmatched.thiscid#, '#BUnmatched.divisionname#', '#BUnmatched.teamname#', '#BUnmatched.ordinalname#', '#BUnmatched.leaguecode#', 0, '')
			</cfquery>
			<!--- Get the row we just inserted in zmast.lk_constitution --->
			<cfquery name="get_lk_constitution" datasource="zmast">
					SELECT
						id,
						#PreviousYearid# as PrevID,
						#ThisYearid# as ThisID,
						divisionname,
						teamname,
						ordinalname,
						leaguecode
					FROM
						lk_constitution 
					WHERE 
						#PreviousYearid# IS NULL 
						AND #ThisYearid# = #BUnmatched.thiscid#
						AND divisionname = '#BUnmatched.divisionname#'
						AND teamname = '#BUnmatched.teamname#'
						AND ordinalname = '#BUnmatched.ordinalname#'
						AND leaguecode = '#BUnmatched.leaguecode#'
			</cfquery>
			<cfif get_lk_constitution.RecordCount IS NOT 1>
				BUnmatched: ins_lk_constitution error
				<cfabort>
			</cfif>
			<tr>
				<td><span class="pix10">INSERTED UNMATCHED-B</span></td>
				<td><span class="pix10">#get_lk_constitution.id#</span></td>
				<td><span class="pix10">#get_lk_constitution.PrevID#</span></td>
				<td><span class="pix10">#get_lk_constitution.ThisID#</span></td>
				<td><span class="pix10">#get_lk_constitution.divisionname#</span></td>
				<td><span class="pix10">#get_lk_constitution.teamname#</span></td>
				<td><span class="pix10">#get_lk_constitution.ordinalname#</span></td>
				<td><span class="pix10">#get_lk_constitution.leaguecode#</span></td>
			</tr>	
			        
		<cfelseif Q_lk_constitution.RecordCount IS 1>
			<!--- do we bypass this one?  --->
			<cfif Q_lk_constitution.bypass_flag IS 1>
				<!--- Leave it alone for manual changes only ..... --->
				<cfquery name="get_lk_constitution" datasource="zmast">
						SELECT
							id,
							#PreviousYearid# as PrevID,
							#ThisYearid# as ThisID,
							divisionname,
							teamname,
							ordinalname,
							leaguecode,
							notes
						FROM
							lk_constitution 
						WHERE 
							id = #Q_lk_constitution.id#
				</cfquery>
				
				<tr>
					<td><span class="pix10">BYPASSED UNMATCHED-B</span></td>
					<td><span class="pix10">#get_lk_constitution.id#</span></td>
					<td><span class="pix10">#get_lk_constitution.PrevID#</span></td>
					<td><span class="pix10">#get_lk_constitution.ThisID#</span></td>
					<td><span class="pix10">#get_lk_constitution.divisionname#</span></td>
					<td><span class="pix10">#get_lk_constitution.teamname#</span></td>
					<td><span class="pix10">#get_lk_constitution.ordinalname#</span></td>
					<td><span class="pix10">#get_lk_constitution.leaguecode#</span></td>
					<td><span class="pix10">#get_lk_constitution.notes#</span></td>					
				</tr>	
			<cfelse>
				<!--- Update the row in zmast.lk_constitution --->
				<cfquery name="upd_lk_constitution" datasource="zmast">
						UPDATE
							lk_constitution 
						SET 
							#PreviousYearid#=NULL,
							#ThisYearid#=#BUnmatched.thiscid#,
							divisionname='#BUnmatched.divisionname#',
							teamname='#BUnmatched.teamname#',
							ordinalname='#BUnmatched.ordinalname#',
							leaguecode='#BUnmatched.leaguecode#'
						WHERE
							id = #Q_lk_constitution.id#
				</cfquery>
				<!--- Get the row we just updated in zmast.lk_constitution --->
				<cfquery name="get_lk_constitution" datasource="zmast">
						SELECT
							id,
							#PreviousYearid# as PrevID,
							#ThisYearid# as ThisID,
							divisionname,
							teamname,
							ordinalname,
							leaguecode
						FROM
							lk_constitution 
						WHERE 
							#PreviousYearid# IS NULL 
							AND #ThisYearid# = #BUnmatched.thiscid#
							AND divisionname = '#BUnmatched.divisionname#'
							AND teamname = '#BUnmatched.teamname#'
							AND ordinalname = '#BUnmatched.ordinalname#'
							AND leaguecode = '#BUnmatched.leaguecode#'
				</cfquery>
				<cfif get_lk_constitution.RecordCount IS NOT 1>
					BUnmatched: upd_lk_constitution error
					<cfabort>
				</cfif>
				<tr>
					<td><span class="pix10">UPDATED UNMATCHED-B</span></td>
					<td><span class="pix10">#get_lk_constitution.id#</span></td>
					<td><span class="pix10">#get_lk_constitution.PrevID#</span></td>
					<td><span class="pix10">#get_lk_constitution.ThisID#</span></td>
					<td><span class="pix10">#get_lk_constitution.divisionname#</span></td>
					<td><span class="pix10">#get_lk_constitution.teamname#</span></td>
					<td><span class="pix10">#get_lk_constitution.ordinalname#</span></td>
					<td><span class="pix10">#get_lk_constitution.leaguecode#</span></td>
				</tr>	
			</cfif>
		<cfelse>
			UNMATCHED-B: ERROR Q_lk_constitution.RecordCount is #Q_lk_constitution.RecordCount#<cfabort>
		</cfif>
		<cfflush>
	</cfoutput>
</table>
