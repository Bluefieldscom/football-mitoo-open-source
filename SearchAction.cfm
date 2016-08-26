<cfinclude template="InclBegin.cfm">
<cfset OldAdverts = 0 >
<cfif StructKeyExists(form,"SubmitButton")>
	<cfif form.SubmitButton IS "Search Old">
		<cfoutput><span class="pix18boldred">Searching Old Adverts</span><br><br></cfoutput>
		<cfset OldAdverts = 1 >
	</cfif>
</cfif>
<cfinclude template = "queries/qry_SearchTblName.cfm">


<!---display heading to users--->
<cfoutput><hr><span class="pix13boldblack" >#Form.TblName# Search Results</span><hr></cfoutput>

<!--- check to determine if any records have been returned based on the users search criteria --->
<cfif SearchTblName.RecordCount IS "0">
	<cfoutput>
	<span class="pix10bold">
	<BR><BR>No records match your search criteria.<br>
	</span>
	</cfoutput>
<cfelseif SearchTblName.RecordCount IS 1 >
	<cflocation url="UpdateForm.cfm?TblName=#Form.TblName#&ID=#SearchTblName.ID#&LeagueCode=#Form.LeagueCode#" addtoken="no">
<cfelse>
	<table width="100%" cellspacing="0" cellpadding="0">
		<cfoutput query="SearchTblName">
			<cfif Form.TblName IS "Player">
				<tr>
					<td align="left" width="15%"><a href="UpdateForm.cfm?TblName=#Form.TblName#&ID=#SearchTblName.ID#&LeagueCode=#Form.LeagueCode#"><span class="pix13bold">#Surname#</span></a></td>
					<td align="left" width="15%"><span class="pix13">#Forename#</span></td>
					<td align="center" width="10%"><span class="pix13">#DateFormat(mediumcol, 'DD MMM YYYY')#</span></td>
					<td align="right" width="10%"><span class="pix13">#shortcol#</span></td>
					<cfif TeamName IS NOT ''>
						<td align="left" width="50%"><span class="pix13">&nbsp;&nbsp;#TeamName# [Reg #DateFormat(FirstDay,'dd mmm yy')#]</span></td>
					<cfelse>
						<td align="left" width="50%"><span class="pix13">&nbsp;</span></td>
					</cfif>
				</tr>
			<cfelseif Form.TblName IS "Team">
				<tr>
					<td align="left" >
						<a href="UpdateForm.cfm?TblName=#Form.TblName#&ID=#SearchTblName.ID#&LeagueCode=#Form.LeagueCode#">
						<span class="pix13bold">#LongCol#<cfif shortcol IS "Guest">  &nbsp;&nbsp;<em><-- This is a GUEST team</em> </cfif></span>
					</td>
				</tr>
			<cfelseif Form.TblName IS "Noticeboard">
				<tr>
					<td align="left">
					<cfif OldAdverts IS 0>
						<a href="UpdateForm.cfm?TblName=#Form.TblName#&ID=#SearchTblName.ID#&LeagueCode=#Form.LeagueCode#">
							<span class="pix13bold">#AdvertTitle#</span>
						</a>
					<cfelse>
						<a href="UpdateForm.cfm?TblName=#Form.TblName#&ID=#SearchTblName.ID#&LeagueCode=#Form.LeagueCode#&OldAdverts=Y">
							<span class="pix13bold">#AdvertTitle#</span>
						</a>
					</cfif>
					</td>
				</tr>
			<cfelse>
				<tr>
					<td align="left">
						<a href="UpdateForm.cfm?TblName=#Form.TblName#&ID=#SearchTblName.ID#&LeagueCode=#Form.LeagueCode#">
							<span class="pix13bold">#LongCol#</span>
						</a>
					</td>
				</tr>
			</cfif>
		</cfoutput>
	</table>
</cfif>
