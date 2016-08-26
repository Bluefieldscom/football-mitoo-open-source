<!--- called by MtchDay.cfm --->
<cfinclude template="queries/qry_QTeamFreeDate.cfm">
<cfset FreeTOIDList = ValueList(QTeamFreeDate.FreeTOID)> <!--- FreeTOID is concatenated in the form 'TeamID'+'-'+'OrdinalID' eg. '14907-107' --->

<!--- produces a list, at the bottom of the screen, of teams that are not playing on this match day. Can only be seen when logged in. --->
<cfinclude template="queries/qry_NotPlayingToday01.cfm">
<cfset CIDList = "0">
<cfoutput query="NotPlayingToday01" >
	<cfinclude template="queries/qry_NotPlayingToday03.cfm">
	<cfset CIDList = ListAppend(CIDList, ValueList(NotPlayingToday03.CID))>
	<cfinclude template="queries/qry_NotPlayingToday04.cfm">
	<cfset CIDList = ListAppend(CIDList, ValueList(NotPlayingToday04.CID))>
</cfoutput>
<cfinclude template="queries/qry_NotPlayingToday02.cfm">
<cfif NotPlayingToday02.RecordCount IS "0" >
	<cfoutput><span class="pix13bold">All teams are playing today</span></cfoutput>
<cfelse>
<!---
							**************************************************************
							* Produce the full list across the bottom of the screen      *
							* in four columns (variable, see NoOfCols)					 *
							**************************************************************
--->
	<cfset TeamCount = NotPlayingToday02.RecordCount>
	<cfset NoOfCols = 5>
	<cfif TeamCount Mod NoOfCols IS 0 >
		<cfset NoOfTeamsPerCol = TeamCount / NoOfCols>
	<cfelse>
		<cfset NoOfTeamsPerCol = Round((TeamCount / NoOfCols)+ 0.5) >
	</cfif>
	<cfset DivisionNameList=ValueList(NotPlayingToday02.DivisionName)>	
	<cfset TeamNameList=ValueList(NotPlayingToday02.TeamName)>
	<cfset OrdinalNameList=QuotedValueList(NotPlayingToday02.OrdinalName)>
	<cfset TIDList=ValueList(NotPlayingToday02.TID)>
	<cfset OIDList=ValueList(NotPlayingToday02.OID)>
	<cfset ThisDivisionName = 'xxxxxxxxxxx' >
	
	<cfoutput>
		<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="##F5F5F5" >
		<tr>
			<td height="30" colspan="#NoOfCols#" align="center">
				<span class="pix10">These teams without fixtures are available to play unless shown as <img src="gif/unavailable.gif"></span><!--- FREE DAY--->
			</td>
		</tr>
		<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
			<tr>
				<td height="30" colspan="#NoOfCols#" align="center">
					<span class="pix10"> Click on <img src="FreeDay.gif"> button to switch on/off <img src="gif/unavailable.gif"> e.g. if the players are attending a wedding or if they are on vacation.</span><!--- FREE DAY--->
				</td>
			</tr>
		</cfif>
			<tr valign="TOP">
				<cfloop index="ColN" from="1" to="#NoOfCols#" step="1" >
					<cfset xxx=((#ColN#-1) * #NoOfTeamsPerCol#)+1>
					<cfset yyy=MIN((#ColN# * #NoOfTeamsPerCol#),#TeamCount#)>
					<td align="left">
						<table border="0" cellspacing="0" cellpadding="0" >
							<cfloop index="RowN" from="#xxx#" to="#yyy#" step="1">
								<cfset OrdinalString = ListGetAt(OrdinalNameList, RowN)>
								<cfif Len(OrdinalString) IS 2>
									<cfset OrdinalString = ''>
								<cfelse>
									<cfset OrdinalString = Right(OrdinalString, Len(OrdinalString) - 1)  >
									<cfset OrdinalString = Left(OrdinalString, Len(OrdinalString) - 1)  >
								</cfif>
								<cfif ThisDivisionName IS ListGetAt(DivisionNameList, RowN)>
								<cfelse>
									<tr>
										<td height="14" align="center" bgcolor="silver">
											<span class="pix10bold">#ListGetAt(DivisionNameList, RowN)#</span>
										</td>
									</tr>
								</cfif>
								<tr>
									<cfset ThisTOID = "#ListGetAt(TIDList, RowN)#-#ListGetAt(OIDList, RowN)#">
									<td>
										<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
											<span class="pix10"> #RowN#. </span><a href="UpdateFreeDay.cfm?ThisTOID=#ThisTOID#&MDate=#DateFormat(MDate,'YYYY-MM-DD')#&LeagueCode=#LeagueCode#"><img src="FreeDay.gif" border="0"></a>
										<cfelse>
											<span class="pix10"> #RowN#. </span>
										</cfif>	
										<cfif ListFind(FreeTOIDList, ThisTOID)>
											<span class="bg_pink"><span class="pix10">#ListGetAt(TeamNameList, RowN)# #OrdinalString# <img src="gif/unavailable.gif"></span><!--- FREE DAY--->
										<cfelse>
											<span class="pix10">#ListGetAt(TeamNameList, RowN)# #OrdinalString#</span>
										</cfif>
									</td>
								</tr>
								<cfset ThisDivisionName = ListGetAt(DivisionNameList, RowN) >
							</cfloop>
						</table>
					</td>
				</cfloop>
			</tr>
		</table>
	</cfoutput>
</cfif>

