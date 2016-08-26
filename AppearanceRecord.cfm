<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfif ListFind("Yellow",request.SecurityLevel) >
	<cfif request.YellowKey IS NOT "#request.CurrentLeagueCode##url.TeamID#" >
		<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
		<cfabort>
	</cfif>
</cfif>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfif StructKeyExists(url, "TeamID")>
	<cfinclude template="queries/qry_QAppearanceRecord.cfm">
	<cfif QAppearanceRecord.RecordCount GT 0 >
		<cfoutput>
			<table border="1" cellspacing="0" cellpadding="3" align="CENTER">
				<tr>
					<td align="center" bgcolor="#BG_originalcolor#">
						<span class="pix10"> Started </span>
					</td>
					<td align="center" bgcolor="silver">
						<span class="pix10"> Sub Used </span>
					</td>
					<td align="center" bgcolor="white">
						<span class="pix10"> Sub Not Used </span>
					</td>
			</table>
		</cfoutput>		
		<br>
		<table border="1" cellspacing="0" cellpadding="3" align="CENTER">
			<cfoutput query="QAppearanceRecord" group="Ord">
				<tr>
					<td colspan="#QAppearanceRecordMax.MaxSno+2#" align="left" bgcolor="silver">
						<span class="pix13bold">#Ord#</span>
					</td>
				</tr>
				<tr>
					<td></td>
					<td></td>
						<cfloop index="s" from="1" to="#QAppearanceRecordMax.MaxSno#" step="1" >
							<td align="center">
								<span class="pix9">#s#</span>
							</td>
						</cfloop>
				</tr>
				
				<cfoutput group="fixturedate">
					<tr>
						<td  align="left">
							<a href="MtchDay.cfm?TblName=Matches&MDate=#QAppearanceRecord.fixturedate#&LeagueCode=#LeagueCode#"><span class="pix10bold">#DateFormat(QAppearanceRecord.fixturedate, "DD MMM")#</span></a>
						</td>
						<td  align="left">
							<span class="pix9">#CompName#</span>
						</td>
						
						<cfset ShirtList = "">
						<cfset PNameList = "">
						<cfset PActivityList = "">
						<cfoutput>
							<cfset ShirtList = ListAppend(ShirtList, #SNumber#)>
							<cfset PNameList = ListAppend(PNameList, #PlayerName#)>
							<cfset PActivityList = ListAppend(PActivityList, #Activity#)>
						</cfoutput>
						<cfset x = 1 >
						<cfloop index="i" from="1" to="#QAppearanceRecordMax.MaxSno#" step="1" >
							<cfif (x LE ListLen(ShirtList)) AND (ListGetAt(ShirtList,x) IS i) >
								<cfif ListGetAt(PActivityList,x) IS 1>
									<cfset ThisBGColor = "#BG_originalcolor#">
								<cfelseif ListGetAt(PActivityList,x) IS 2>
									<cfset ThisBGColor = "silver">
								<cfelseif ListGetAt(PActivityList,x) IS 3>
									<cfset ThisBGColor = "white">
								<cfelse>
								</cfif>
								<td align="left" bgcolor="#ThisBGColor#">
									<span class="pix9">#ListGetAt(PNameList,x)#</span>
								</td>
								<cfset x = x + 1 >
							<cfelse>
								<td align="left">
									<span class="pix9">&nbsp;</span>
								</td>
							</cfif>
						</cfloop>
					</tr>
				</cfoutput>
			</cfoutput>
		</table>
	</cfif>
</cfif>
<br><br>
<br><br><br><br><br><br><br><br><br><br>