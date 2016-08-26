REDUNDANT CODE

<cfabort>


<!--- we do this fresh every time and compare the results with what exists in zmast.lk_division table --->
<!--- this query identifies matching divisions across two years, Previous and This, matching is done on leaguecode and longcol (the division description) --->
<cfquery name="ABMatch" datasource="zmast">
	SELECT
		d1.id as previousdid, 
		d2.id as thisdid, 
		d1.longcol as divisionname, 
		d1.leaguecode 
	FROM
		fm#PreviousYear#.division d1,
		fm#ThisYear#.division d2
	WHERE 
		<cfif OnlyThisLeague IS "Yes">d1.leaguecode = '#LeagueCodePrefix#' AND</cfif>
		<!--- d1.id NOT IN (SELECT id from fm#PreviousYear#.division WHERE left(notes,2)='KO') AND --->
		d1.id NOT IN (SELECT id from fm#PreviousYear#.division where longcol='Miscellaneous')
		AND d1.id NOT IN (SELECT id from fm#PreviousYear#.division where longcol='Friendly')
		AND d1.leaguecode = d2.leaguecode
		AND d1.longcol = d2.longcol
	ORDER BY
		d1.leaguecode, d1.mediumcol
</cfquery>

<cfset ABDivisionMatchList1 = ValueList(ABMatch.previousdid) >
<cfset ABDivisionMatchList2 = ValueList(ABMatch.thisdid) >


<table>
	<tr bgcolor="silver">
		<td><span class="pix13bold">Processing Divisions</span></td>
	</tr>
	<cfflush>
	<cfoutput>
	<cfif OnlyThisLeague IS "Yes">
		<tr bgcolor="silver">
			<td><span class="pix10bold">Message</span></td>
			<td><span class="pix10bold">id</span></td>
			<td><span class="pix10bold">#PreviousYearid#</span></td>
			<td><span class="pix10bold">#ThisYearid#</span></td>
			<td><span class="pix10bold">divisionname</span></td>
			<td><span class="pix10bold">leaguecode</span></td>
		</tr>
	</cfif>	
	</cfoutput>
	<cfoutput query="ABMatch">
		<!--- check to see if there is a corresponding row in zmast.lk_division --->
		<cfquery name="Q_lk_division" datasource="zmast">
			SELECT
				id 
			FROM
				lk_division
			WHERE
				#PreviousYearid# = #ABMatch.previousdid#
		</cfquery>
		<cfif Q_lk_division.RecordCount IS 0>
			<!--- No, so insert a row in zmast.lk_division --->
			<cfquery name="ins_lk_division" datasource="zmast">
					INSERT INTO lk_division 
					(#PreviousYearid#,  #ThisYearid#, divisionname, leaguecode)
					VALUES
					(#ABMatch.previousdid#, #ABMatch.thisdid#,  '#ABMatch.divisionname#', '#ABMatch.leaguecode#')
			</cfquery>
			<!--- Get the row we just inserted in zmast.lk_division --->
			<cfquery name="get_lk_division" datasource="zmast">
					SELECT
						id,
						#PreviousYearid# as PrevID,
						#ThisYearid# as ThisID,
						divisionname,
						leaguecode
					FROM
						lk_division 
					WHERE 
						#PreviousYearid# = #ABMatch.previousdid#
			</cfquery>
			<cfif get_lk_division.RecordCount IS NOT 1>ABMatch: ins_lk_division error<cfabort></cfif>
			<cfif OnlyThisLeague IS "Yes">
				<tr>
					<td><span class="pix10">INSERTED MATCHING</span></td>
					<td><span class="pix10">#get_lk_division.id#</span></td>
					<td><span class="pix10">#get_lk_division.PrevID#</span></td>
					<td><span class="pix10">#get_lk_division.ThisID#</span></td>
					<td><span class="pix10">#get_lk_division.divisionname#</span></td>
					<td><span class="pix10">#get_lk_division.leaguecode#</span></td>
				</tr>	
			</cfif>   
		<cfelseif Q_lk_division.RecordCount IS 1>
			<!--- Yes, so update the row in zmast.lk_division --->
			<cfquery name="upd_lk_division" datasource="zmast">
					UPDATE
						lk_division 
					SET 
						#PreviousYearid#=#ABMatch.previousdid#,
						#ThisYearid#=#ABMatch.thisdid#,
						divisionname='#ABMatch.divisionname#',
						leaguecode='#ABMatch.leaguecode#'
					WHERE
						id = #Q_lk_division.id#
			</cfquery>
			<!--- Get the row we just updated in zmast.lk_division --->
			<cfquery name="get_lk_division" datasource="zmast">
					SELECT
						id,
						#PreviousYearid# as PrevID,
						#ThisYearid# as ThisID,
						divisionname,
						leaguecode
					FROM
						lk_division 
					WHERE 
						#PreviousYearid# = #ABMatch.previousdid#
			</cfquery>
			<cfif get_lk_division.RecordCount IS NOT 1>ABMatch: upd_lk_division error<cfabort></cfif>
			<cfif OnlyThisLeague IS "Yes">
				<tr>
					<td><span class="pix10">UPDATED MATCHING</span></td>
					<td><span class="pix10">#get_lk_division.id#</span></td>
					<td><span class="pix10">#get_lk_division.PrevID#</span></td>
					<td><span class="pix10">#get_lk_division.ThisID#</span></td>
					<td><span class="pix10">#get_lk_division.divisionname#</span></td>
					<td><span class="pix10">#get_lk_division.leaguecode#</span></td>
				</tr>	
			</cfif>  
		<cfelse>
			MATCHING: ERROR Q_lk_division.RecordCount is #Q_lk_division.RecordCount#<cfabort>
		</cfif>
	</cfoutput>
</table>



<!--- we do this fresh every time and compare the results with what exists in zmast.lk_division table --->
<!--- this query identifies UNMATCHED Previous Year's divisions across two years, Previous and This, matching is done on leaguecode and longcol (the division description) --->
<cfquery name="AUnmatched" datasource="zmast">
	SELECT
		id as previousdid, 
		longcol as divisionname, 
		leaguecode 
	FROM
		fm#PreviousYear#.division
	WHERE 
		<cfif OnlyThisLeague IS "Yes">leaguecode = '#LeagueCodePrefix#' AND</cfif>
		<!--- id NOT IN (SELECT id from fm#PreviousYear#.division WHERE left(notes,2)='KO') AND --->
		id NOT IN (SELECT id from fm#PreviousYear#.division where longcol='Miscellaneous')
		AND id NOT IN (SELECT id from fm#PreviousYear#.division where longcol='Friendly')
		AND id NOT IN (#ABDivisionMatchList1#)
	ORDER BY
		leaguecode, mediumcol
</cfquery>

<cfset ADivisionUnmatchedList = ValueList(AUnmatched.previousdid) >

<table>
	<cfoutput>
	<cfif OnlyThisLeague IS "Yes">
		<tr bgcolor="silver">
			<td><span class="pix10bold">Message</span></td>
			<td><span class="pix10bold">id</span></td>
			<td><span class="pix10bold">#PreviousYearid#</span></td>
			<td><span class="pix10bold">#ThisYearid#</span></td>
			<td><span class="pix10bold">divisionname</span></td>
			<td><span class="pix10bold">leaguecode</span></td>
		</tr>
	</cfif>	
	</cfoutput>
	<cfoutput query="AUnmatched">
		<!--- check to see if there is a corresponding row in zmast.lk_division --->
		<cfquery name="Q_lk_division" datasource="zmast">
			SELECT
				id 
			FROM
				lk_division
			WHERE
				#PreviousYearid# = #AUnmatched.previousdid#
				
		</cfquery>
		<cfif Q_lk_division.RecordCount IS 0>
			<!--- No, so insert a row in zmast.lk_division --->
			<cfquery name="ins_lk_division" datasource="zmast">
					INSERT INTO lk_division 
					(#PreviousYearid#,  #ThisYearid#, divisionname, leaguecode)
					VALUES
					(#AUnmatched.previousdid#, NULL, '#AUnmatched.divisionname#', '#AUnmatched.leaguecode#')
			</cfquery>
			<!--- Get the row we just inserted in zmast.lk_division --->
			<cfquery name="get_lk_division" datasource="zmast">
					SELECT
						id,
						#PreviousYearid# as PrevID,
						#ThisYearid# as ThisID,
						divisionname,
						leaguecode
					FROM
						lk_division 
					WHERE 
						#PreviousYearid# = #AUnmatched.previousdid#
						AND #ThisYearid# IS NULL
						AND divisionname = '#AUnmatched.divisionname#'
						AND leaguecode = '#AUnmatched.leaguecode#'
			</cfquery>
			<cfif get_lk_division.RecordCount IS NOT 1>AUnmatched: ins_lk_division error<cfabort></cfif>
			<cfif OnlyThisLeague IS "Yes">
				<tr>
					<td><span class="pix10">INSERTED UNMATCHED-A</span></td>
					<td><span class="pix10">#get_lk_division.id#</span></td>
					<td><span class="pix10">#get_lk_division.PrevID#</span></td>
					<td><span class="pix10">#get_lk_division.ThisID#</span></td>
					<td><span class="pix10">#get_lk_division.divisionname#</span></td>
					<td><span class="pix10">#get_lk_division.leaguecode#</span></td>
				</tr>	
			</cfif>      
		<cfelseif Q_lk_division.RecordCount IS 1>
			<!--- Yes, so update the row in zmast.lk_division --->
			<cfquery name="upd_lk_division" datasource="zmast">
					UPDATE
						lk_division 
					SET 
						#PreviousYearid#=#AUnmatched.previousdid#,
						#ThisYearid#=NULL,
						divisionname='#AUnmatched.divisionname#',
						leaguecode='#AUnmatched.leaguecode#'
					WHERE
						id = #Q_lk_division.id#
			</cfquery>
			<!--- Get the row we just updated in zmast.lk_division --->
			<cfquery name="get_lk_division" datasource="zmast">
					SELECT
						id,
						#PreviousYearid# as PrevID,
						#ThisYearid# as ThisID,
						divisionname,
						leaguecode
					FROM
						lk_division 
					WHERE 
						#PreviousYearid# = #AUnmatched.previousdid#
						AND #ThisYearid# IS NULL
						AND divisionname = '#AUnmatched.divisionname#'
						AND leaguecode = '#AUnmatched.leaguecode#'
			</cfquery>
			<cfif get_lk_division.RecordCount IS NOT 1>AUnmatched: upd_lk_division error<cfabort></cfif>
			<cfif OnlyThisLeague IS "Yes">
				<tr>
					<td><span class="pix10">UPDATED UNMATCHED-A</span></td>
					<td><span class="pix10">#get_lk_division.id#</span></td>
					<td><span class="pix10">#get_lk_division.PrevID#</span></td>
					<td><span class="pix10">#get_lk_division.ThisID#</span></td>
					<td><span class="pix10">#get_lk_division.divisionname#</span></td>
					<td><span class="pix10">#get_lk_division.leaguecode#</span></td>
				</tr>	
			</cfif>     
		<cfelse>
			UNMATCHED-A: ERROR Q_lk_division.RecordCount is #Q_lk_division.RecordCount#<cfabort>
		</cfif>
	</cfoutput>
</table>








<!--- we do this fresh every time and compare the results with what exists in zmast.lk_division table --->
<!--- this query identifies UNMATCHED This Year's divisions across two years, Previous and This, matching is done on leaguecode and longcol (the division description) --->
<cfquery name="BUnmatched" datasource="zmast">
	SELECT
		id as thisdid, 
		longcol as divisionname, 
		leaguecode 
	FROM
		fm#ThisYear#.division
	WHERE 
		<cfif OnlyThisLeague IS "Yes">leaguecode = '#LeagueCodePrefix#' AND</cfif>
		<!--- id NOT IN (SELECT id from fm#ThisYear#.division WHERE left(notes,2)='KO') --->
		id NOT IN (SELECT id from fm#ThisYear#.division where longcol='Miscellaneous')
		AND id NOT IN (SELECT id from fm#ThisYear#.division where longcol='Friendly')
		AND id NOT IN (#ABDivisionMatchList2#)
	ORDER BY
		leaguecode, mediumcol
</cfquery>

<cfset BDivisionUnmatchedList = ValueList(BUnmatched.thisdid) >

<table>
	<cfoutput>
	<cfif OnlyThisLeague IS "Yes">
		<tr bgcolor="silver">
			<td><span class="pix10bold">Message</span></td>
			<td><span class="pix10bold">id</span></td>
			<td><span class="pix10bold">#PreviousYearid#</span></td>
			<td><span class="pix10bold">#ThisYearid#</span></td>
			<td><span class="pix10bold">divisionname</span></td>
			<td><span class="pix10bold">leaguecode</span></td>
		</tr>
	</cfif>	
	</cfoutput>
	<cfoutput query="BUnmatched">
		<!--- check to see if there is a corresponding row in zmast.lk_division --->
		<cfquery name="Q_lk_division" datasource="zmast">
			SELECT
				id 
			FROM
				lk_division
			WHERE
				#ThisYearid# = #BUnmatched.thisdid#
				
		</cfquery>
		<cfif Q_lk_division.RecordCount IS 0>
			<!--- No, so insert a row in zmast.lk_division --->
			<cfquery name="ins_lk_division" datasource="zmast">
					INSERT INTO lk_division 
					(#PreviousYearid#,  #ThisYearid#, divisionname, leaguecode)
					VALUES
					(NULL, #BUnmatched.Thisdid#, '#BUnmatched.divisionname#', '#BUnmatched.leaguecode#')
			</cfquery>
			<!--- Get the row we just inserted in zmast.lk_division --->
			<cfquery name="get_lk_division" datasource="zmast">
					SELECT
						id,
						#PreviousYearid# as PrevID,
						#ThisYearid# as ThisID,
						divisionname,
						leaguecode
					FROM
						lk_division 
					WHERE 
						#PreviousYearid# IS NULL
						AND #ThisYearid# = #BUnmatched.thisdid#
						AND divisionname = '#BUnmatched.divisionname#'
						AND leaguecode = '#BUnmatched.leaguecode#'
			</cfquery>
			<cfif get_lk_division.RecordCount IS NOT 1>BUnmatched: ins_lk_division error<cfabort></cfif>
			<cfif OnlyThisLeague IS "Yes">
				<tr>
					<td><span class="pix10">INSERTED UNMATCHED-B</span></td>
					<td><span class="pix10">#get_lk_division.id#</span></td>
					<td><span class="pix10">#get_lk_division.PrevID#</span></td>
					<td><span class="pix10">#get_lk_division.ThisID#</span></td>
					<td><span class="pix10">#get_lk_division.divisionname#</span></td>
					<td><span class="pix10">#get_lk_division.leaguecode#</span></td>
				</tr>	
			</cfif>      
		<cfelseif Q_lk_division.RecordCount IS 1>
			<!--- Yes, so update the row in zmast.lk_division --->
			<cfquery name="upd_lk_division" datasource="zmast">
					UPDATE
						lk_division 
					SET 
						#PreviousYearid#=NULL,
						#ThisYearid#=#BUnmatched.thisdid#,
						divisionname='#BUnmatched.divisionname#',
						leaguecode='#BUnmatched.leaguecode#'
					WHERE
						id = #Q_lk_division.id#
			</cfquery>
			<!--- Get the row we just updated in zmast.lk_division --->
			<cfquery name="get_lk_division" datasource="zmast">
					SELECT
						id,
						#PreviousYearid# as PrevID,
						#ThisYearid# as ThisID,
						divisionname,
						leaguecode
					FROM
						lk_division 
					WHERE 
						#PreviousYearid# IS NULL
						AND #ThisYearid# = #BUnmatched.thisdid#
						AND divisionname = '#BUnmatched.divisionname#'
						AND leaguecode = '#BUnmatched.leaguecode#'
			</cfquery>
			<cfif get_lk_division.RecordCount IS NOT 1>BUnmatched: upd_lk_division error<cfabort></cfif>
			<cfif OnlyThisLeague IS "Yes">
				<tr>
					<td><span class="pix10">UPDATED UNMATCHED-B</span></td>
					<td><span class="pix10">#get_lk_division.id#</span></td>
					<td><span class="pix10">#get_lk_division.PrevID#</span></td>
					<td><span class="pix10">#get_lk_division.ThisID#</span></td>
					<td><span class="pix10">#get_lk_division.divisionname#</span></td>
					<td><span class="pix10">#get_lk_division.leaguecode#</span></td>
				</tr>	
			</cfif>     
		<cfelse>
			UNMATCHED-B: ERROR Q_lk_division.RecordCount is #Q_lk_division.RecordCount#<cfabort>
		</cfif>
	</cfoutput>
</table>
