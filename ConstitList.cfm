<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfinclude template="InclBegin.cfm">
<cfinclude template="queries/qry_GetBlankMatchNo.cfm">
<cfset NeverDefeatedList = '' >
<cfif Left(QKnockOut.Notes,2) IS "KO" >
	<cfset KO = "Yes">
	<cfset ThisDivisionID = DivisionID >
	<cfinclude template="queries/qry_QNewLeagueTable.cfm">
	<cfif QNewLeagueTable.RecordCount IS 0 >
		<cfinclude template="RefreshLeagueTable.cfm">
		<cfinclude template="queries/qry_QNewLeagueTable.cfm">
	</cfif>
	<cfinclude template="queries/qry_QNeverDefeated.cfm">
	<cfset NeverDefeatedList = ValueList(QNeverDefeated.ConstitutionID)>
	<cfif QNeverDefeated.RecordCount IS 0 >
		<cfset NeverDefeatedList = ListAppend(NeverDefeatedList,0)>
	</cfif>
</cfif>
<cfinclude template="queries/qry_QConstit.cfm">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="loggedinScreen">
		<tr>
			<td align="CENTER">
				<cfoutput>
					<a href="UpdateForm.cfm?TblName=#TblName#&DivisionID=#DivisionID#&TeamID=#TeamID#&OrdinalID=#OrdinalID#&ThisMatchNoID=#ThisMatchNoID#&NextMatchNoID=#NextMatchNoID#&LeagueCode=#LeagueCode#"><span class="pix18bold">Add</span></a>
				</cfoutput>
			</td>
		</tr>
		<cfif KO IS "Yes" AND Find( "MatchNumbers", QKnockOut.Notes ) >
			<tr>
				<td height="50" align="center" bgcolor="white">
					<span class="pix13boldred">If a team has not been knocked out but its name is "greyed out" and you <br> want it displayed normally click on any other team name and then on the Update button.</span>
				</td>
			</tr>
		</cfif>
	</table>		
<cfif QConstit.RecordCount IS "0">
	<span class="pix13bold">No teams have been entered for this Division or Cup Competition</span>
