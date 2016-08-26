<CFSET session.Hdr1 = "Club Match Fines" >
<!--- Trick I'm using to suppress any headings --->
<CFSET BatchInput = "No">
<cfinclude template="InclBegin.cfm">

<cfinclude template="InclAuthorityCheck.cfm">

<CFIF ParameterExists(URL.TeamID) IS "No">
	TeamID missing.....aborting
	<CFABORT>
</CFIF>

<cfquery name="QClubName" datasource=#ODBC_DataSource# dbtype="ODBC">
	SELECT
		t.Long as ClubName
	FROM
		Team t
	WHERE
		t.ID = #URL.TeamID#
</cfquery>

<table align="CENTER">
	<tr>

		<td valign="TOP">

			<CFIF ParameterExists(URL.TeamID) IS "Yes"> 

			<CFSET TotalMatchFineAmount = 0 >

				<cfquery name="QMatchFines" datasource=#ODBC_DataSource# dbtype="ODBC">
					SELECT
						t1.long as HomeTeam ,
						t2.long as AwayTeam ,
						o1.long as HomeOrdinal ,
						o2.long as AwayOrdinal ,
						f.FixtureDate ,
						f.HomeGoals ,
						f.AwayGoals ,
						mf.FixtureID ,
						mf.FineDate ,
						mf.PaidDate ,
						mf.Amount ,
						mf.HomeAway ,
						ru.Long as RuleDesc ,
						d.Long as DivName
					FROM
						Fixture f ,
						MatchFine mf ,
						Rule ru ,
						Division d ,
						Constitution c ,
						Constitution c1 ,
						Constitution c2 ,												
						Team t1 ,
						Team t2 ,
						Ordinal o1 ,
						Ordinal o2
					WHERE
						c.TeamID = #URL.TeamID# AND NOT
						ru.Long = 'Checked' AND
						((c.ID = f.HomeID AND mf.HomeAway = 'H') OR (c.ID = f.AwayID AND mf.HomeAway = 'A')) AND
						f.ID = mf.FixtureID AND
						ru.ID = mf.RuleID AND
						d.ID = c.DivisionID AND
						c1.ID = f.HomeID AND
						c2.ID = f.AwayID AND
						t1.ID = c1.TeamID AND
						t2.ID = c2.TeamID AND
						o1.ID = c1.OrdinalID AND
						o2.ID = c2.OrdinalID
					ORDER BY
							f.FixtureDate, d.Medium, mf.FineDate
				</cfquery>
				<CFSET TheColSpan = 4>
				<table border="1" cellspacing="1" cellpadding="3" align="CENTER">
					<CFOUTPUT>
					<tr>
						<td colspan="#TheColSpan#" align="CENTER">
							<font face=#Font_Face# size="+1"><b>#QClubName.ClubName#</b></font>
						</td>
					</tr>

					</cfoutput>
					<cfoutput query="QMatchFines" group="FixtureDate">
						<tr>
							<td colspan="#TheColSpan#">
							<font face=#Font_Face# size="-1">
							<b>Match Date: #DateFormat(FixtureDate, 'DDDD, DD MMM YYYY')#</b>
							</font>
							</td>
						</tr>
						<cfoutput group="DivName">
						<tr>
							<td colspan="#TheColSpan#">
							<font face=#Font_Face# size="-2">
							<b>#DivName#:</b>
							</font>
							
							<CFIF HomeAway IS "H">
								<font face=#Font_Face# size="-2">
									<a href="MatchFineList.cfm?LeagueCode=#LeagueCode#&FID=#FixtureID#&HA=#HomeAway#">#HomeTeam#<CFIF HomeOrdinal IS ""><cfelse> #HomeOrdinal#</cfif></a>
								</font>
							<cfelse>
								<font face=#Font_Face# size="-2">
									#HomeTeam#<CFIF HomeOrdinal IS ""><cfelse> #HomeOrdinal#</cfif>
								</font>
							</cfif>
							 <font face=#Font_Face# size="-2">#HomeGoals# v #AwayGoals#</font>
							<CFIF HomeAway IS "A">
								<font face=#Font_Face# size="-2">
									<a href="MatchFineList.cfm?LeagueCode=#LeagueCode#&FID=#FixtureID#&HA=#HomeAway#">#AwayTeam#<CFIF AwayOrdinal IS ""><cfelse> #AwayOrdinal#</cfif></a>
								</font>
							<cfelse>
								<font face=#Font_Face# size="-2">
									#AwayTeam#<CFIF AwayOrdinal IS ""><cfelse> #AwayOrdinal#</cfif>
								</font>
							</cfif>
							</td>
						</tr>
						<tr>
							<td>
								<font face=#Font_Face# size="-2">
								&nbsp;
								</font>
							</td>
							
							<td align="CENTER">
								<font face=#Font_Face# size="-2">
									fine date
								</font>
							</td>
	
							<td align="CENTER">
								<font face=#Font_Face# size="-2">
									amount
								</font>
							</td>
							
							<td align="CENTER">
								<font face=#Font_Face# size="-2">
									paid date
								</font>
							</td>
	
						</tr>
						<cfoutput>
						<tr>
							<td>
							
							
								<CFIF DateDiff( "D", FineDate, PaidDate ) LT 0 >
											<font face=#Font_Face# size="-2" color="Red" >
												<b>UNPAID</b>
											</font>
											<CFSET OverDueBy = DateDiff( "D", FineDate, Now() )>
											<CFIF OverDueBy GT 0>
												<font face=#Font_Face# size="-2" color="Red" >
													<b>for #OverDueBy# days</b>
												</font>
											</cfif>
								<BR>							
								</cfif>
							
							
							<font face=#Font_Face# size="-2">
							#RuleDesc#
							</font>
							</td>

							<td>
							<font face=#Font_Face# size="-2">
							#DateFormat(FineDate, "DD MMM YYYY")#
							</font>
							</td>
							
							<CFSET TotalMatchFineAmount = TotalMatchFineAmount + Amount>
							<td align="RIGHT">
							<font face=#Font_Face# size="-2">
							&pound; #NumberFormat(Amount, "9,999.99")#
							</font>
							</td>
							
							
							<td>
							<font face=#Font_Face# size="-2">
							#DateFormat(PaidDate, "DD MMM YYYY")#
							</font>
							</td>
							
							
							
						</tr>
						</cfoutput>
						
						
						</cfoutput>
						
					</cfoutput>
					

					<tr>
						<td height="30" align="RIGHT" valign="MIDDLE">
						<cfoutput>
						<font face=#Font_Face# size="-2">
						<b>Total</b>
						</font>
						</td>
				
						<td height="30" align="RIGHT" valign="MIDDLE">
						<font face=#Font_Face# size="-2">
						<b>&pound; #NumberFormat(TotalMatchFineAmount, "9,999.99")#</b>
						</font>
						</cfoutput>
						</td>
					</tr>
					
				</table>
			</cfif>
		</td>
	</tr>
	
	
	
	
	
	
</table>


