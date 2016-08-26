<cfinclude template="InclAuthorityCheck.cfm">

<CFSET session.Hdr1 = "Match Fines" >

<!--- Trick I'm using to suppress any headings --->
<CFSET BatchInput = "No">

<CFSET TTL="Match Fines" >

<!--- include toolbar.cfm--->
<cfinclude template="InclBegin.cfm">

<CFQUERY NAME="QTeamName" datasource=#ODBC_DataSource#>
SELECT
	t1.Long as TeamName1 ,
	o1.Long as OrdinalName1 ,
	t2.Long as TeamName2 ,
	o2.Long as OrdinalName2 ,
	f.HomeGoals as HomeGoals ,
	f.AwayGoals as AwayGoals ,
	f.FixtureDate as FixtureDate ,
	d.Long as DivisionName ,
	c1.TeamID as HomeTeamID ,
	c2.TeamID as AwayTeamID
FROM
	Division d, Team t1, Ordinal o1, Team t2, Ordinal o2, Constitution c1, Constitution c2, Fixture f
WHERE
	f.ID = #FID# AND
	f.HomeID = c1.ID AND f.AwayID = c2.ID AND
	c1.TeamID = t1.ID AND
	c1.OrdinalID = o1.ID AND
	c2.TeamID = t2.ID AND
	c2.OrdinalID = o2.ID AND
	d.ID = c1.DivisionID 

</CFQUERY>

<!--- This query is used to populate the top half of the screen --->
<CFQUERY NAME="QRulesBroken" datasource=#ODBC_DataSource#>
SELECT
	ru.ID as RuleID ,
	ru.Long as RuleDesc ,
	ru.Short as DefaultFineAmount ,
	<!--- ru.Notes as RuleNotes ,	--->
	mf.ID as MatchFineID ,
	mf.Amount as ActualFineAmount ,
	mf.FineDate as FineDate ,
	mf.PaidDate as PaidDate
FROM
	Rule ru , MatchFine mf
WHERE
	mf.FixtureID = #FID# AND
	mf.HomeAway = '#HA#' AND
	mf.RuleID = ru.ID
ORDER BY
	mf.FineDate, mf.PaidDate
</CFQUERY>


<!--- This query is used to populate the bottom half of the screen --->
<cfset RuleIDList=ValueList(QRulesBroken.RuleID)>
<CFQUERY NAME="QRulesNotBroken" datasource=#ODBC_DataSource#>
SELECT
	ru.ID as RuleID ,
	ru.Long as RuleDesc ,
<!---	ru.Notes as RuleNotes , --->	
	ru.Short as DefaultFineAmount 
FROM
	Rule ru
WHERE
	ru.Medium = 'M'
