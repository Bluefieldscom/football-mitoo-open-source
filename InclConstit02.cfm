<cfinclude template="queries/qry_GetTeamInfo.cfm">
<cfinclude template="queries/qry_GetOrdinalInfo.cfm">

<cfif LEFT(QKnockOut.Notes,2) IS "KO" AND Find( "MatchNumbers", QKnockOut.Notes )>
	<cfset request.ShowMatchNumbers = "Yes">
	<cfinclude template="queries/qry_GetMatchNo.cfm">
<cfelse>
	<cfset request.ShowMatchNumbers = "No">
	<cfinclude template="queries/qry_GetBlankMatchNo.cfm">
</cfif>

<cfset request.ShowPointsAdjustment = "No">
<cfif ListFind("Silver",request.SecurityLevel) >
	<cfif LEFT(QKnockOut.Notes,2) IS "KO" OR NewRecord IS "Yes">
	<cfelse>
		<cfinclude template="queries/qry_GetPointsAdjustment.cfm">
		<cfset request.ShowPointsAdjustment = "Yes">
	</cfif>
</cfif>

<cfset request.ShowMatchBanRelevance = "No">
<cfif ListFind("Silver,Skyblue",request.SecurityLevel) AND StructKeyExists(url,"ID") >
	<cfinclude template="queries/qry_GetMatchBanRelevance.cfm">
	<cfset request.ShowMatchBanRelevance = "Yes">
</cfif>


<table width="100%" border="0" cellspacing="0" cellpadding="5" align="CENTER">
	<tr>
		<td colspan="4" align="CENTER">
			<cfoutput><a href="ConstitList.cfm?TblName=Constitution&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#"><span class="pix18bold">List</span></a></cfoutput>
		</td>
	</tr>
	<tr>
		<td colspan="4">
			<table border="1" align="center" cellpadding="3" cellspacing="0">
				<tr>
					<cfif request.ShowMatchBanRelevance IS "YES" >
						<td width="120" align="center"><span class="pix9">Do their <cfoutput>#ThisCompetitionDescription#</cfoutput> games count towards match based suspensions?</span></td>
					</cfif>
				
					<cfif request.ShowPointsAdjustment IS "YES" >
						<td align="center" bgcolor="silver"><span class="pix10">JAB<br />Points<br />Adjust</span></td>
					</cfif>
					<td align="center"><span class="pix10">Team Name</span></td>
					<td align="center"><span class="pix10">Ordinal</span></td>
					<cfif request.ShowMatchNumbers IS "Yes">
						<td align="left">
							<span class="pix10">
								they have been<BR>drawn to play in<BR>match number ...
							</span>
						</td>
						<td align="left">
							<span class="pix10">
								if they win they<BR>will progress to<BR>match number ...
							</span>
						</td>
					</cfif>
				</tr>
				<tr>
						<cfif request.ShowMatchBanRelevance IS "YES" >
							<cfif GetMatchBanRelevance.MatchBanFlag IS 0>
								<td align="center">
									<span class="pix10">Yes</span><input name="MatchBanFlag" type="radio" value="0" checked >
									<span class="pix10">No</span><input name="MatchBanFlag" type="radio" value="1" >
								</td>
							<cfelse>
								<td align="center" bgcolor="yellow">
									<span class="pix10">Yes</span> <input name="MatchBanFlag" type="radio" value="0" >
									<span class="pix10">No</span> <input name="MatchBanFlag" type="radio" value="1" checked>
								</td>
							</cfif>
						</cfif>
					
					<cfif request.ShowPointsAdjustment IS "YES" >
						<td align="center" bgcolor="silver"><input name="PointsAdjustment" type="text" value=<cfoutput>"#NumberFormat(GetPointsAdjustment.PointsAdjustment, '+9')#"</cfoutput> size="1" maxlength="4"></td>
					</cfif>
					<td>
						<SELECT NAME="TeamID" size="1">
							<cfoutput query="GetTeamInfo" >
								<OPTION VALUE="#ID#" <cfif GetTeamInfo.ID IS #TeamID#>selected</cfif> >#LongCol#</OPTION>
							</cfoutput>
						</select>
					</td>
					<td>	
						<SELECT NAME="OrdinalID" size="1">
							<cfoutput query="GetOrdinalInfo">
								<OPTION VALUE="#ID#" <cfif GetOrdinalInfo.ID IS #OrdinalID#>selected</cfif> >#LongCol#</OPTION>
							</cfoutput>
						</select>
					</td>
					<cfif request.ShowMatchNumbers IS "Yes">
						<td align="CENTER">
							<SELECT NAME="ThisMatchNoID" size="1">
								<cfoutput query="GetMatchNo">
									<OPTION VALUE="#ID#" <cfif GetMatchNo.ID IS #ThisMatchNoID#>selected</cfif> >#LongCol#</OPTION>
								</cfoutput>
							</select>
						</td>
						<td align="CENTER">
							<SELECT NAME="NextMatchNoID" size="1">
								<cfoutput query="GetMatchNo" >
									<OPTION VALUE="#ID#" <cfif GetMatchNo.ID IS #NextMatchNoID#>selected</cfif> >#LongCol#</OPTION>
								</cfoutput>
							</select>
						</td>
					<cfelse>	
						<input type="Hidden" name="ThisMatchNoID" value=<cfoutput>"#GetBlankMatchNo.ID#"</cfoutput>>
						<input type="Hidden" name="NextMatchNoID" value=<cfoutput>"#GetBlankMatchNo.ID#"</cfoutput>>
					</cfif>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="4" align="CENTER">
			<table>
				<tr>
					
          <td height="60"> <span class="pix10red"> <strong>IMPORTANT</strong> 
            - If this is a Youth League with age groups (e.g. U11, U12, U13 etc) 
            and you are using player registrations, <b>you must add each team 
            separately and not use Ordinals.</b> <br />
            Otherwise, please use an Ordinal to distinguish between different 
            teams from the same Club.</span> </td>
				</tr>
				<tr>
					<td>
						<span class="pix10">
							Match numbers will become available only when the word &quot;MatchNumbers&quot; is present after &quot;KO&quot; in Division Notes section
						</span>
					</td>
				</tr>
				<tr>
					<td>
						<span class="pix10">
							The additional word &quot;NoReplays&quot; in Division Notes section will suppress cup replays in Unscheduled Matches
						</span>
					</td>
				</tr>
				<tr>
					<td>
						<span class="pix10">
							Put the Competition Code in Ordinal to distinguish between different &quot;Winners of match nn&quot;
						</span>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