<cfelse>
	<table width="100%" border="1" cellspacing="0" cellpadding="3" class="loggedinScreen">
		<tr class="bg_white">
			<td align="left" colspan="3">
			<cfoutput>
				<span class="pix13bold">#QConstit.RecordCount# in list</span>
			</cfoutput>
			</td>
		</tr>
		<cfif KO IS "Yes" AND Find( "IgnoreLosers", QKnockOut.Notes )>
			<tr class="bg_white">
				<td align="left" colspan="3">
				<cfoutput>
					<span class="pix10bold">IgnoreLosers has been specified to handle First Leg and Second Leg matches per cup round</span>
				</cfoutput>
				</td>
			</tr>
		</cfif>
		<cfif Find( "MatchNumbers", QKnockOut.Notes )>
			<tr>
			<cfoutput>
				<td align="center" class="bg_white"><a href="ConstitList.cfm?S=1&TblName=Constitution&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#"><span class="pix10bold">Sort</span></a></td>
				<td align="center" class="bg_white"><a href="ConstitList.cfm?S=2&TblName=Constitution&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#"><span class="pix10bold">Sort</span></a></td>
				<td align="center" class="bg_white"><a href="ConstitList.cfm?S=3&TblName=Constitution&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#"><span class="pix10bold">Sort</span></a></td>
			</cfoutput>
			</tr>
		</cfif>
		<cfoutput query="QConstit">
			<cfset TeamNameText = "#team# #ordinal#">
			<tr align="left">	
				<cfif KO IS "Yes" AND NOT Find( "IgnoreLosers", QKnockOut.Notes )>
					<cfif ListFind(NeverDefeatedList,CID)>
						<td align="left" width="34%" <cfif MatchBanFlag IS 1>bgcolor="yellow"</cfif> >
							<a href="UpdateForm.cfm?TblName=Constitution&id=#CID#&DivisionID=#CDID#&TeamID=#CTID#&OrdinalID=#COID#&ThisMatchNoID=#TMNID#&NextMatchNoID=#NMNID#&LeagueCode=#LeagueCode#<cfif StructKeyExists(url, "S") >&S=#URL.S#</cfif>">
							<cfif UCase(Guest) IS "GUEST"><span class="pix13bold"><em>#TeamNameText#</em></span><cfelse><span class="pix13bold">#TeamNameText#</span></cfif></a>   
							<cfif PointsAdjustment IS NOT 0><span class="pix10bold">[#NumberFormat(PointsAdjustment, '+99')# points]</span></cfif>
						</td>
					<cfelse> <!--- knocked out --->
						<td align="left" width="34%" <cfif MatchBanFlag IS 1>bgcolor="yellow"</cfif> >
							<cfif ListFind("Silver",request.SecurityLevel) >
								<a href="UpdateForm.cfm?TblName=Constitution&id=#CID#&DivisionID=#CDID#&TeamID=#CTID#&OrdinalID=#COID#&ThisMatchNoID=#TMNID#&NextMatchNoID=#NMNID#&LeagueCode=#LeagueCode#<cfif StructKeyExists(url, "S") >&S=#URL.S#</cfif>">
								<cfif UCase(Guest) IS "GUEST"><span class="pix13boldsilver"><em>#TeamNameText#</em></span><cfelse><span class="pix13boldsilver">#TeamNameText#</span></cfif></a>   
								<cfif PointsAdjustment IS NOT 0><span class="pix10bold">[#NumberFormat(PointsAdjustment, '+99')# points]</span></cfif>
							<cfelse>
								<cfif UCase(Guest) IS "GUEST"><span class="pix13boldsilver"><em>#TeamNameText#</em></span><cfelse><span class="pix13boldsilver">#TeamNameText#</span></cfif></a>
								<cfif PointsAdjustment IS NOT 0><span class="pix10bold">[#NumberFormat(PointsAdjustment, '+99')# points]</span></cfif>
							</cfif>
						</td>
					</cfif>
				<cfelse>
					<td align="left" width="34%" <cfif MatchBanFlag IS 1>bgcolor="yellow"</cfif> >
						<a href="UpdateForm.cfm?TblName=Constitution&id=#CID#&DivisionID=#CDID#&TeamID=#CTID#&OrdinalID=#COID#&ThisMatchNoID=#TMNID#&NextMatchNoID=#NMNID#&LeagueCode=#LeagueCode#<cfif StructKeyExists(url, "S") >&S=#URL.S#</cfif>">
						<cfif UCase(Guest) IS "GUEST"><span class="pix13bold"><em>#TeamNameText#</em></span><cfelse><span class="pix13bold">#TeamNameText#</span></cfif></a>  
						<cfif PointsAdjustment IS NOT 0><span class="pix10bold">[#NumberFormat(PointsAdjustment, '+99')# points]</span></cfif>
					</td>
				</cfif>
				
				<!--- extra two columns for ThisMatchNumber and NextMatchNumber --->
				
				<cfif KO IS "Yes" AND Find( "MatchNumbers", QKnockOut.Notes ) >
					<cfif ListFind(NeverDefeatedList,CID) >
						<cfinclude template="queries/qry_QFixture001.cfm">
						<cfif TRIM(ThisMatchNumber) IS NOT "">
							<td align="left" width="33%"><span class="pix13">plays in Match No. #ThisMatchNumber#<cfif QFixture001.RecordCount IS 0> </span><span class="pix13boldred">[No fixture date]</cfif></span></td>
						<cfelse>
							<td align="left" width="33%"><span class="pix13boldred">Please remove this team or specify the Match No.</span></td>
						</cfif>
						<cfif TRIM(NextMatchNumber) IS NOT "">
							<td align="left" width="33%"><span class="pix13">Next Match No. is #NextMatchNumber#</span></td>
						<cfelse>
							<td align="left" width="33%"><span class="pix13boldred">&nbsp;</span></td>
						</cfif>
						
						
					<cfelseif Find( "IgnoreLosers", QKnockOut.Notes)>
						<cfinclude template="queries/qry_QFixture001.cfm">
						<cfif TRIM(ThisMatchNumber) IS NOT "">
							<td align="left" width="33%"><span class="pix13">plays in Match No. #ThisMatchNumber#<cfif QFixture001.RecordCount IS 0> </span><span class="pix13boldred">[No fixture date]</cfif></span></td>
						<cfelse>
							<td align="left" width="33%"><span class="pix13boldred">&nbsp;</span></td>
						</cfif>
						<cfif TRIM(NextMatchNumber) IS NOT "">
							<td align="left" width="33%"><span class="pix13">Next Match No. is #NextMatchNumber#</span></td>
						<cfelse>
							<td align="left" width="33%"><span class="pix13boldred">&nbsp;</span></td>
						</cfif>
						
					<cfelse> <!--- knocked out so update the constitution so that ThisMatchNoID and NextMatchNoID will display a blank --->
						<cfinclude template="queries/upd_ConstitBlank.cfm">
						<td align="left" width="33%"><span class="pix13silver">&nbsp;</span></td>
						<td align="left" width="33%"><span class="pix13silver">&nbsp;</span></td>
					</cfif>
				</cfif>
			</tr>
		</cfoutput>			
	</table>
</cfif>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="loggedinScreen">
		<tr>
			<td align="left">
				<table>
					<tr>
						<td align="left"><span class="pix13bold">If a team name is shown</span></td>
						<td align="left" bgcolor="yellow"><span class="pix13bold"> in yellow </span></td>
						<td align="left"><span class="pix13bold">then their <cfoutput>#ThisCompetitionDescription#</cfoutput> games do not count towards match based suspensions</span></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>		

