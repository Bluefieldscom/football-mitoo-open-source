<cfinclude template="InclAuthorityCheck.cfm">

<CFSET session.Hdr1 = "" >

<!--- Trick I'm using to suppress any headings --->
<CFSET BatchInput = "No">

<CFSET TTL="" >

<!--- include toolbar.cfm--->
<cfinclude template="InclBegin.cfm">

<!--- This query is used to get the total match fines for this club --->
<CFQUERY NAME="QMatchFinesTotal" datasource=#ODBC_DataSource#>
	SELECT
		SUM(mf.Amount) as TotalAmount
	FROM
		Team t ,
		Constitution c ,
		Fixture f ,
		MatchFine mf
	WHERE
		c.TeamID = #TeamID# AND
		((c.ID = f.HomeID AND mf.HomeAway = 'H') OR (c.ID = f.AwayID AND mf.HomeAway = 'A')) AND
		c.TeamID = t.ID AND
		f.ID = mf.FixtureID
</cfquery>

<!--- This query is used to populate the top half of the screen --->
<CFQUERY NAME="QRulesBroken" datasource=#ODBC_DataSource#>
SELECT
	ru.ID as RuleID ,
	ru.Long as RuleDesc ,
	ru.Short as DefaultFineAmount ,
	af.ID as AdminFineID ,
	af.Amount as ActualFineAmount ,
	af.FineDate as FineDate ,
	af.PaidDate as PaidDate
FROM
	Rule ru , AdminFine af
WHERE
	af.TeamID = #TeamID# AND
	af.RuleID = ru.ID
ORDER BY
	af.FineDate, af.PaidDate
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
	ru.Medium = 'A'