<CFIF QRulesBroken.RecordCount GT 0>
	AND ru.ID NOT IN (#RuleIDList#)
</cfif>
ORDER BY
  ru.Short, ru.Long
</CFQUERY>


<CFFORM NAME="MatchFinesForm" ACTION="UpdateMatchFineList.cfm" >
	<CFOUTPUT>
		
		<input type="Hidden" name="TblName" value="MatchFineList">
		<input type="Hidden" name="LeagueCode" value="#LeagueCode#">
		<input type="Hidden" name="DivisionID" value="#DivisionID#">

		<input type="Hidden" name="FID" value="#FID#">		
		<input type="Hidden" name="HA" value="#HA#">
		
	</cfoutput>

	<CFSET RuleCount = QRulesBroken.RecordCount>
	<input type="Hidden" name="RulesBrokenCount" value="<CFOUTPUT>#RuleCount#</cfoutput>">
	<CFSET NoOfCols = 2>
	<CFIF RuleCount Mod NoOfCols IS 0 >
		<CFSET NoOfRulesPerCol = RuleCount / NoOfCols>
	<CFELSE>
		<CFSET NoOfRulesPerCol = Round((RuleCount / NoOfCols)+ 0.5) >
	</CFIF>
	<!--- <cfset RuleNotesList=ValueList(QRulesBroken.RuleNotes,"~")>	--->
	<cfset RuleDescList=ValueList(QRulesBroken.RuleDesc)>
	<cfset DefaultFineAmountList=ValueList(QRulesBroken.DefaultFineAmount)>
	<cfset ActualFineAmountList=ValueList(QRulesBroken.ActualFineAmount)>

	<cfset FineDateList=ValueList(QRulesBroken.FineDate)>
	<cfset PaidDateList=ValueList(QRulesBroken.PaidDate)>
	
<!---	
	<cfset RuleIDList=ValueList(QRulesBroken.RuleID)>
--->	

	<cfset MatchFineIDList=ValueList(QRulesBroken.MatchFineID)>


	
	<cfoutput query="QTeamName">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" align="CENTER" bgcolor=#BG_Color#>
		<tr bgcolor="Aqua">
			<td colspan="#NoOfCols#" align="CENTER">
			<font face=#Font_Face# size="-2">
			 <CFIF HA IS "H">
			 	Click <A HREF="MatchFineList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=A"><b>here</b></a>
			 	to update match fines for #TeamName2# #OrdinalName2#
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				Click <A HREF="ClubMatchFines.cfm?LeagueCode=#LeagueCode#&TeamID=#QTeamName.HomeTeamID#"><b>here</b></a>
			 	to see all the #TeamName1# Match Fines
			 </CFIF>
			 
			 <CFIF HA IS "A">
			 	Click <A HREF="MatchFineList.cfm?LeagueCode=#LeagueCode#&FID=#FID#&HA=H"><b>here</b></a>
			 	to update match fines for #TeamName1# #OrdinalName1#
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				Click <A HREF="ClubMatchFines.cfm?LeagueCode=#LeagueCode#&TeamID=#QTeamName.AwayTeamID#"><b>here</b></a>
			 	to see all the #TeamName2# Match Fines
			 </CFIF>
			</font>			
			</td>
		</tr>
		<tr>
			<td colspan="#NoOfCols#" align="CENTER" >
			<font face=#Font_Face# size="-1"><BR><a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(FixtureDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#"><b>#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#<BR></b></a></font>
			<font face=#Font_Face# size="-1"><b>#DivisionName#</b><BR></font>
			
			<CFIF HA IS "H">
				<font face=#Font_Face# size="+1" color="Black">
					<b>#TeamName1# #OrdinalName1#&nbsp;&nbsp;[ #HomeGoals# ]&nbsp;&nbsp;&nbsp;</b> 
				</font>
				<font face="#Font_Face#" size="+1" color="Silver">
					<b>#TeamName2# #OrdinalName2#&nbsp;&nbsp;[ #AwayGoals# ]</b>
				</font>
			<CFELSEIF HA IS "A">
				<font face="#Font_Face#" size="+1" color="Silver">
					<b>#TeamName1# #OrdinalName1#&nbsp;&nbsp;[ #HomeGoals# ]&nbsp;&nbsp;&nbsp;</b> 
				</font>
				<font face=#Font_Face# size="+1" color="Black">
					 <b>#TeamName2# #OrdinalName2#&nbsp;&nbsp;[ #AwayGoals# ]</b>
				</font>
			<CFELSE>
			</CFIF>

			</td>
		</tr>
		
		<CFSET TotalMatchFineAmount = 0 >
		<CFIF RuleCount GT 0>
			<tr valign="TOP">
				<cfloop index="ColN" from="1" to="#NoOfCols#" step="1" >
					<CFSET xxx=((#ColN#-1) * #NoOfRulesPerCol#)+1>
					<CFSET yyy=MIN((#ColN# * #NoOfRulesPerCol#),#RuleCount#)>
			
					<td width="50%">
<!---
							*************************************************************
							* Produce the list of rules that were broken	            *
							* across the top half of screen in columns ( see NoOfCols)	*
							*************************************************************
--->

					<table border="0" cellspacing="2" cellpadding="0" >
						<CFIF RuleCount GT 0>
							<tr>
								<td></td>
								<td align="CENTER">
									<font face=#Font_Face# size="-2" >
										fine date
									</font>
								</td>

								<td align="LEFT">
									<font face=#Font_Face# size="-2" >
										&pound; amount
									</font>
								</td>
								
								<td align="CENTER">
									<font face=#Font_Face# size="-2" >
										paid date
									</font>
								</td>
								
							</tr>
						</cfif>

						<cfloop index="RowN" from="#xxx#" to="#yyy#" step="1">
<!---						
							<CFSET ThisRuleID = ListGetAt(RuleIDList, RowN)>
							<input type="Hidden" name="ppid#RowN#" value="#ThisRuleID#">
--->

							<CFSET ThisMatchFineID = ListGetAt(MatchFineIDList, RowN)>
							<input type="Hidden" name="mf#RowN#" value="#ThisMatchFineID#">

							<tr>
								<td align="CENTER">
									<font face=#Font_Face# size="-1">
										<input type="Checkbox" name="pp#RowN#" checked>
									</font>
								</td>
								<!--- <CFSET ThisRuleNotes = ListGetAt(RuleNotesList, RowN, "~")> --->
								<CFSET ThisDefaultFineAmount = ListGetAt(DefaultFineAmountList, RowN)>
								<CFSET ThisActualFineAmount = ListGetAt(ActualFineAmountList, RowN)>
								<CFSET TotalMatchFineAmount = TotalMatchFineAmount + ThisActualFineAmount >
								

								<CFSET ThisRuleDesc = ListGetAt(RuleDescList, RowN)>

								<CFIF ThisRuleDesc IS "Checked">
									<CFSET FDate = ListGetAt(FineDateList, RowN)>
									<CFSET FDate = #DateFormat(FDate, "DD MMM YYYY")#>
									<input  size="10" type="Hidden" name="fdte#RowN#" value="#FDate#">
									<td width="200" colspan="4" align="CENTER" bgcolor="Silver">
										<font face=#Font_Face# size="-1">
											<i><b>Checked #FDate#</b></i>
										</font>
									</td>
									<CFSET AmtText = "#NumberFormat('0', '9,999.99')#">
									<input type="Hidden" name="amt#RowN#" value="#AmtText#">
									<CFSET PDate = ListGetAt(PaidDateList, RowN)>
									<CFSET PDate = #DateFormat(PDate, "DD MMM YYYY")#>
									<input  size="10" type="Hidden" name="pdte#RowN#" value="#PDate#">


									
								<CFELSE>

								<!--- If they enter something in the "Checked" amount field overwrite with zero--->									

									<CFSET FDate = ListGetAt(FineDateList, RowN)>
									<td valign="MIDDLE">
										<CFSET FDate = #DateFormat(FDate, "DD MMM YYYY")#>
										<input  size="10" type="Text" name="fdte#RowN#" value="#FDate#">
									</td>
	
									
									<td align="CENTER">
										<font face=#Font_Face# size="-1">
										<CFSET AmtText = "#NumberFormat(ThisActualFineAmount, '9,999.99')#">
										<input  size="6" type="Text" name="amt#RowN#" value="#AmtText#">
										</font>
									</td>
	
									<CFSET PDate = ListGetAt(PaidDateList, RowN)>
									<td valign="MIDDLE">
										<CFSET PDate = #DateFormat(PDate, "DD MMM YYYY")#>
										<input  size="10" type="Text" name="pdte#RowN#" value="#PDate#">
									</td>

				
									<td align="LEFT" valign="MIDDLE" >
										<CFIF DateDiff( "D", FDate, PDate ) LT 0 >
											<font face=#Font_Face# size="-2" color="Red" >
												<b>UNPAID</b>
											</font>
											<CFSET OverDueBy = DateDiff( "D", FDate, Now() )>
											<CFIF OverDueBy GT 0>
												<font face=#Font_Face# size="-2" color="Red" >
													<b>for #OverDueBy# days</b>
												</font>
											</cfif>
											<BR>
										</cfif>
																			
										<font face=#Font_Face# size="-1">
											<b>#ThisRuleDesc#</b>
										</font>
									</td>
								
								
								
								</CFIF>								
								
								
								
								
								
								
								
							</tr>










							
							<tr>
								<td></td>	
								<td></td>
								<CFIF ThisDefaultFineAmount IS NOT ThisActualFineAmount>						
									<td align="CENTER" valign="TOP"><font face="#Font_Face#" size="-2" color="Red">#NumberFormat(ThisDefaultFineAmount, '9,999.99')#</font></td>
								<cfelse>
									<td align="CENTER"></td>
								</cfif>
								<!---
								<td colspan="3">
									<CFIF ThisRuleDesc IS "Checked">
									<CFELSE>
										<font face=#Font_Face# size="-2">
											#ThisRuleNotes#
										</font>
									</CFIF>
									
								</td>
								--->
								<td></td>	
								<td></td>
							
							</tr>

							<!---
							<tr>
								<td></td>
								<td colspan="4">
									<CFIF ThisRuleDesc IS "Checked">
									<CFELSE>
										<font face=#Font_Face# size="-2">
											#ThisRuleNotes#
										</font>
									</CFIF>
									
								</td>
							
							</tr>
							--->

						</cfloop>
					</table>
					</td>
				</cfloop>
			</tr>
		</cfif>
	</table>
	
	<CFIF RuleCount IS 0>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="CENTER" bgcolor=#BG_Color#>
			<tr>
				<td height="50" align="CENTER" bgcolor="White">
					<font face=#Font_Face# size="+1" color="Red">
						<b>Please tick <i>Checked</i> and any rules that have been broken.<BR>
						You can alter any amounts as necessary.</b>
					</font>
				</td>
			</tr>
		</table>
	<CFELSEIF RuleCount IS 1 AND QRulesBroken.RuleDesc IS "Checked">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="CENTER" bgcolor=#BG_Color#>
			<tr>
				<td height="50" align="CENTER" bgcolor=#BG_Color#>
					<font face=#Font_Face# size="+1" >
						&nbsp;
					</font>
				</td>
			</tr>
		</table>
	<CFELSEIF RuleCount GT 0 AND NOT ListFindNoCase( RuleDescList, "Checked" ) >
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="CENTER" bgcolor=#BG_Color#>
			<tr>
				<td height="50" align="CENTER" bgcolor="White">
					<font face=#Font_Face# size="+1" >
						<b>Total Match Fine = &pound;#NumberFormat(TotalMatchFineAmount, '9,999.99')#</b>
					</font>
					<BR>
					<font face=#Font_Face# size="+1" color="Red">
						<b>Please tick <i>Checked</i> as well as any rules that have been broken</b>
					</font>
				</td>
			</tr>
		</table>
	<CFELSEIF RuleCount GT 1>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="CENTER" bgcolor=#BG_Color#>
			<tr>
				<td height="50" align="CENTER" bgcolor="White">
					<font face=#Font_Face# size="+1" >
						<b>Total Match Fine = &pound;#NumberFormat(TotalMatchFineAmount, '9,999.99')#</b>
					</font>
				</td>
			</tr>
		</table>
	</cfif>
	
	
	</cfoutput>
<!---
=====================================================================================================================
========================================================= BOTTOM HALF ===============================================
=====================================================================================================================
--->
	<CFSET RuleCount = QRulesNotBroken.RecordCount>
	<input type="Hidden" name="RulesNotBrokenCount" value="<CFOUTPUT>#RuleCount#</cfoutput>">
	<CFIF RuleCount Mod NoOfCols IS 0 >
		<CFSET NoOfRulesPerCol = RuleCount / NoOfCols>
	<CFELSE>
		<CFSET NoOfRulesPerCol = Round((RuleCount / NoOfCols)+ 0.5) >
	</CFIF>
	
	<!--- <cfset RuleNotesList=ValueList(QRulesNotBroken.RuleNotes,"~")> --->
	<cfset RuleDescList=ValueList(QRulesNotBroken.RuleDesc)>
	<cfset DefaultFineAmountList=ValueList(QRulesNotBroken.DefaultFineAmount)>
	<cfset RuleIDList=ValueList(QRulesNotBroken.RuleID)>




<!---
							***************************************************
							* Produce the list of rules that were NOT broken  *
							* across the bottom half of screen in columns     *
							***************************************************
--->

	<cfoutput>
	<table width="100%" border="0" cellspacing="0" cellpadding="2" align="CENTER" bgcolor=#BG_Color#>

		<tr valign="TOP">
			<cfloop index="ColN" from="1" to="#NoOfCols#" step="1" >
				<CFSET xxx=((#ColN#-1) * #NoOfRulesPerCol#)+1>
				<CFSET yyy=MIN((#ColN# * #NoOfRulesPerCol#),#RuleCount#)>
				<td width="50%">
				<table border="0" cellspacing="2" cellpadding="0" >
					<cfloop index="RowN" from="#xxx#" to="#yyy#" step="1">
						<!--- <CFSET ThisRuleNotes = ListGetAt(RuleNotesList, RowN, "~")> --->
						<CFSET ThisRuleID = ListGetAt(RuleIDList, RowN)>
						<CFSET ThisDefaultFineAmount = ListGetAt(DefaultFineAmountList, RowN)>
						<CFSET ThisRuleDesc = ListGetAt(RuleDescList, RowN)>
						<input type="Hidden" name="PID#RowN#" value="#ThisRuleID#">
						<input type="Hidden" name="amnt#RowN#" value="#ThisDefaultFineAmount#">
						<tr>
							<td align="CENTER">
								<font face=#Font_Face# size="-1">
									<input type="Checkbox" name="P#RowN#" >
								</font>
							</td>
							<CFIF ThisRuleDesc IS "Checked">
								<td align="CENTER" bgcolor="Silver">
									<font face=#Font_Face# size="-1">
										<i><b>#ThisRuleDesc#</b></i>
									</font>
								</td>
							<CFELSE>
								<td align="LEFT">
									<font face=#Font_Face# size="-1">
										<b>#ThisRuleDesc#</b>
									</font>
								</td>
							</CFIF>
						</tr>
						<!---
						<tr>
							<td></td>
							<td>
								<CFIF ThisRuleDesc IS "Checked">
								<CFELSE>
									<font face=#Font_Face# size="-2">
										&pound;#NumberFormat(ThisDefaultFineAmount, '9,999.99')# #ThisRuleNotes#
									</font>
								</CFIF>
								
							</td>
						</tr>
						--->
					</cfloop>
				</table>
				</td>
			</cfloop>
		</tr>
	</table>
	
	
	
	<table width="100%" border="0" cellspacing="0" cellpadding="2" align="CENTER" bgcolor=#BG_Color#>
			<TR bgcolor=#BG_Color#><td colspan="4" align="CENTER"><font size="+2"><input type="Submit" value="OK"></font></td></tr>
	</table>

	</cfoutput>
	</CFFORM>
