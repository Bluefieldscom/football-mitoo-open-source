<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>

<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfsetting enablecfoutputonly="yes">
<CFCONTENT type="application/msexcel">
<cfheader name="Content-Disposition" value="filename=AppearanceAnalysis.xls">


				<cfinclude template="queries/qry_QAppAnalysis.cfm">
				<cfset Maxx = #QAppAnalysis.RecordCount#>
				<cfset ConstitIDList = ValueList(QAppAnalysis.ConstitID)>
				<cfset CompetitionCodeList = ValueList(QAppAnalysis.CompetitionCode)>
				<cfset OrdinalNameList = QuotedValueList(QAppAnalysis.OrdinalName)>
				<cfinclude template="queries/qry_QAppearances.cfm">
				<cfset Maxy = #QAppearances.RecordCount#>
				<cfset PlayerIDList = ValueList(QAppearances.PlayerID)>
				<cfset PlayerNameList = ValueList(QAppearances.PlayerName)>
				<cfset PlayerSurnameList = ValueList(QAppearances.PlayerSurname)>
				<cfset PlayerForenameList = ValueList(QAppearances.PlayerForename)> <!--- qry_QAppearances.cfm puts dash in place of blank forename --->
				<cfset PlayerNoList = ValueList(QAppearances.PlayerNo)>			
				<cfset AppsList = ValueList(QAppearances.Apps)>
				<cfset Apps1List = ValueList(QAppearances.Apps1)>
				<cfset Apps2List = ValueList(QAppearances.Apps2)>
				<cfset Apps3List = ValueList(QAppearances.Apps3)>
				<cfset GoalsList = ValueList(QAppearances.Goals)>
				<cfoutput>
				<table border="1" cellspacing="1" cellpadding="3" align="CENTER">
					<cfset colspan = Maxx + 8>
					<tr>
						<td colspan="#colspan#" align="center" valign="middle"><strong>#QAppAnalysis.TName#</strong></td>
					</tr>
					<tr>
						<td align="CENTER">Player<BR>No.</td>
						<td><strong>Surname</strong> Forenames</td>
						<td align="CENTER">Goals</td>
						<td align="CENTER">Games</td>
						<td align="CENTER">Start</td>
						<td align="center" bgcolor="silver">Sub<br>Y</td>
						<td align="center" bgcolor="white">Sub<br>N</td>
						
						<cfloop index="x" from="1" to="#Maxx#" step="1" >
							<cfif #ListGetAt(OrdinalNameList,x)# IS "''">
								<cfset TeamName = "1st Team">
							<cfelse>
								<cfset TeamName = ListGetAt(OrdinalNameList,x)>
								<cfset TeamName = Replace(TeamName, "'", "", "ALL")>
							</cfif>
							<td align="CENTER">#TeamName#<BR>#ListGetAt(CompetitionCodeList,x)#</td>
						</cfloop>
					</tr>
					<cfloop index="y" from="1" to="#Maxy#" step="1" >
						<tr>
							<td align="RIGHT">#ListGetAt(PlayerNoList,y)#</td>
							<cfset PlayerSurname = #ListGetAt(PlayerSurnameList,y)#>
							<cfset PlayerForename = #ListGetAt(PlayerForenameList,y)#>
							<td><strong>#PlayerSurname#</strong> #PlayerForename#</td>
							<td align="CENTER"><cfif ListGetAt(GoalsList,y) GT 0>#NumberFormat(ListGetAt(GoalsList,y))#<cfelse>&nbsp;</cfif></td>
							<td align="CENTER"><cfif ListGetAt(AppsList,y) GT 0>#NumberFormat(ListGetAt(AppsList,y))#<cfelse>&nbsp;</cfif></td>
							<td align="CENTER"><cfif ListGetAt(Apps1List,y) GT 0>#NumberFormat(ListGetAt(Apps1List,y))#<cfelse>&nbsp;</cfif></td>
							<td align="center" bgcolor="silver"><cfif ListGetAt(Apps2List,y) GT 0>#NumberFormat(ListGetAt(Apps2List,y))#<cfelse>&nbsp;</cfif></td>
							<td align="center" bgcolor="white"><cfif ListGetAt(Apps3List,y) GT 0>#NumberFormat(ListGetAt(Apps3List,y))#<cfelse>&nbsp;</cfif></td>
							<cfloop index="x" from="1" to="#Maxx#" step="1" >
								<cfinclude template="queries/qry_QApps.cfm">
								<td align="CENTER"><cfif QApps.AppCount GT 0>#QApps.AppCount#<cfelse>&nbsp;</cfif></td>
							</cfloop>
							<cfinclude template="queries/qry_QTransf.cfm">
							<cfif QTransf.RecordCount GT 0>
								<cfif #ListGetAt(PlayerNoList,y)# GT 0>
									<td align="CENTER" bgcolor="Silver">#QTransf.RecordCount# for another club or competition</td>
								</cfif>
							</cfif>
							<cfinclude template="queries/qry_QTeamID.cfm">
							<cfif QTeamID.TName IS "">
								<cfif #ListGetAt(PlayerNoList,y)# GT 0>
									<td align="CENTER">NOT REGISTERED</td>
								</cfif>
							</cfif>
						</tr>
					</cfloop>
					</cfoutput>
				</table>