<!---	
<CFIF QRulesBroken.RecordCount GT 0>
	AND ru.ID NOT IN (#RuleIDList#)
</cfif>
--->
ORDER BY
  ru.Short
</CFQUERY>

<CFFORM NAME="AdminFinesForm" ACTION="UpdateAdminFineList.cfm" >
	<CFOUTPUT>
		
		<input type="Hidden" name="TblName" value="AdminFineList">
		<input type="Hidden" name="LeagueCode" value="#LeagueCode#">
		<input type="Hidden" name="DivisionID" value="#DivisionID#">

		<input type="Hidden" name="TeamID" value="#TeamID#">		
		
	</cfoutput>

	<CFSET RuleCount = QRulesBroken.RecordCount>
	<input type="Hidden" name="RulesBrokenCount" value="<CFOUTPUT>#RuleCount#</cfoutput>">
	<CFSET NoOfCols = 2>
	<CFIF RuleCount Mod NoOfCols IS 0 >
		<CFSET NoOfRulesPerCol = RuleCount / NoOfCols>
	<CFELSE>
		<CFSET NoOfRulesPerCol = Round((RuleCount / NoOfCols)+ 0.5) >
	</CFIF>
	<cfset RuleDescList=ValueList(QRulesBroken.RuleDesc)>
	<cfset FineDateList=ValueList(QRulesBroken.FineDate)>
	<cfset PaidDateList=ValueList(QRulesBroken.PaidDate)>
	
	<cfset DefaultFineAmountList=ValueList(QRulesBroken.DefaultFineAmount)>
	
	<cfset ActualFineAmountList=ValueList(QRulesBroken.ActualFineAmount)>
	
	<cfset AdminFineIDList=ValueList(QRulesBroken.AdminFineID)>
	
	<cfoutput>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" align="CENTER" bgcolor=#BG_Color#>

		<!---
		<tr bgcolor="Aqua">
			<td colspan="#NoOfCols#" align="CENTER">
			<font face=#Font_Face# size="-2">
				Click <A HREF="FinesAnalysis.cfm?LeagueCode=#LeagueCode#&TeamID=#TeamID#"><b>here</b></a>
			 	to see Fines Analysis
			</font>			
			</td>
		</tr>
		--->
		<CFSET TotalAdminFineAmount = 0 >
		<CFSET TotalPaymentAmount = 0 >
		
		<CFIF RuleCount GT 0>
			<tr valign="TOP">
				<cfloop index="ColN" from="1" to="#NoOfCols#" step="1" >
					<CFSET xxx=((#ColN#-1) * #NoOfRulesPerCol#)+1>
					<CFSET yyy=MIN((#ColN# * #NoOfRulesPerCol#),#RuleCount#)>
			
					<td width="50%">
<!---
							*************************************************************
							* Produce the list of rules that were broken	                *
							* across the top half of screen in columns ( see NoOfCols)	*
							*************************************************************
--->

					<table  border="0" cellspacing="2" cellpadding="0">
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

							<CFSET ThisAdminFineID = ListGetAt(AdminFineIDList, RowN)>
							<input type="Hidden" name="af#RowN#" value="#ThisAdminFineID#">

							<tr>
								<CFSET ThisRuleDesc = ListGetAt(RuleDescList, RowN)>
								
								
								<CFIF ThisRuleDesc IS "Payment">
<!---																			***********
																				* PAYMENT *
																				***********
--->
									
									<input type="Hidden" name="IsPmt#RowN#" value="Y">
									
									
									<td align="CENTER" valign="MIDDLE">
										<font face=#Font_Face# size="-1">
											<input type="Checkbox" name="pp#RowN#" checked>
										</font>
									</td>
									<CFSET FDate = ListGetAt(FineDateList, RowN)>
									<td valign="MIDDLE">
										<CFSET FDate = #DateFormat(FDate, "DD MMM YYYY")#>
										<input  size="10" type="Hidden" name="fdte#RowN#" value="#FDate#">
										<font face=#Font_Face# size="-1">
											<b>Received</b>
										</font>
									</td>
									<CFSET ThisDefaultFineAmount = ListGetAt(DefaultFineAmountList, RowN)>
									<CFSET ThisActualFineAmount = ListGetAt(ActualFineAmountList, RowN)>
	
									<CFIF ThisActualFineAmount GT 0>
										<CFSET TotalAdminFineAmount = TotalAdminFineAmount + ThisActualFineAmount >
									</cfif> 
									<CFIF ThisActualFineAmount LT 0>
										<CFSET TotalPaymentAmount = TotalPaymentAmount + ThisActualFineAmount >
									</cfif> 
								
									<input type="Hidden" name="Neg#RowN#" value="Yes">
									<td valign="MIDDLE">
											<CFSET AmtText = "#NumberFormat(ThisActualFineAmount*-1, '9,999.99')#">
											<input  size="6" type="Text" name="amt#RowN#" value="#AmtText#">
									</td>
									
									
									<CFSET PDate =  ListGetAt(PaidDateList, RowN)>
									<td valign="MIDDLE">
										<CFSET PDate = #DateFormat(PDate, "DD MMM YYYY")#>
										<input  size="10" type="Text" name="pdte#RowN#" value="#PDate#">
									</td>
									
									<td width="300" valign="MIDDLE"  align="CENTER" bgcolor="#BG_Highlight#">
										<font face=#Font_Face# size="-1">
											<i><b>#ThisRuleDesc#</b></i>
										</font>
									</td>
									
								<CFELSE>
<!---																			***********
																				*   FINE  *
																				***********
--->

									
									<input type="Hidden" name="IsPmt#RowN#" value="N">

								
									<td align="CENTER" valign="MIDDLE">
										<font face=#Font_Face# size="-1">
											<input type="Checkbox" name="pp#RowN#" checked>
										</font>
									</td>
									<CFSET FDate = ListGetAt(FineDateList, RowN)>
									<td valign="MIDDLE">
										<CFSET FDate = #DateFormat(FDate, "DD MMM YYYY")#>
										<input  size="10" type="Text" name="fdte#RowN#" value="#FDate#">
									</td>
									<CFSET ThisDefaultFineAmount = ListGetAt(DefaultFineAmountList, RowN)>
									<CFSET ThisActualFineAmount = ListGetAt(ActualFineAmountList, RowN)>
	
									<CFIF ThisActualFineAmount GT 0>
										<CFSET TotalAdminFineAmount = TotalAdminFineAmount + ThisActualFineAmount >
									</cfif> 
									<CFIF ThisActualFineAmount LT 0>
										<CFSET TotalPaymentAmount = TotalPaymentAmount + ThisActualFineAmount >
									</cfif> 
									

									<input type="Hidden" name="Neg#RowN#" value="No">
									<td valign="MIDDLE">
										
											<CFSET AmtText = "#NumberFormat(ThisActualFineAmount, '9,999.99')#">
											<input  size="6" type="Text" name="amt#RowN#" value="#AmtText#">&nbsp;
										
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
								<td>
								
								</td>	
								
								<CFIF ThisDefaultFineAmount GT 0 AND ThisDefaultFineAmount IS NOT ThisActualFineAmount>						
									<td align="CENTER" valign="TOP"><font face="#Font_Face#" size="-2" color="Red">#NumberFormat(ThisDefaultFineAmount, '9,999.99')#</font></td>
								<cfelse>
									<td align="CENTER"></td>
								</cfif>
	
							</tr>
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
				<td height="120" align="CENTER" bgcolor="White">
					<font face=#Font_Face# size="-2" >
						&nbsp;
					</font>
				</td>
			</tr>
		</table>
	<CFELSE>
<!---
											*******************
											* Table of Totals *
											*******************
--->	
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="CENTER" bgcolor=#BG_Color#>
			<tr>
				<td height="50" align="CENTER" >
					<table border="1" cellspacing="0" cellpadding="4" align="CENTER" bgcolor="White">
						<tr>
							<td>
								<font face=#Font_Face# size="-1" color="Gray" >
									<A HREF="ClubMatchFines.cfm?LeagueCode=#LeagueCode#&TeamID=#TeamID#">
										<b>Total Match Fines</b>
									</a>
								</font>
							</td>
							<td align="RIGHT">
								<font face=#Font_Face# size="-1" >
									<b>&pound;#NumberFormat(QMatchFinesTotal.TotalAmount, '9,999.99')#</b>
								</font>
							</td>
						</tr>

						<tr>
							<td>
								<font face=#Font_Face# size="-1" >
									<b>Total Admin Fines</b>
								</font>
							</td>
							<td align="RIGHT">
								<font face=#Font_Face# size="-1" >
									<b>&pound;#NumberFormat(TotalAdminFineAmount, '9,999.99')#</b>
								</font>
							</td>
						</tr>
						<tr>
							<td>
								<font face=#Font_Face# size="-1" >
									<b>Total Payments</b>
								</font>
							</td>
							<td align="RIGHT">
								<font face=#Font_Face# size="-1" >
									<b>&pound;#NumberFormat(TotalPaymentAmount*-1, '9,999.99')#</b>
								</font>
							</td>
						</tr>
						<tr>
							<CFSET TotalOutstanding = QMatchFinesTotal.TotalAmount + TotalAdminFineAmount + TotalPaymentAmount>
							<CFIF TotalOutstanding IS NOT 0>
								<td>
									<font face=#Font_Face# size="-1" >
										<b>Total Outstanding</b>
									</font>
								</td>
								
								<td align="RIGHT">
									<font face=#Font_Face# size="-1">
										<b>&pound;#NumberFormat(TotalOutstanding, '9,999.99')#</b>
									</font>
								</td>
							
							<cfelse>
								<td colspan="2" align="CENTER">
									<font face=#Font_Face# size="+1" color="green" >
										<b>account settled</b>
									</font>
								</td>
							
							</cfif>
							</td>
						</tr>

					</table>
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

	<cfset RuleDescList=ValueList(QRulesNotBroken.RuleDesc)>
	<cfset DefaultFineAmountList=ValueList(QRulesNotBroken.DefaultFineAmount)>
	<cfset RuleIDList=ValueList(QRulesNotBroken.RuleID)>

	<!--- <cfset RuleNotesList=ValueList(QRulesNotBroken.RuleNotes,"~")> --->

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
					<table border="0" cellspacing="0" cellpadding="0" >
					<cfloop index="RowN" from="#xxx#" to="#yyy#" step="1">
						<CFSET ThisRuleID = ListGetAt(RuleIDList, RowN)>
						<CFSET ThisDefaultFineAmount = ListGetAt(DefaultFineAmountList, RowN)>
						<CFSET ThisRuleDesc = ListGetAt(RuleDescList, RowN)>
						<!--- <CFSET ThisRuleNotes = ListGetAt(RuleNotesList, RowN, "~")> --->
						<input type="Hidden" name="PID#RowN#" value="#ThisRuleID#">
						<input type="Hidden" name="amnt#RowN#" value="#ThisDefaultFineAmount#">
						<tr valign="TOP">
							<td>
								<table width="100%" border="0" cellspacing="2" cellpadding="0">
									<tr>
										<td width="5%" align="center">
											<font face=#Font_Face# size="-1">
												<input type="Checkbox" name="P#RowN#" >
											</font>
										</td>
										<CFIF ThisRuleDesc IS "Payment">
											<input type="Hidden" name="IsPaymt#RowN#" value="Y">
											<td width="300" align="CENTER" bgcolor=#BG_Highlight#>
												<font face=#Font_Face# size="-1">
													<i><b>Payment</b></i>
												</font>
											</td>
										<CFELSE>
											<input type="Hidden" name="IsPaymt#RowN#" value="N">										
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
											<CFIF ThisRuleDesc IS "Payment">
												<font face=#Font_Face# size="-2">
													&nbsp;
												</font>
											<CFELSE>
												<font face=#Font_Face# size="-2">
													#ThisRuleNotes#
												</font>
											</CFIF>
										</td>
									</tr>
									--->
								</table>
							</td>
						</tr>
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
