REDUNDANT CODE


<cfabort>


<!--- we do this fresh every time and compare the results with what exists in zmast.lk_ordinal table --->
<!--- this query identifies matching ordinals across two years, Previous and This, matching is done on leaguecode and longcol (the ordinal description) --->
<cfquery name="ABMatch" datasource="zmast">
	SELECT
		o1.id as previousoid, 
		o2.id as thisoid, 
		CASE
			WHEN o1.longcol IS NULL
			THEN '*First Team*'
			ELSE o1.longcol
			END
			as ordinalname, 
		o1.leaguecode 
	FROM
		fm#PreviousYear#.ordinal o1,
		fm#ThisYear#.ordinal o2
	WHERE 
		<cfif OnlyThisLeague IS "Yes">o1.leaguecode = '#LeagueCodePrefix#' AND</cfif>
		o1.leaguecode = o2.leaguecode
		AND
		CASE
			WHEN (o1.longcol IS NULL AND o2.longcol IS NULL)
			THEN 1=1
			WHEN (o1.longcol = o2.longcol)
			THEN 1=1
			
			ELSE 1=0
			END
	ORDER BY
		o1.leaguecode, o1.longcol
</cfquery>

<cfset ABOrdinalMatchList1 = ValueList(ABMatch.previousoid) >
<cfset ABOrdinalMatchList2 = ValueList(ABMatch.thisoid) >

