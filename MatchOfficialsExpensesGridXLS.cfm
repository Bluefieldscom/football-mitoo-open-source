<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfsilent>
<cfinclude template = "queries/qry_QTeamList.cfm">
<cfinclude template = "queries/qry_QMatchOfficialsExpenses.cfm">
<cfset CIDList=ValueList(QTeamList.CID)>
<cfset TeamIDList=ValueList(QTeamList.TeamID)>
<cfset SaveColSpan = QTeamList.RecordCount + 4>
</cfsilent>
<cfif QTeamList.RecordCount GT 30 >
	<cfoutput><span class="pix13boldred">Too many teams for Match Officials Expenses Grid</span></cfoutput>
<cfabort>
</cfif>
<cfsetting enablecfoutputonly="yes">
<CFCONTENT type="application/msexcel">
<cfheader name="Content-Disposition" value="filename=ResultsGrid.xls">
<cfset ThisColSpan = SaveColSpan >
<cfoutput>
<table border="1">

<tr> <td colspan="#ThisColSpan#" align="center">#SeasonName#</td></tr>
<tr> <td colspan="#ThisColSpan#" align="center">#LeagueName#</td></tr>

<tr> <td colspan="#ThisColSpan#" align="center" valign="top">#ThisCompetitionDescription#</td></tr>
<tr bgcolor="White">
	<td height="20" colspan="#ThisColSpan#" align="left">&nbsp;</td>
</tr>

<cfset ColumnRefList=("A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,AA,AB,AC,AD,AE,AF,AG,AH,AI,AJ,AK,AL,AM,AN")>
</cfoutput>
	<tr>
		<cfoutput><td align="center">&nbsp;</td><td align="center">No. of Games</td></cfoutput>
		<cfoutput query="QTeamList">
		<td align="center" valign="top"><cfif TeamNameMedium IS "">#TeamName#<cfelse>#TeamNameMedium#</cfif> <cfif OrdinalNameShort IS "">#OrdinalName#<cfelse>#OrdinalNameShort#</cfif></td>
		</cfoutput>
		<cfoutput><td align="center">TOTAL</td><td align="center">Adjustment</td></cfoutput>
	</tr>
<cfoutput query="QTeamList">
	<tr>
		<td valign="middle">#TeamName# #OrdinalName#</td>
		<td valign="middle">=+COUNT(#ListGetAt(ColumnRefList,3)##CurrentRow+5#:#ListGetAt(ColumnRefList,(2+QTeamList.RecordCount))##CurrentRow+5#)</td>
		<cfloop index="ColN" from="1" to="#QTeamList.RecordCount#" step="1" >
			
				<cfif QTeamList.CID IS ListGetAt(CIDList, ColN)><td align="center" bgcolor="black">&nbsp;</td>
				<cfelse>
					<cfinclude template = "queries/qry_QGetMOExpenses.cfm">
						<td align="center">
							<table border="1">
							<cfif QGetMOExpenses.RecordCount IS 0>
								<tr>
									<td align="center" bgcolor="yellow">&nbsp;</td>
								</tr>
							<cfelse>
								<cfloop query="QGetMOExpenses">
									<tr>
										<td bgcolor="white" width="50" align="right">#MatchOfficialsExpenses#</td>
									</tr>
								</cfloop>
							</cfif>
							</table>
						</td>
				</cfif>
		</cfloop>
		<td valign="middle">=+SUM(#ListGetAt(ColumnRefList,3)##CurrentRow+5#:#ListGetAt(ColumnRefList,(2+QTeamList.RecordCount))##CurrentRow+5#)</td>
	<!--- adjustment --->
      <td valign="middle">=ROUND(+SUM(#ListGetAt(ColumnRefList,3+QTeamList.RecordCount)#6:#ListGetAt(ColumnRefList,3+QTeamList.RecordCount)##QTeamList.RecordCount+5#)/#QTeamList.RecordCount# -  SUM(#ListGetAt(ColumnRefList,3)##CurrentRow+5#:#ListGetAt(ColumnRefList,(2+QTeamList.RecordCount))##CurrentRow+5#),2)</td>
	</tr>
</cfoutput>
<cfoutput>
<tr>
<td>TOTAL</td>
<td valign="middle">=+SUM(#ListGetAt(ColumnRefList,2)#6:#ListGetAt(ColumnRefList,2)##QTeamList.RecordCount+5#)</td>
<cfloop index="ColN" from="1" to="#QTeamList.RecordCount#" step="1" >
	<td valign="middle">=+SUM(#ListGetAt(ColumnRefList,ColN+2)#6:#ListGetAt(ColumnRefList,ColN+2)##QTeamList.RecordCount+5#)</td>
</cfloop>
<td valign="middle">=+SUM(#ListGetAt(ColumnRefList,QTeamList.RecordCount+3)#6:#ListGetAt(ColumnRefList,QTeamList.RecordCount+3)##QTeamList.RecordCount+5#)</td>
<!--- check total, should be near enough zero --->			
<td valign="middle">= FIXED(+SUM(#ListGetAt(ColumnRefList,QTeamList.RecordCount+4)#6:#ListGetAt(ColumnRefList,QTeamList.RecordCount+4)##QTeamList.RecordCount+5#),2)  </td>			
</tr>
</cfoutput>

<cfoutput>
<tr>  <!--- TOTAL divided by no. of teams is Average per Team --->
<td colspan="#QTeamList.RecordCount+2#" align="right">TOTAL divided by #QTeamList.RecordCount# is Average per Team
<td>= ( SUM(#ListGetAt(ColumnRefList,3+QTeamList.RecordCount)#6:#ListGetAt(ColumnRefList,3+QTeamList.RecordCount)##QTeamList.RecordCount+5#) )  / #QTeamList.RecordCount# </td>
<td></td>
</tr>
<tr></tr>
<tr></tr>
<tr>   <!--- Average per Game --->
<td colspan="#QTeamList.RecordCount+2#" align="right">Average per Game<td>= (SUM(#ListGetAt(ColumnRefList,QTeamList.RecordCount+3)#6:#ListGetAt(ColumnRefList,QTeamList.RecordCount+3)##QTeamList.RecordCount+5#)) / (SUM(#ListGetAt(ColumnRefList,2)#6:#ListGetAt(ColumnRefList,2)##QTeamList.RecordCount+5#))</td>
<td></td>
</tr>
</cfoutput>

</table>