<table>
	<tr bgcolor="silver">
		<td><span class="pix13bold">Processing Ordinals</span></td>
	</tr>
	<cfflush>
	<cfoutput>
	<cfif OnlyThisLeague IS "Yes">
		<tr bgcolor="silver">
			<td><span class="pix10bold">Message</span></td>
			<td><span class="pix10bold">id</span></td>
			<td><span class="pix10bold">#PreviousYearid#</span></td>
			<td><span class="pix10bold">#ThisYearid#</span></td>
			<td><span class="pix10bold">ordinalname</span></td>
			<td><span class="pix10bold">leaguecode</span></td>
		</tr>
	</cfif>	
	</cfoutput>
	<cfoutput query="ABMatch">
		<!--- check to see if there is a corresponding row in zmast.lk_ordinal --->
		<cfquery name="Q_lk_ordinal" datasource="zmast">
			SELECT
				id 
			FROM
				lk_ordinal
			WHERE
				#PreviousYearid# = #ABMatch.previousoid#
		</cfquery>
		<cfif Q_lk_ordinal.RecordCount IS 0>
			<!--- No, so insert a row in zmast.lk_ordinal --->
			<cfquery name="ins_lk_ordinal" datasource="zmast">
					INSERT INTO lk_ordinal 
					(#PreviousYearid#,  #ThisYearid#, ordinalname, leaguecode)
					VALUES
					(#ABMatch.previousoid#, #ABMatch.thisoid#,  '#ABMatch.ordinalname#', '#ABMatch.leaguecode#')
			</cfquery>
			<!--- Get the row we just inserted in zmast.lk_ordinal --->
			<cfquery name="get_lk_ordinal" datasource="zmast">
					SELECT
						id,
						#PreviousYearid# as PrevID,
						#ThisYearid# as ThisID,
						ordinalname,
						leaguecode
					FROM
						lk_ordinal 
					WHERE 
						#PreviousYearid# = #ABMatch.previousoid#
			</cfquery>
			<cfif get_lk_ordinal.RecordCount IS NOT 1>ABMatch: ins_lk_ordinal error<cfabort></cfif>
			<cfif OnlyThisLeague IS "Yes">
				<tr>
					<td><span class="pix10">INSERTED MATCHING</span></td>
					<td><span class="pix10">#get_lk_ordinal.id#</span></td>
					<td><span class="pix10">#get_lk_ordinal.PrevID#</span></td>
					<td><span class="pix10">#get_lk_ordinal.ThisID#</span></td>
					<td><span class="pix10">#get_lk_ordinal.ordinalname#</span></td>
					<td><span class="pix10">#get_lk_ordinal.leaguecode#</span></td>
				</tr>	
			</cfif>        
		<cfelseif Q_lk_ordinal.RecordCount IS 1>
			<!--- Yes, so update the row in zmast.lk_ordinal --->
			<cfquery name="upd_lk_ordinal" datasource="zmast">
					UPDATE
						lk_ordinal 
					SET 
						#PreviousYearid#=#ABMatch.previousoid#,
						#ThisYearid#=#ABMatch.thisoid#,
						ordinalname='#ABMatch.ordinalname#',
						leaguecode='#ABMatch.leaguecode#'
					WHERE
						id = #Q_lk_ordinal.id#
			</cfquery>
			<!--- Get the row we just updated in zmast.lk_ordinal --->
			<cfquery name="get_lk_ordinal" datasource="zmast">
					SELECT
						id,
						#PreviousYearid# as PrevID,
						#ThisYearid# as ThisID,
						ordinalname,
						leaguecode
					FROM
						lk_ordinal 
					WHERE 
						#PreviousYearid# = #ABMatch.previousoid#
			</cfquery>
			<cfif get_lk_ordinal.RecordCount IS NOT 1>ABMatch: upd_lk_ordinal error<cfabort></cfif>
			<cfif OnlyThisLeague IS "Yes">
				<tr>
					<td><span class="pix10">UPDATED MATCHING</span></td>
					<td><span class="pix10">#get_lk_ordinal.id#</span></td>
					<td><span class="pix10">#get_lk_ordinal.PrevID#</span></td>
					<td><span class="pix10">#get_lk_ordinal.ThisID#</span></td>
					<td><span class="pix10">#get_lk_ordinal.ordinalname#</span></td>
					<td><span class="pix10">#get_lk_ordinal.leaguecode#</span></td>
				</tr>	
			</cfif>        
		<cfelse>
			MATCHING: ERROR Q_lk_ordinal.RecordCount is #Q_lk_ordinal.RecordCount#<cfabort>
		</cfif>
	</cfoutput>
</table>

<!--- we do this fresh every time and compare the results with what exists in zmast.lk_ordinal table --->
<!--- this query identifies UNMATCHED Previous Year's ordinals across two years, Previous and This, matching is done on leaguecode and longcol (the ordinal description) --->
<cfquery name="AUnmatched" datasource="zmast">
	SELECT
		id as previousoid, 
		CASE
			WHEN longcol IS NULL
			THEN '*First Team*'
			ELSE longcol
			END
			as ordinalname, 
		leaguecode 
	FROM
		fm#PreviousYear#.ordinal
	WHERE 
		<cfif OnlyThisLeague IS "Yes">leaguecode = '#LeagueCodePrefix#' AND</cfif>
		id NOT IN (#ABOrdinalMatchList1#)
	ORDER BY
		leaguecode, longcol
</cfquery>

<cfset AOrdinalUnmatchedList = ValueList(AUnmatched.previousoid) >

<table>
	<cfoutput>
	<cfif OnlyThisLeague IS "Yes">
		<tr bgcolor="silver">
			<td><span class="pix10bold">Message</span></td>
			<td><span class="pix10bold">id</span></td>
			<td><span class="pix10bold">#PreviousYearid#</span></td>
			<td><span class="pix10bold">#ThisYearid#</span></td>
			<td><span class="pix10bold">ordinalname</span></td>
			<td><span class="pix10bold">leaguecode</span></td>
		</tr>
	</cfif>	
	</cfoutput>
	<cfoutput query="AUnmatched">
		<!--- check to see if there is a corresponding row in zmast.lk_ordinal --->
		<cfquery name="Q_lk_ordinal" datasource="zmast">
			SELECT
				id 
			FROM
				lk_ordinal
			WHERE
				#PreviousYearid# = #AUnmatched.previousoid#
				
		</cfquery>
		<cfif Q_lk_ordinal.RecordCount IS 0>
			<!--- No, so insert a row in zmast.lk_ordinal --->
			<cfquery name="ins_lk_ordinal" datasource="zmast">
					INSERT INTO lk_ordinal 
					(#PreviousYearid#,  #ThisYearid#, ordinalname, leaguecode)
					VALUES
					(#AUnmatched.previousoid#, NULL, '#AUnmatched.ordinalname#', '#AUnmatched.leaguecode#')
			</cfquery>
			<!--- Get the row we just inserted in zmast.lk_ordinal --->
			<cfquery name="get_lk_ordinal" datasource="zmast">
					SELECT
						id,
						#PreviousYearid# as PrevID,
						#ThisYearid# as ThisID,
						ordinalname,
						leaguecode
					FROM
						lk_ordinal 
					WHERE 
						#PreviousYearid# = #AUnmatched.previousoid#
						AND #ThisYearid# IS NULL
						AND ordinalname = '#AUnmatched.ordinalname#'
						AND leaguecode = '#AUnmatched.leaguecode#'
			</cfquery>
			<cfif get_lk_ordinal.RecordCount IS NOT 1>AUnmatched: ins_lk_ordinal error<cfabort></cfif>
			<cfif OnlyThisLeague IS "Yes">
				<tr>
					<td><span class="pix10">INSERTED UNMATCHED-A</span></td>
					<td><span class="pix10">#get_lk_ordinal.id#</span></td>
					<td><span class="pix10">#get_lk_ordinal.PrevID#</span></td>
					<td><span class="pix10">#get_lk_ordinal.ThisID#</span></td>
					<td><span class="pix10">#get_lk_ordinal.ordinalname#</span></td>
					<td><span class="pix10">#get_lk_ordinal.leaguecode#</span></td>
				</tr>	
			</cfif>        
		<cfelseif Q_lk_ordinal.RecordCount IS 1>
			<!--- Yes, so update the row in zmast.lk_ordinal --->
			<cfquery name="upd_lk_ordinal" datasource="zmast">
					UPDATE
						lk_ordinal 
					SET 
						#PreviousYearid#=#AUnmatched.previousoid#,
						#ThisYearid#=NULL,
						ordinalname='#AUnmatched.ordinalname#',
						leaguecode='#AUnmatched.leaguecode#'
					WHERE
						id = #Q_lk_ordinal.id#
			</cfquery>
			<!--- Get the row we just updated in zmast.lk_ordinal --->
			<cfquery name="get_lk_ordinal" datasource="zmast">
					SELECT
						id,
						#PreviousYearid# as PrevID,
						#ThisYearid# as ThisID,
						ordinalname,
						leaguecode
					FROM
						lk_ordinal 
					WHERE 
						#PreviousYearid# = #AUnmatched.previousoid#
						AND #ThisYearid# IS NULL
						AND ordinalname = '#AUnmatched.ordinalname#'
						AND leaguecode = '#AUnmatched.leaguecode#'
			</cfquery>
			<cfif get_lk_ordinal.RecordCount IS NOT 1>AUnmatched: upd_lk_ordinal error<cfabort></cfif>
			<cfif OnlyThisLeague IS "Yes">
				<tr>
					<td><span class="pix10">UPDATED UNMATCHED-A</span></td>
					<td><span class="pix10">#get_lk_ordinal.id#</span></td>
					<td><span class="pix10">#get_lk_ordinal.PrevID#</span></td>
					<td><span class="pix10">#get_lk_ordinal.ThisID#</span></td>
					<td><span class="pix10">#get_lk_ordinal.ordinalname#</span></td>
					<td><span class="pix10">#get_lk_ordinal.leaguecode#</span></td>
				</tr>	
			</cfif>        
		<cfelse>
			UNMATCHED-A: ERROR Q_lk_ordinal.RecordCount is #Q_lk_ordinal.RecordCount#<cfabort>
		</cfif>
	</cfoutput>
</table>






<!--- we do this fresh every time and compare the results with what exists in zmast.lk_ordinal table --->
<!--- this query identifies UNMATCHED This Year's ordinals across two years, Previous and This, matching is done on leaguecode and longcol (the ordinal description) --->
<cfquery name="BUnmatched" datasource="zmast">
	SELECT
		id as thisoid, 
		CASE
			WHEN longcol IS NULL
			THEN '*First Team*'
			ELSE longcol
			END
			as ordinalname, 
		leaguecode 
	FROM
		fm#ThisYear#.ordinal
	WHERE 
		<cfif OnlyThisLeague IS "Yes">leaguecode = '#LeagueCodePrefix#' AND</cfif>
		id NOT IN (#ABOrdinalMatchList2#)
	ORDER BY
		leaguecode, longcol
</cfquery>

<cfset BOrdinalUnmatchedList = ValueList(BUnmatched.thisoid) >

<table>
	<cfoutput>
	<cfif OnlyThisLeague IS "Yes">
		<tr bgcolor="silver">
			<td><span class="pix10bold">Message</span></td>
			<td><span class="pix10bold">id</span></td>
			<td><span class="pix10bold">#PreviousYearid#</span></td>
			<td><span class="pix10bold">#ThisYearid#</span></td>
			<td><span class="pix10bold">ordinalname</span></td>
			<td><span class="pix10bold">leaguecode</span></td>
		</tr>
	</cfif>	
	</cfoutput>
	<cfoutput query="BUnmatched">
		<!--- check to see if there is a corresponding row in zmast.lk_ordinal --->
		<cfquery name="Q_lk_ordinal" datasource="zmast">
			SELECT
				id 
			FROM
				lk_ordinal
			WHERE
				#ThisYearid# = #BUnmatched.Thisoid#
		</cfquery>
		<cfif Q_lk_ordinal.RecordCount IS 0>
			<!--- No, so insert a row in zmast.lk_ordinal --->
			<cfquery name="ins_lk_ordinal" datasource="zmast">
					INSERT INTO lk_ordinal 
					(#PreviousYearid#,  #ThisYearid#, ordinalname, leaguecode)
					VALUES
					(NULL, #BUnmatched.thisoid#, '#BUnmatched.ordinalname#', '#BUnmatched.leaguecode#')
			</cfquery>
			<!--- Get the row we just inserted in zmast.lk_ordinal --->
			<cfquery name="get_lk_ordinal" datasource="zmast">
					SELECT
						id,
						#PreviousYearid# as PrevID,
						#ThisYearid# as ThisID,
						ordinalname,
						leaguecode
					FROM
						lk_ordinal 
					WHERE 
						#PreviousYearid# IS NULL
						AND #ThisYearid# = #BUnmatched.thisoid#
						AND ordinalname = '#BUnmatched.ordinalname#'
						AND leaguecode = '#BUnmatched.leaguecode#'
			</cfquery>
			<cfif get_lk_ordinal.RecordCount IS NOT 1>BUnmatched: ins_lk_ordinal error<cfabort></cfif>
			<cfif OnlyThisLeague IS "Yes">
				<tr>
					<td><span class="pix10">INSERTED UNMATCHED-B</span></td>
					<td><span class="pix10">#get_lk_ordinal.id#</span></td>
					<td><span class="pix10">#get_lk_ordinal.PrevID#</span></td>
					<td><span class="pix10">#get_lk_ordinal.ThisID#</span></td>
					<td><span class="pix10">#get_lk_ordinal.ordinalname#</span></td>
					<td><span class="pix10">#get_lk_ordinal.leaguecode#</span></td>
				</tr>	
			</cfif>        
		<cfelseif Q_lk_ordinal.RecordCount IS 1>
			<!--- Yes, so update the row in zmast.lk_ordinal --->
			<cfquery name="upd_lk_ordinal" datasource="zmast">
					UPDATE
						lk_ordinal 
					SET 
						#PreviousYearid#=NULL,
						#ThisYearid#=#BUnmatched.thisoid#,
						ordinalname='#BUnmatched.ordinalname#',
						leaguecode='#BUnmatched.leaguecode#'
					WHERE
						id = #Q_lk_ordinal.id#
			</cfquery>
			<!--- Get the row we just updated in zmast.lk_ordinal --->
			<cfquery name="get_lk_ordinal" datasource="zmast">
					SELECT
						id,
						#PreviousYearid# as PrevID,
						#ThisYearid# as ThisID,
						ordinalname,
						leaguecode
					FROM
						lk_ordinal 
					WHERE 
						#PreviousYearid# IS NULL
						AND #ThisYearid# = #BUnmatched.thisoid#
						AND ordinalname = '#BUnmatched.ordinalname#'
						AND leaguecode = '#BUnmatched.leaguecode#'
			</cfquery>
			<cfif get_lk_ordinal.RecordCount IS NOT 1>BUnmatched: upd_lk_ordinal error<cfabort></cfif>
			<cfif OnlyThisLeague IS "Yes">
				<tr>
					<td><span class="pix10">UPDATED UNMATCHED-B</span></td>
					<td><span class="pix10">#get_lk_ordinal.id#</span></td>
					<td><span class="pix10">#get_lk_ordinal.PrevID#</span></td>
					<td><span class="pix10">#get_lk_ordinal.ThisID#</span></td>
					<td><span class="pix10">#get_lk_ordinal.ordinalname#</span></td>
					<td><span class="pix10">#get_lk_ordinal.leaguecode#</span></td>
				</tr>	
			</cfif>        
		<cfelse>
			UNMATCHED-B: ERROR Q_lk_ordinal.RecordCount is #Q_lk_ordinal.RecordCount#<cfabort>
		</cfif>
	</cfoutput>
</table>
