<CFPARAM name="MatchReportHeading" default="#RepeatString("Not allowed - choose a match first!#CHR(10)#", 20)#" >
<CFPARAM name="MatchReportNo" default="0">
<link href="/fmstyle.css" rel="stylesheet" type="text/css">

<table width="100%" border="0" cellpadding="5" cellspacing="5" class="loggedinScreen">
<cfif TblName IS "Team" AND NewRecord IS "No">
	<!---
	FACharterStandardType 
	
	Unspecified = 0
	FA Charter Standard Club (Adult) = 1
	FA Charter Standard Club (Youth) = 2
	FA Charter Standard Development Club = 3
	FA Charter Standard Community Club = 4
	not FA Charter Standard = 9
	--->

	<cfif GetTblName.FACharterStandardType IS 1 >
		<tr>
			<td align="left">
			</td>
			<td align="left">
				<table border="1" cellpadding="5" cellspacing="0" >
					<tr>
						<td bgcolor="white">
						<img src="images/Charter Standard Adult Club Logo tiny.jpg">
						</td>
					</tr>
				</table>
			</td>
		</tr>
	<cfelseif GetTblName.FACharterStandardType IS 2 >
		<tr>
			<td align="left">
			</td>
			<td align="left">
				<table border="1" cellpadding="5" cellspacing="0" >
					<tr>
						<td bgcolor="white">
						<img src="images/Charter Standard Youth Club Logo tiny.jpg">
						</td>
					</tr>
				</table>
			</td>
		</tr>
	<cfelseif GetTblName.FACharterStandardType IS 3 >
		<tr>
			<td align="left">
			</td>
			<td align="left">
				<table border="1" cellpadding="5" cellspacing="0" >
					<tr>
						<td bgcolor="white">
							<img src="images/Charter Standard Development Club Logo tiny.jpg"><br>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	<cfelseif GetTblName.FACharterStandardType IS 4 >
		<tr>
			<td align="left">
			</td>
			<td align="left">
				<table border="1" cellpadding="5" cellspacing="0" >
					<tr>
						<td bgcolor="white">
							<img src="images/Charter Standard Community Club Logo tiny.jpg"><br>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		
	</cfif>
</cfif>

<!--- LongCol description --->
	<tr align="left">
		<td valign="middle" align="left">
			<CFSWITCH expression="#TblName#">
				<CFCASE VALUE="Referee">
					<cfif NewRecord IS "No">
						<table border="1" cellpadding="5" cellspacing="0">
							<tr><td bgcolor="white"><span class="pix13bold">This is what the public sees -----></span></td></tr>
						</table>
					</cfif>
				</CFCASE>
				<CFCASE VALUE="NewsItem">
					<span class="pix10navy">Headline e.g. <strong>Cup Success</strong> <br />Use <strong>NOTICE</strong> to broadcast a message on every page</span>
				</CFCASE>
				<CFCASE VALUE="Division">
					<span class="pix10navy">Competition Name e.g. <strong>Division One</strong> or <strong>League Cup</strong></span>
				</CFCASE>
				<CFCASE VALUE="KORound">
					<span class="pix10navy">Knock Out Round Name e.g. <strong>Quarter Final</strong> or <strong>Round 1 - Replay</strong></span>
				</CFCASE>
				<CFCASE VALUE="Ordinal">
					<span class="pix10navy">(i) Description of Team e.g.<strong>Reserves</strong> OR (ii) <em>Winners of match</em> ID e.g. <strong>LgCup</strong></span>
				</CFCASE>
				<CFCASE VALUE="Team">
					<span class="pix10navy">Club Name only WITHOUT suffix e.g. <strong>Exeter City</strong> NOT <strong>Exeter City Reserves</strong></span>
				</CFCASE>
				<CFCASE VALUE="Player">
					<span class="pix10navy">Surname Forenames e.g. <strong>Smith John Arthur</strong></span>
				</CFCASE>
				<CFCASE VALUE="Venue">
					<span class="pix10navy">Name of the Ground e.g. <strong>North Acton Playing Fields</strong></span>
				</CFCASE>

				<CFCASE VALUE="MatchReport">
				</CFCASE>
				<CFCASE VALUE="Rule">
					<span class="pix10navy">Rule Description e.g. <strong>Shirts not clearly numbered</strong></span>
				</CFCASE>
				<CFCASE VALUE="Noticeboard">
				</CFCASE>
				<CFCASE VALUE="Document">
				</CFCASE>
				<CFDEFAULTCASE>
					<span class="pix10navy">LongCol</span>
				</CFDEFAULTCASE>
					
			</CFSWITCH>
		</td>
<!--- LongCol Data --->
		<td align="left">
			<CFSWITCH expression="#TblName#">
				<CFCASE VALUE="MatchReport">
					<cfif NewRecord IS "Yes">
						<input type="hidden" name="LongCol" value=<cfoutput>"#MatchReportNo#"</cfoutput> >
					<cfelse>
						<input type="hidden" name="LongCol" value=<cfoutput>"#GetTblName.ShortCol#"</cfoutput> >
					</cfif>
				</CFCASE>
				<CFCASE VALUE="Noticeboard">
				</CFCASE>
				<CFCASE VALUE="Document">
				</CFCASE>
				<CFCASE VALUE="Referee">
					<cfif NewRecord IS "Yes">
					<cfelse>
						<table border="1" cellpadding="5" cellspacing="0">
							<tr>
							<td bgcolor="white">
								<cfif trim(GetTblName.MediumCol) IS "">
									<cfoutput><span class="pix13bold">#GetTblName.RefsName#</span></cfoutput>
								<cfelse>
									<cfoutput><span class="pix13bold">#GetTblName.MediumCol#</span></cfoutput>
								</cfif>
							</td>
							</tr>
						</table>

					</cfif>
				</CFCASE>
				
				<CFDEFAULTCASE>
						<input type="Text" name="LongCol" size="50" maxlength="50"	<cfif NewRecord IS "No">VALUE=<cfoutput>"#GetTblName.LongCol#"</cfoutput></cfif> >
				</CFDEFAULTCASE>	
			</CFSWITCH>
			
			<cfif TblName IS "Team">
				<table border="1" cellpadding="2" cellspacing="0">
					<cfif NewRecord IS "Yes">
					<cfelse>
						<!---
						FACharterStandardType 
						
						Unspecified = 0
						FA Charter Standard Club (Adult) = 1
						FA Charter Standard Club (Youth) = 2
						FA Charter Standard Development Club = 3
						FA Charter Standard Community Club = 4
						not FA Charter Standard = 9
						--->

						<tr>
							<td align="left"><span class="pix10bold">FA Charter<br>Standard?</span></td>
							<cfif GetTblName.FACharterStandardType IS 0 >
								<td align="center" bgcolor="white"><span class="pix10bold">Unspecified</span><br><input type="radio" name="FACharterStandardType" value=0 checked></td>
							<cfelse>
								<td align="center"><span class="pix10">Unspecified</span><br><input type="radio" name="FACharterStandardType" value=0></td>
							</cfif>
							<cfif GetTblName.FACharterStandardType IS 1 >
								<td align="center" bgcolor="white"><span class="pix10bold">Adult</span><br><input type="radio" name="FACharterStandardType" value=1 checked></td>
							<cfelse>
								<td align="center"><span class="pix10">Adult</span><br><input type="radio" name="FACharterStandardType" value=1></td>
							</cfif>
							<cfif GetTblName.FACharterStandardType IS 2 >
								<td align="center" bgcolor="white"><span class="pix10bold">Youth</span><br><input type="radio" name="FACharterStandardType" value=2 checked></td>
							<cfelse>
								<td align="center"><span class="pix10">Youth</span><br><input type="radio" name="FACharterStandardType" value=2></td>
							</cfif>
							<cfif GetTblName.FACharterStandardType IS 3 >
								<td align="center" bgcolor="white"><span class="pix10bold">Development</span><br><input type="radio" name="FACharterStandardType" value=3 checked></td>
							<cfelse>
								<td align="center"><span class="pix10">Development</span><br><input type="radio" name="FACharterStandardType" value=3></td>
							</cfif>
							<cfif GetTblName.FACharterStandardType IS 4 >
								<td align="center" bgcolor="white"><span class="pix10bold">Community</span><br><input type="radio" name="FACharterStandardType" value=4 checked></td>
							<cfelse>
								<td align="center"><span class="pix10">Community</span><br><input type="radio" name="FACharterStandardType" value=4></td>
							</cfif>
							<cfif GetTblName.FACharterStandardType IS 9 >
								<td align="center" bgcolor="white"><span class="pix10bold">No</span><br><input type="radio" name="FACharterStandardType" value=9 checked></td>
							<cfelse>
								<td align="center"><span class="pix10">No</span><br><input type="radio" name="FACharterStandardType" value=9></td>
							</cfif>
							<td align="left"><span class="pix10bold">Parent<br>County FA</span></td>
							<td align="left"><span class="pix10bold"><input name="ParentCountyFA" size="10" maxlength="30" type="text" <cfif NewRecord IS "No">VALUE=<cfoutput>"#GetTblName.ParentCountyFA#"</cfoutput></cfif> >
							<td align="left"><span class="pix10bold">Affiliation<br>Number</span></td>
							<td align="left"><span class="pix10bold"><input name="AffiliationNo"  size="10" maxlength="10" type="text" <cfif NewRecord IS "No">VALUE=<cfoutput>"#GetTblName.AffiliationNo#"</cfoutput></cfif> >
						</tr>
					</cfif>
				</table>
			</cfif>
		</td>

	</tr>
	
	
	<cfif TblName IS "Referee"> 
<!-- extra row for Surname--->
		<tr>
			<td align="left" valign="middle"><span class="pix10navy">Surname<cfif ListFind("Yellow",request.SecurityLevel) ><br>This is read only. Contact the league if spelling is incorrect.</cfif></span></td>
			<td align="left">
				<cfif NewRecord IS "No">
					<input <cfif ListFind("Yellow",request.SecurityLevel) >readonly</cfif> type="Text" name="Surname" size="20" maxlength="20" VALUE=<cfoutput>"#GetTblName.Surname#"</cfoutput> >
				<cfelse>
					<input <cfif ListFind("Yellow",request.SecurityLevel) >readonly</cfif> type="Text" name="Surname" size="20" maxlength="20"  >
				</cfif>
			</td>
		</tr>
<!-- extra row for Forename--->
		<tr>
			<td align="left" valign="middle"><span class="pix10navy">Forenames<cfif ListFind("Yellow",request.SecurityLevel) ><br>This is read only. Contact the league if spelling is incorrect.</cfif></span></td>
			<td align="left">
				<cfif NewRecord IS "No">
					<input <cfif ListFind("Yellow",request.SecurityLevel) >readonly</cfif> type="Text" name="Forename" size="30" maxlength="30" VALUE=<cfoutput>"#GetTblName.Forename#"</cfoutput> >
				<cfelse>
					<input <cfif ListFind("Yellow",request.SecurityLevel) >readonly</cfif> type="Text" name="Forename" size="30" maxlength="30"  >
				</cfif>
			</td>
		</tr>
	</cfif>
	<cfif TblName IS "Committee"> 
<!-- extra row for Surname--->
		<tr>
			<td align="left" valign="middle"><span class="pix10navy">Surname</span></td>
			<td align="left">
				<cfif NewRecord IS "No">
					<input type="Text" name="Surname" size="20" maxlength="20" VALUE=<cfoutput>"#GetTblName.Surname#"</cfoutput> >
				<cfelse>
					<input type="Text" name="Surname" size="20" maxlength="20"  >
				</cfif>
			</td>
		</tr>
<!-- extra row for Forename--->
		<tr>
			<td align="left" valign="middle"><span class="pix10navy">Forenames</span></td>
			<td align="left">
				<cfif NewRecord IS "No">
					<input type="Text" name="Forename" size="30" maxlength="30" VALUE=<cfoutput>"#GetTblName.Forename#"</cfoutput> >
				<cfelse>
					<input type="Text" name="Forename" size="30" maxlength="30"  >
				</cfif>
			</td>
		</tr>
	</cfif>


<!--- MediumCol description --->
 	<tr>
		<td align="left">
			<CFSWITCH expression="#TblName#">
				<CFCASE VALUE="Referee">
					<cfif ListFind("Yellow",request.SecurityLevel) >
						<!--- suppress for Yellow security level --->
					<cfelse>
						<table border="1" cellpadding="5" cellspacing="0">
							<tr>
								<td bgcolor="white"><span class="pix10navy">Leave this box empty to get Initial & Surname<br />
								otherwise enter what you want the public to see</span></td>
								<td bgcolor="white"><span class="pix13y">------></td> 
							</tr>
						</table>
					</cfif>
				</CFCASE>
				<CFCASE VALUE="NewsItem">
					<span class="pix10navy">Numeric Sort Order between <strong>1</strong> and <strong>99</strong> (leave empty for NOTICE)</span>
				</CFCASE>
				<CFCASE VALUE="Committee">
					<span class="pix10navy">Name e.g. <strong>John Smith</strong></span>
				</CFCASE>
				<CFCASE VALUE="Division">
					<span class="pix10navy">Sort order e.g. <strong>0010</strong></span>
				</CFCASE>
				<CFCASE VALUE="KORound">
					<span class="pix10navy">Sort order e.g. <strong>0010</strong> MUST be in logical ascending sequence 
					in competition<BR>e.g. <strong>Prelim</strong> before <strong>Round</strong> 1 before <strong>Round 2</strong>...etc...<strong>Final</strong> is last</span>
				</CFCASE>
				<CFCASE VALUE="Ordinal">
					<span class="pix10navy">(i) leave empty OR (ii) <strong>KO</strong></span>
				</CFCASE>
				<CFCASE VALUE="Team">
					<span class="pix10navy">Abbreviation used in Results Grid headings</span>
				</CFCASE>
				<CFCASE VALUE="Player">
					<span class="pix13boldred">NEW FORMAT!</span><span class="pix10navy"> Date of Birth e.g. <strong>1978-02-27</strong> (yyyy-mm-dd)</span>
				</CFCASE>
				<CFCASE VALUE="MatchReport">
				</CFCASE>
				<CFCASE VALUE="Rule">
					<span class="pix10navy">Handbook Reference No.</span>
				</CFCASE>
				<CFCASE VALUE="Noticeboard">
				</CFCASE>
				<CFCASE VALUE="Document">
				</CFCASE>
				<CFCASE VALUE="Venue">
					<!---      <span class="pix10navy">Abbreviation e.g. <strong>N Acton</strong></span>        --->
				</CFCASE>
				
				<CFDEFAULTCASE>
					<span class="pix10navy">MediumCol</span>
				</CFDEFAULTCASE>	
			</CFSWITCH>
		</td>
<!--- MediumCol data --->
		<td align="left">
			<CFSWITCH expression="#TblName#">
				<CFCASE VALUE="MatchReport">
					<cfif NewRecord IS "Yes">
						<input type="hidden" name="MediumCol" value=<cfoutput>"#MatchReportNo#"</cfoutput> >
					<cfelse>
						<input type="hidden" name="MediumCol" value=<cfoutput>"#GetTblName.MediumCol#"</cfoutput> >
					</cfif>
				</CFCASE>
				<CFCASE VALUE="Player">
					<cfif NewRecord IS "Yes">
						<input type="Text" name="MediumCol" size="10" maxlength="10">
					<cfelse>
						<input type="Text" name="MediumCol" size="10" maxlength="10" 
						VALUE=<cfoutput>"#DateFormat(GetTblName.MediumCol, 'yyyy-mm-dd')#"</cfoutput>>
						<cfoutput><span class="pix10grey">#DateFormat(GetTblName.MediumCol, 'dd mmmm yyyy')#</span></cfoutput>
						
					</cfif>
				</CFCASE>
				<CFCASE VALUE="Rule">
					<cfif NewRecord IS "Yes">
						<input type="Text" name="MediumCol"  size="20" maxlength="20">
					<cfelse>
						<input type="Text" name="MediumCol"  size="20" maxlength="20" VALUE=<cfoutput>"#GetTblName.MediumCol#"</cfoutput> >
					</cfif>	
				</CFCASE>
				<CFCASE VALUE="Committee">
					<cfif NewRecord IS "Yes">
						<input type="Text" name="MediumCol"  size="30" maxlength="30">
					<cfelse>
						<input type="Text" name="MediumCol"  size="30" maxlength="30" VALUE=<cfoutput>"#GetTblName.MediumCol#"</cfoutput>	>
					</cfif>
				</CFCASE>
				<CFCASE VALUE="Noticeboard">
				</CFCASE>
				<CFCASE VALUE="Document">
				</CFCASE>

				<CFCASE VALUE="Venue">
					<cfif NewRecord IS "Yes">
						<input type="hidden" name="MediumCol" value="" >
					<cfelse>
						<input type="hidden" name="MediumCol" value=<cfoutput>"#GetTblName.MediumCol#"</cfoutput> >
					</cfif>
				</CFCASE>
				<CFCASE VALUE="Referee">
					<cfif ListFind("Yellow",request.SecurityLevel) >
						<!--- suppress for Yellow security level --->
					<cfelse>
						<cfif NewRecord IS "Yes">
							<input type="Text" name="MediumCol" size="20" maxlength="20">
						<cfelse>
							<input type="Text" name="MediumCol" size="20" maxlength="20" VALUE=<cfoutput>"#GetTblName.MediumCol#"</cfoutput>>
						</cfif>
					</cfif>
				</CFCASE>
				
				<CFDEFAULTCASE>
					<cfif NewRecord IS "Yes">
						<input type="Text" name="MediumCol" size="20" maxlength="20">
					<cfelse>
						<input type="Text" name="MediumCol" size="20" maxlength="20" VALUE=<cfoutput>"#GetTblName.MediumCol#"</cfoutput>>
					</cfif>
				</CFDEFAULTCASE>	
			</CFSWITCH>
		</td>
	</tr>
<!--- ShortCol description --->
	<tr>
		<td align="left">
			<CFSWITCH expression="#TblName#">
				<CFCASE VALUE="Referee">
					<cfif ListFind("Yellow",request.SecurityLevel) >
						<!--- suppress for Yellow security level --->
					<cfelse>
						<span class="pix10navy">Sort order (Optional)</span>
					</cfif>
				</CFCASE>
				<CFCASE VALUE="NewsItem">
					<span class="pix10navy"><strong>HIDE</strong> or leave empty.</span>
				</CFCASE>
				<CFCASE VALUE="Division">
					<span class="pix10navy">Competition Code e.g. <strong>Div1</strong> or <strong>LgCup</strong></span>
				</CFCASE>
				<CFCASE VALUE="KORound">
					<span class="pix10navy">Not used, leave empty</span>
				</CFCASE>
				<CFCASE VALUE="Ordinal">
					<span class="pix10navy">Abbreviation used in Results Grid headings</span>
				</CFCASE>
				<CFCASE VALUE="Team">
					<span class="pix10navy">Enter <strong>GUEST</strong> if the club is not in this league</span>
				</CFCASE>
				<CFCASE VALUE="MatchReport">
				</CFCASE>
				<CFCASE VALUE="Rule">
					<span class="pix10navy">Fine Amount</span>
				</CFCASE>
				<CFCASE VALUE="Noticeboard">
				</CFCASE>
				<CFCASE VALUE="Document">
				</CFCASE>
				<CFCASE VALUE="Venue">
					<!---        <span class="pix10navy">Sort order (Optional)</span>       --->
				</CFCASE>
				<CFDEFAULTCASE>
					<span class="pix10navy">ShortCol</span>
				</CFDEFAULTCASE>	
			</CFSWITCH>
		</td>
<!--- ShortCol data --->
		
			<CFSWITCH expression="#TblName#">
				<CFCASE VALUE="MatchReport">
					<cfif NewRecord IS "Yes">
						<td align="left"><input type="hidden" name="ShortCol" value=<cfoutput>"#MatchReportNo#"</cfoutput> ></td>
					<cfelse>
						<td align="left"><input type="hidden" name="ShortCol" value=<cfoutput>"#GetTblName.ShortCol#"</cfoutput> ></td>
					</cfif>
				</CFCASE>
				<CFCASE VALUE="Rule">
					<cfif NewRecord IS "Yes">
						<td align="left"><input type="Text" size="6" name="ShortCol" value="0.00" ></td>
					<cfelse>
						<td align="left"><input name="ShortCol" type="text" value=<cfoutput>"#NumberFormat(GetTblName.ShortCol, 'L99999.99')#"</cfoutput> size="6"></td>
					</cfif>
				</CFCASE>
				
				<CFCASE VALUE="Noticeboard">
					<td align="left"></td>
				</CFCASE>
				<CFCASE VALUE="Document">
					<td align="left"></td>
				</CFCASE>
				
				<CFCASE VALUE="Venue">
					<cfif NewRecord IS "Yes">
						<td align="left"><input type="hidden" name="ShortCol" value="" ></td>
					<cfelse>
						<td align="left"><input type="hidden" name="ShortCol" value=<cfoutput>"#GetTblName.ShortCol#"</cfoutput> ></td>
					</cfif>
				</CFCASE>
				
				<CFCASE VALUE="Referee">
					<cfif ListFind("Yellow",request.SecurityLevel) >
						<!--- suppress for Yellow security level --->
					<cfelse>
						<cfif NewRecord IS "Yes">
							<td align="left"><input type="Text" name="ShortCol" size="5" maxlength="5"></td>
						<cfelse>
							<td align="left"><input type="Text" name="ShortCol" size="5" maxlength="5" VALUE="<cfoutput>#GetTblName.ShortCol#</cfoutput>"></td>
						</cfif>
					</cfif>
				</CFCASE>
				
				<CFDEFAULTCASE>
					<cfif NewRecord IS "Yes">
						<td align="left"><input type="Text" name="ShortCol" size="5" maxlength="5"></td>
					<cfelse>
						<td align="left"><input type="Text" name="ShortCol" size="5" maxlength="5" VALUE="<cfoutput>#GetTblName.ShortCol#</cfoutput>"></td>
					</cfif>
				</CFDEFAULTCASE>
			</CFSWITCH>
		
	</tr>
	
	<cfif TblName IS "Venue"> 
<!-- Address Line 1 --->
		<tr>
			<td valign="middle" align="left"><span class="pix10navy">Address Line 1</span></td>
			<td align="left">
				<cfif NewRecord IS "No">
					<input type="Text" name="AddressLine1" size="40" maxlength="40" VALUE=<cfoutput>"#GetTblName.AddressLine1#"</cfoutput> >
				<cfelse>
					<input type="Text" name="AddressLine1" size="40" maxlength="40"  >
				</cfif>
			</td>
		</tr>
<!-- Address Line 2 --->
		<tr>
			<td valign="middle" align="left"><span class="pix10navy">Address Line 2</span></td>
			<td align="left">
				<cfif NewRecord IS "No">
					<input type="Text" name="AddressLine2" size="40" maxlength="40" VALUE=<cfoutput>"#GetTblName.AddressLine2#"</cfoutput> >
				<cfelse>
					<input type="Text" name="AddressLine2" size="40" maxlength="40"  >
				</cfif>
			</td>
		</tr>
<!-- Address Line 3 --->
		<tr>
			<td valign="middle" align="left"><span class="pix10navy">Address Line 3</span></td>
			<td align="left">
				<cfif NewRecord IS "No">
					<input type="Text" name="AddressLine3" size="40" maxlength="40" VALUE=<cfoutput>"#GetTblName.AddressLine3#"</cfoutput> >
				<cfelse>
					<input type="Text" name="AddressLine3" size="40" maxlength="40"  >
				</cfif>
			</td>
		</tr>
<!-- PostCode --->
		<tr>
			<td valign="middle" align="left"><span class="pix10navy">PostCode</span></td>
			<td align="left">
				<cfif NewRecord IS "No">
					<input type="Text" name="PostCode" size="10" maxlength="10" VALUE=<cfoutput>"#GetTblName.PostCode#"</cfoutput> >
				<cfelse>
					<input type="Text" name="PostCode" size="10" maxlength="10"  >
				</cfif>
			</td>
		</tr>
<!-- Venue Telephone  --->
		<tr>
			<td valign="middle" align="left"><span class="pix10navy">Venue Telephone</span></td>
			<td align="left">
				<cfif NewRecord IS "No">
					<input type="Text" name="VenueTel" size="20" maxlength="20" VALUE=<cfoutput>"#GetTblName.VenueTel#"</cfoutput> >
				<cfelse>
					<input type="Text" name="VenueTel" size="20" maxlength="20"  >
				</cfif>
			</td>
		</tr>
<!-- Map URL  --->
		<tr>
			<td valign="middle" align="left"><span class="pix10navy">Map URL<br /><strong>Please <a href="InstructionsVenueMapLink2.htm" target="_blank">click here</a> for instructions.</strong></span></td>
			<td align="left">
				<cfif NewRecord IS "No">
					<input type="Text" name="MapURL" size="100" maxlength="255" VALUE=<cfoutput>"#GetTblName.MapURL#"</cfoutput> >
				<cfelse>
					<input type="Text" name="MapURL" size="100" maxlength="255"  >
				</cfif>
			</td>
		</tr>
<!-- Compass Point Location --->
		<tr>
			<td align="left"><span class="pix10navy">Location within League Area</span></td>
			<td align="left">
				<cfif NewRecord IS "No">
					
					<CFSWITCH expression="#GetTblName.CompassPoint#">
					
						<CFCASE VALUE=1>
							<select name="CompassPoint" size="1" >
								<OPTION VALUE=1 selected>Central</OPTION>
								<OPTION VALUE=2 >North</OPTION>
								<OPTION VALUE=3 >North East</OPTION>
								<OPTION VALUE=4 >East</OPTION>
								<OPTION VALUE=5 >South East</OPTION>
								<OPTION VALUE=6 >South</OPTION>
								<OPTION VALUE=7 >South West</OPTION>
								<OPTION VALUE=8 >West</OPTION>
								<OPTION VALUE=9 >North West</OPTION>
							</select>
							<img src="gif/CompassGridC.gif" width="90" height="90" border="0" align="absmiddle">
						</CFCASE>
						<CFCASE VALUE=2>
							<select name="CompassPoint" size="1" >
								<OPTION VALUE=1 >Central</OPTION>
								<OPTION VALUE=2 selected>North</OPTION>
								<OPTION VALUE=3 >North East</OPTION>
								<OPTION VALUE=4 >East</OPTION>
								<OPTION VALUE=5 >South East</OPTION>
								<OPTION VALUE=6 >South</OPTION>
								<OPTION VALUE=7 >South West</OPTION>
								<OPTION VALUE=8 >West</OPTION>
								<OPTION VALUE=9 >North West</OPTION>
							</select>
							<img src="gif/CompassGridN.gif" width="90" height="90" border="0" align="absmiddle">
						</CFCASE>
						<CFCASE VALUE=3>
							<select name="CompassPoint" size="1" >
								<OPTION VALUE=1 >Central</OPTION>
								<OPTION VALUE=2 >North</OPTION>
								<OPTION VALUE=3 selected>North East</OPTION>
								<OPTION VALUE=4 >East</OPTION>
								<OPTION VALUE=5 >South East</OPTION>
								<OPTION VALUE=6 >South</OPTION>
								<OPTION VALUE=7 >South West</OPTION>
								<OPTION VALUE=8 >West</OPTION>
								<OPTION VALUE=9 >North West</OPTION>
							</select>
							<img src="gif/CompassGridNE.gif" width="90" height="90" border="0" align="absmiddle">
						</CFCASE>
						<CFCASE VALUE=4>
							<select name="CompassPoint" size="1" >
								<OPTION VALUE=1 >Central</OPTION>
								<OPTION VALUE=2 >North</OPTION>
								<OPTION VALUE=3 >North East</OPTION>
								<OPTION VALUE=4 selected>East</OPTION>
								<OPTION VALUE=5 >South East</OPTION>
								<OPTION VALUE=6 >South</OPTION>
								<OPTION VALUE=7 >South West</OPTION>
								<OPTION VALUE=8 >West</OPTION>
								<OPTION VALUE=9 >North West</OPTION>
							</select>
							<img src="gif/CompassGridE.gif" width="90" height="90" border="0" align="absmiddle">
						</CFCASE>
						<CFCASE VALUE=5>
							<select name="CompassPoint" size="1" >
								<OPTION VALUE=1 >Central</OPTION>
								<OPTION VALUE=2 >North</OPTION>
								<OPTION VALUE=3 >North East</OPTION>
								<OPTION VALUE=4 >East</OPTION>
								<OPTION VALUE=5 selected>South East</OPTION>
								<OPTION VALUE=6 >South</OPTION>
								<OPTION VALUE=7 >South West</OPTION>
								<OPTION VALUE=8 >West</OPTION>
								<OPTION VALUE=9 >North West</OPTION>
							</select>
							<img src="gif/CompassGridSE.gif" width="90" height="90" border="0" align="absmiddle">
						</CFCASE>
						<CFCASE VALUE=6>
							<select name="CompassPoint" size="1" >
								<OPTION VALUE=1 >Central</OPTION>
								<OPTION VALUE=2 >North</OPTION>
								<OPTION VALUE=3 >North East</OPTION>
								<OPTION VALUE=4 >East</OPTION>
								<OPTION VALUE=5 >South East</OPTION>
								<OPTION VALUE=6 selected>South</OPTION>
								<OPTION VALUE=7 >South West</OPTION>
								<OPTION VALUE=8 >West</OPTION>
								<OPTION VALUE=9 >North West</OPTION>
							</select>
							<img src="gif/CompassGridS.gif" width="90" height="90" border="0" align="absmiddle">
						</CFCASE>
						<CFCASE VALUE=7>
							<select name="CompassPoint" size="1" >
								<OPTION VALUE=1 >Central</OPTION>
								<OPTION VALUE=2 >North</OPTION>
								<OPTION VALUE=3 >North East</OPTION>
								<OPTION VALUE=4 >East</OPTION>
								<OPTION VALUE=5 >South East</OPTION>
								<OPTION VALUE=6 >South</OPTION>
								<OPTION VALUE=7 selected>South West</OPTION>
								<OPTION VALUE=8 >West</OPTION>
								<OPTION VALUE=9 >North West</OPTION>
							</select>
							<img src="gif/CompassGridSW.gif" width="90" height="90" border="0" align="absmiddle">
						</CFCASE>
						<CFCASE VALUE=8>
							<select name="CompassPoint" size="1" >
								<OPTION VALUE=1 >Central</OPTION>
								<OPTION VALUE=2 >North</OPTION>
								<OPTION VALUE=3 >North East</OPTION>
								<OPTION VALUE=4 >East</OPTION>
								<OPTION VALUE=5 >South East</OPTION>
								<OPTION VALUE=6 >South</OPTION>
								<OPTION VALUE=7 >South West</OPTION>
								<OPTION VALUE=8 selected>West</OPTION>
								<OPTION VALUE=9 >North West</OPTION>
							</select>
							<img src="gif/CompassGridW.gif" width="90" height="90" border="0" align="absmiddle">
						</CFCASE>
						<CFCASE VALUE=9>
							<select name="CompassPoint" size="1" >
								<OPTION VALUE=1 >Central</OPTION>
								<OPTION VALUE=2 >North</OPTION>
								<OPTION VALUE=3 >North East</OPTION>
								<OPTION VALUE=4 >East</OPTION>
								<OPTION VALUE=5 >South East</OPTION>
								<OPTION VALUE=6 >South</OPTION>
								<OPTION VALUE=7 >South West</OPTION>
								<OPTION VALUE=8 >West</OPTION>
								<OPTION VALUE=9 selected>North West</OPTION>
							</select>
							<img src="gif/CompassGridNW.gif" width="90" height="90" border="0" align="absmiddle">
						</CFCASE>
						<CFDEFAULTCASE>
							error CFSWITCH expression=GetTblName.CompassPoint
							<CFABORT>
						</CFDEFAULTCASE>
					</cfswitch>						
					
				<cfelse>
					<select name="CompassPoint" size="1" >
							<OPTION VALUE=1>Central</OPTION>
							<OPTION VALUE=2>North</OPTION>
							<OPTION VALUE=3>North East</OPTION>
							<OPTION VALUE=4>East</OPTION>
							<OPTION VALUE=5>South East</OPTION>
							<OPTION VALUE=6>South</OPTION>
							<OPTION VALUE=7>South West</OPTION>
							<OPTION VALUE=8>West</OPTION>
							<OPTION VALUE=9>North West</OPTION>
					</select>
					<img src="gif/CompassGrid.gif" width="90" height="90" border="0" align="absmiddle">
				</cfif>
				
				
			</td>
			
		</tr>
	</cfif>
	
	
	<cfif TblName IS "Referee"> 
	
<!-- Date of Birth --->
		<tr>
			<td align="left">
				<span class="pix10navy"> Date of Birth:
					<cfif NewRecord IS "No" and IsDate(GetTblName.DateOfBirth) >
						<cfoutput>
							<strong>#DateFormat(GetTblName.DateOfBirth, 'dd mmmm yyyy')#</strong> Age:<strong>#DateDiff("YYYY",GetTblName.DateOfBirth,Now())#</strong>
						</cfoutput>
					</cfif>
				</span>
			</td>
		
		<cfif NewRecord IS "Yes">
			<td align="left">
				<table>
					<tr>
						<td align="left"><cfinput name="DOB_DD"    type="text"  size="1" maxlength="2" range="1,31" required="no" message="Day must be numeric in range 01 to 31" validate="integer">&nbsp;&nbsp;</td>
						<td align="left"><cfinput name="DOB_MM"    type="text"  size="1" maxlength="2" range="1,12" required="no" message="Month must be numeric in range 01 to 12" validate="integer">&nbsp;&nbsp;</td>
						<td align="left"><cfinput name="DOB_YYYY"  type="text"  size="4" maxlength="4" range="1900,#YEAR(Now())-7#" validate="integer" message="Year must be numeric in range 1900 to #YEAR(Now())-7#"></td>
					</tr>
					<tr>
						<td align="left"><span class="pix10navy">dd</span></td>
						<td align="left"><span class="pix10navy">mm</span></td>
						<td align="left"><span class="pix10navy">yyyy</span></td>
					</tr>
				</table>
			</td>
		<cfelse>
			<td align="left">
				<table>
					<tr>
						<td align="left"><cfinput name="DOB_DD"    type="text"    value="#DateFormat(GetTblName.DateOfBirth, 'DD')#" size="1" maxlength="2" range="1,31" required="no" message="Day must be numeric in range 01 to 31" validate="integer">&nbsp;&nbsp;</td>
						<td align="left"><cfinput name="DOB_MM"    type="text"    value="#DateFormat(GetTblName.DateOfBirth, 'MM')#" size="1" maxlength="2" range="1,12" required="no" message="Month must be numeric in range 01 to 12" validate="integer">&nbsp;&nbsp;</td>
						<td align="left"><cfinput name="DOB_YYYY"  type="text"    value="#DateFormat(GetTblName.DateOfBirth, 'YYYY')#" size="4" maxlength="4" range="1900,#YEAR(Now())-7#" validate="integer" message="Year must be numeric in range 1900 to #YEAR(Now())-7#"></td>
					</tr>
					<tr>
						<td align="left"><span class="pix10navy">dd</span></td>
						<td align="left"><span class="pix10navy">mm</span></td>
						<td align="left"><span class="pix10navy">yyyy</span></td>
					</tr>
				</table>
			</td>
		</cfif>
		</tr>
<!-- FAN --->
		<tr>
			<td align="left" valign="middle"><span class="pix10navy">FAN</span></td>
			<td align="left">
				<cfif NewRecord IS "No">
					<input type="Text" name="FAN" size="10" maxlength="10" VALUE=<cfoutput>"#GetTblName.FAN#"</cfoutput> >
				<cfelse>
					<input type="Text" name="FAN" size="10" maxlength="10"  >
				</cfif>
			</td>
		</tr>
<!-- Parent County --->
		<tr>
			<td align="left" valign="middle"><span class="pix10navy">Parent County</span></td>
			<td align="left">
				<cfif NewRecord IS "No">
					<input type="Text" name="ParentCounty" size="20" maxlength="20" VALUE=<cfoutput>"#GetTblName.ParentCounty#"</cfoutput> >
				<cfelse>
					<input type="Text" name="ParentCounty" size="20" maxlength="20"  >
				</cfif>
			</td>
		</tr>
<!-- Address Block --->
		<tr>
			<td align="left" valign="middle"><span class="pix10navy">Address</span></td>
			<td align="left">
				<table border="0" cellpadding="0" cellspacing="0" <cfif NewRecord IS "No" AND GetTblName.ShowHideAddress IS 1>bgcolor="silver"<cfelse>bgcolor="lightblue"</cfif> >
				<!-- Address Line 1 --->
						<tr>
							<td align="left" valign="middle"><span class="pix10navy">Line 1</span></td>
							<td align="left">
								<cfif NewRecord IS "No">
									<input type="Text" name="AddressLine1" size="40" maxlength="40" VALUE=<cfoutput>"#GetTblName.AddressLine1#"</cfoutput> >
								<cfelse>
									<input type="Text" name="AddressLine1" size="40" maxlength="40"  >
								</cfif>
							</td>
						</tr>
				<!-- Address Line 2 --->
						<tr>
							<td align="left" valign="middle"><span class="pix10navy">Line 2</span></td>
							<td align="left">
								<cfif NewRecord IS "No">
									<input type="Text" name="AddressLine2" size="40" maxlength="40" VALUE=<cfoutput>"#GetTblName.AddressLine2#"</cfoutput> >
								<cfelse>
									<input type="Text" name="AddressLine2" size="40" maxlength="40"  >
								</cfif>
							</td>
						</tr>
				<!-- Address Line 3 --->
						<tr>
							<td align="left" valign="middle"><span class="pix10navy">Line 3</span></td>
							<td align="left">
								<cfif NewRecord IS "No">
									<input type="Text" name="AddressLine3" size="40" maxlength="40" VALUE=<cfoutput>"#GetTblName.AddressLine3#"</cfoutput> >
								<cfelse>
									<input type="Text" name="AddressLine3" size="40" maxlength="40"  >
								</cfif>
							</td>
						</tr>
				<!-- PostCode --->
						<tr>
							<td align="left" valign="middle"><span class="pix10navy">PostCode</span></td>
							<td align="left">
								<cfif NewRecord IS "No">
									<input type="Text" name="PostCode" size="10" maxlength="10" VALUE=<cfoutput>"#GetTblName.PostCode#"</cfoutput> >
								<cfelse>
									<input type="Text" name="PostCode" size="10" maxlength="10"  >
								</cfif>
							</td>
						</tr>
				<!-- Hide Address Checkbox --->
						<tr>
							<td align="left" valign="middle"><span class="pix10navy">Hide</span></td>
							<td align="left" <cfif NewRecord IS "No" AND GetTblName.ShowHideAddress IS 1>bgcolor="silver"</cfif>>
								<input name="ShowHideAddress" type="checkbox" <cfif NewRecord IS "No" AND GetTblName.ShowHideAddress IS 1>checked</cfif> ><span class="pix9">Hide Address (visible to Administrators only)</span>
							</td>
						</tr>
						
				</table>
			</td>
		</tr>
	</cfif>


	
<!--- Notes description --->
	<tr>
		
			<CFSWITCH expression="#TblName#">
				<CFCASE VALUE="Referee">
				<td align="left">
					<span class="pix10navy">Notes for publication</span>
					<cfif ListFind("Yellow",request.SecurityLevel) >
						<!--- suppress "see Referee's History" and Referee password for Yellow security level --->
					<cfelse>
						<cfif NewRecord IS "No">
							<cfoutput>
								<a href="RefsHist.cfm?LeagueCode=#LeagueCode#&RI=#ID#"><span class="pix13bold"><BR><BR>see Referee's History</span></a>
							</cfoutput>
					<!--- Password for Referee access to Referee details. See the yellow League Reports menu in News.cfm --->
							<cfif GetTblName.forename IS "" OR GetTblName.surname  IS "" >
								<table border="1" align="right" cellpadding="5" cellspacing="0" bgcolor="white">
									<tr>
										<td>
											<span class="pix10navy">Referee's password can only be derived<br>if the surname and forename(s) are supplied</span>
										</td>
									</tr>
								</table>
								<cfset RSecretWord = "" >
							<cfelse>
								<cfset RSecretWord = "#Trim(GetTblName.Surname)##Trim(GetTblName.Forename)#" >
								<cfset SecretWord = RSecretWord >
								<cfset SecretID = GetTblName.ID >
								<cfinclude template="InclSecretWordCreation.cfm">
								<cfset RSecretWord = SecretWord >
								<table border="1" align="right" cellpadding="5" cellspacing="0" bgcolor="white">
									<tr>
										<td>
											<span class="pix10navy">Referee password is </span><span class="monopix16red"><cfoutput>#RSecretWord#</cfoutput></span>
										</td>
									</tr>
								</table>
							</cfif>
						</cfif>
					</cfif>
				</td>
				</CFCASE>

				<CFCASE VALUE="Venue">
				<td align="left">
					<span class="pix10navy">Notes</span>
					<cfif NewRecord IS "No"><cfoutput><a href="PitchAvailableList.cfm?TblName=PitchAvailable&VenueID=#ID#&LeagueCode=#LeagueCode#&PA=Venue"><span class="pix13bold"><BR><BR>see PitchAvailable</span></a></cfoutput></cfif>
				</td>
				</CFCASE>


				<CFCASE VALUE="NewsItem">
				<td align="left"><span class="pix10navy">Newsitem Text</span></td>
				</CFCASE>
				<CFCASE VALUE="Team">
				<td align="left" valign="top">
					<span class="pix10navy">HTML text. This will appear on the Clubs screen under the name of the Club.</span>
					<cfif NewRecord IS "No"><cfoutput><a href="ClubList.cfm?LeagueCode=#LeagueCode#&fmTeamID=#ID#"><span class="pix13bold"><BR><BR>see Club Information</span></a></cfoutput></cfif>
					<!--- Password for Club access to Player Registration details. See the yellow League Reports menu in News.cfm --->
						<cfif NewRecord IS "No">
							<cfif GetTblName.ShortCol IS NOT "Guest">
								<cfset SecretWord = GetTblName.LongCol >
								<cfset SecretID = GetTblName.ID >
								<cfinclude template="InclSecretWordCreation.cfm">
								<span class="pix10navy"><BR><BR>Club password is </span><span class="monopix16red"><cfoutput>#SecretWord#</cfoutput></span>
							</cfif>
							<cfset fmTeamID=#ID#>
						</cfif>
				</td>
				</CFCASE>
				<CFCASE VALUE="Division">
				<td align="left">
					<span class="pix10navy">
					IMPORTANT:<br>
					The first two characters in this section<br>
					 must be <strong>KO</strong> if it is a Knock Out competition<BR>
					  <strong>P1</strong> (teams meet once per season)<BR>
					  <strong>P3</strong> (teams meet three times per season)<BR>
					  <strong>P4</strong> (teams meet four times per season)<BR><BR> other tokens can be:<BR>
					  <strong>MatchNumbers</strong> (pairs teams by matchnumber)<BR>
					  <strong>NoReplays</strong> (suppresses A v H unsched. match)<BR>
					  <strong>IgnoreLosers</strong> (allows matches over 2 legs)<BR>
					  <strong>HideGoals</strong> (hides Goals col. in League Table)<BR>
					  <strong>HideGoalDiff</strong> (hides Goal Diff col. in League Table)<BR>
					  <strong>HideDivision</strong> (hides everything - only Administrators can see)<BR>
					  <strong>SuppressTable</strong> (hides League Table)<BR>
					  <strong>External</strong> (for FA and County cups)<BR>
  					  <strong>MultipleMatches</strong> (teams can play more than 1 game per day)<br>
					  <strong>TeamSizeAA+BB+CC</strong> (default values StartingPlayerCount AA=11,<br>SubsUsedPlayerCount BB=03, SubsNotUsedPlayerCount CC=04)<br>
					  <strong>AgeBand3108yyyy</strong> specifies age group<br>e.g. <strong>AgeBand31082001</strong> in the 2013/4 season specifies Under 12s<br>
					  <strong>Sponsor[abcdefg]</strong> adds "sponsored by abcdefg" to division title<br>
					</span>
					<span class="pix10boldred">NEW for 2013/4</span><br>
					<span class="pix10navy"> override for Youth Football<br>
					<strong>YearBand2</strong> 2 year age band allowed<br>
					<strong>YearBand3</strong> 3 year age band allowed<br>
					</span>
					<cfif NewRecord IS "No">
						<cfoutput><a href="ConstitList.cfm?LeagueCode=#LeagueCode#&DivisionID=#ID#&TblName=Constitution"><span class="pix13bold"><BR><BR>see Constitution</span></a></cfoutput>
					</cfif>
				</td>
				</CFCASE>
				<CFCASE VALUE="Player">
				<td align="left">
					<span class="pix10navy">Notes</span>
						<cfif NewRecord IS "No">
							<cfoutput><a href="LUList.cfm?LeagueCode=#LeagueCode#&TblName=Player&FirstNumber=#GetTblName.ShortCol#&LastNumber=#GetTblName.ShortCol#"><span class="pix13bold"><BR><BR>see more information</span></a></cfoutput>
						</cfif>
				</td>
				</CFCASE>
				<CFCASE VALUE="MatchReport">
				<td align="left"><!---	<span class="pix10navy">HTML report	goes here...</span> ---></td>
				</CFCASE>
				<CFCASE VALUE="Rule">
				<td align="left"><span class="pix10navy">Notes</span></td>
				</CFCASE>

				<CFCASE VALUE="Noticeboard">
				<td align="left"></td>
				</CFCASE>
				<CFCASE VALUE="Document">
				<td align="left"></td>
				</CFCASE>
				<CFDEFAULTCASE>
				<td align="left"><span class="pix10navy">Notes</span></td>
				</CFDEFAULTCASE>	
			</CFSWITCH>
		
			
			
		<CFSWITCH expression="#TblName#">
		
			<CFCASE VALUE="MatchReport">
					<td  align="left" colspan="2">
						<cfoutput>
							<cfif NewRecord IS "Yes">
								<TEXTAREA class="ckeditor" NAME="Notes" cols="100" WRAP="VIRTUAL" rows="12">#MatchReportHeading#</TEXTAREA>
							<cfelse>
								<TEXTAREA class="ckeditor" NAME="Notes" cols="100" WRAP="VIRTUAL" rows="12">#GetTblName.Notes#</TEXTAREA>
							</cfif>
						</cfoutput>
					</td>
			<!---
				<td align="center">
					<cfif (NewRecord)>
						<cfset fckEditor.value = "#MatchReportHeading#">
					<cfelse>
						<cfset fckEditor.value = "#GetTblName.Notes#">
					</cfif>
					<cfmodule
					template="fckeditor/fckeditor.cfm"
					basePath="fckeditor/"
					instanceName="Notes"
					value="#fckEditor.value#"
					toolbarSet="Football"
					width="80%"
					height="300"
					>
				</td>
				--->
			</CFCASE>
			
			<CFCASE VALUE="Newsitem">
				<cfif NewRecord IS "No">
					<cfif GetTblName.LongCol IS "NOTICE" >
						<cfset request.showdelete = 0> <!--- disable Delete button to prevent accidental deletion of NOTICE Newsitem --->
					</cfif>
				</cfif>
				<tr>
					<td  align="left" colspan="2">
						<cfoutput>
							<cfif NewRecord IS "Yes">
								<TEXTAREA class="ckeditor" NAME="Notes" cols="100" WRAP="VIRTUAL" rows="12"></TEXTAREA>
							<cfelse>
								<TEXTAREA class="ckeditor" NAME="Notes" cols="100" WRAP="VIRTUAL" rows="12">#GetTblName.Notes#</TEXTAREA>
							</cfif>
						</cfoutput>
					</td>
				</tr>
				
				
				
				
				
				
				
				
				
				
			</CFCASE>
			<CFCASE VALUE="Noticeboard">
			</CFCASE>
			<CFCASE VALUE="Document">
			</CFCASE>
			<CFCASE VALUE="Referee">
				<cfoutput>
					<td  align="left" valign="top"><TEXTAREA NAME="Notes" cols="80" WRAP="VIRTUAL" rows="1"><cfif NewRecord IS "No">#HTMLEditFormat(GetTblName.Notes)#</cfif></TEXTAREA></td>	
				</cfoutput>
			</CFCASE>
			<CFDEFAULTCASE>
				<cfoutput>
					<td  align="left" valign="top"><TEXTAREA NAME="Notes" cols="80" WRAP="VIRTUAL" rows="4"><cfif NewRecord IS "No">#HTMLEditFormat(GetTblName.Notes)#</cfif></TEXTAREA></td>	
				</cfoutput>
			</CFDEFAULTCASE>	
		</CFSWITCH>

	</tr>
<!---
									****************
									* Extra Fields *
									****************
--->
	<CFSWITCH expression="#TblName#">
		
		<CFCASE VALUE="Team">
			<cfif NewRecord IS "No">
				<tr>
					<td colspan="2" align="center">
						<cfinclude template="InclTeamDetails.cfm">		
					</td>
				</tr>
			</cfif>
		</CFCASE>
		
		<CFCASE VALUE="Referee">
			<tr>
				<td align="left"><span class="pix10navy">Home Telephone</span></td>
				<td align="left"><input type="Text" name="HomeTel" size="20" maxlength="20" <cfif NewRecord IS "No">VALUE=<cfoutput>"#GetTblName.HomeTel#"</cfoutput></cfif>></td>
			</tr>
			<tr>
				<td align="left"><span class="pix10navy">Work Telephone</span></td>
				<td align="left"><input type="Text" name="WorkTel" size="20" maxlength="20" <cfif NewRecord IS "No">VALUE=<cfoutput>"#GetTblName.WorkTel#"</cfoutput></cfif>></td>
			</tr>
			<tr>
				<td align="left"><span class="pix10navy">Mobile Telephone</span></td>
				<td align="left"><input type="Text" name="MobileTel" size="20" maxlength="20" <cfif NewRecord IS "No">VALUE=<cfoutput>"#GetTblName.MobileTel#"</cfoutput></cfif>></td>
			</tr>
			<tr>
				<td align="left"><span class="pix10navy">Email Address 1</span></td>
				<td align="left"><input type="Text" name="EmailAddress1" size="60" maxlength="100" <cfif NewRecord IS "No">VALUE=<cfoutput>"#GetTblName.EmailAddress1#"</cfoutput></cfif>></td>
			</tr>
			<tr>
				<td align="left"><span class="pix10navy">Email Address 2</span></td>
				<td align="left"><input type="Text" name="EmailAddress2" size="60" maxlength="100" <cfif NewRecord IS "No">VALUE=<cfoutput>"#GetTblName.EmailAddress2#"</cfoutput></cfif>></td>
			</tr>
			<tr>
				<td align="left"><span class="pix10navy">Level (7, 6, 5, 4 etc )</span></td>
				<td align="left">
					<cfif NewRecord IS "Yes">
						<cfinput type="Text" name="Level" size="1" maxlength="2" validate="integer" message="Level must be numeric">
					<cfelse>
						<cfinput type="Text" name="Level" size="1" maxlength="2" validate="integer" message="Level must be numeric" VALUE="#GetTblName.Level#">
					</cfif>
				</td>
			</tr>
			<tr>
				<td align="left"><span class="pix10navy">Promotion Candidate</span></td>
				<td align="left">
					<span class="pix13boldnavy">
					<cfif NewRecord IS "Yes">
						No<input type="radio" name="PromotionCandidate" value="No" checked >&nbsp;&nbsp;&nbsp;&nbsp;Yes<input type="radio" name="PromotionCandidate" value="Yes" >
					<cfelse>
						No<input type="radio" name="PromotionCandidate" value="No" <cfif GetTblName.PromotionCandidate IS "No" >checked</cfif> >&nbsp;&nbsp;&nbsp;&nbsp;Yes<input type="radio" name="PromotionCandidate" value="Yes" <cfif GetTblName.PromotionCandidate IS "Yes" >checked</cfif> >
					</cfif>
					</span>
				</td>
			</tr>
									
			<cfif ListFind("Yellow",request.SecurityLevel) >
				<!--- suppress restrictions for Yellow security level --->
				<!--- disable the Delete button as well ..... --->
				<cfset request.showdelete = 0>
			<cfelse>
				<tr>
					<td  align="left" valign="top"><span class="pix10navy">Restrictions  e.g.<br />'Public Transport only'<br />'Not games involving Chelsea'<br />'Lines only'
					<br />'Not to be apptd. with John Smith'<br /><b>NoDuplicateWarning</b> will suppress warnings about more than one appointment on the day.<br />These comments are visible to full password holders only</span></td>
					<td  align="left" valign="top">
					<cfoutput>
					<TEXTAREA NAME="Restrictions" cols="80" rows="5"><cfif NewRecord IS "No">#HTMLEditFormat(GetTblName.Restrictions)#</cfif></TEXTAREA>
					</cfoutput>
					</td>
				</tr>
			</cfif>
			 

		</CFCASE>

		<CFCASE VALUE="Noticeboard">
			<tr>
				<td align="left">
					<table border="1" cellpadding="2" cellspacing="0" >
						<tr>
							<td align="left"><span class="pix10navy">Advert Title</span></td>
							<td colspan="6"><input type="Text" name="AdvertTitle" size="100" maxlength="255" <cfif NewRecord IS "No">VALUE=<cfoutput>"#GetNoticeboard.AdvertTitle#"</cfoutput><cfelse>VALUE="X--- Dates set up for ten weeks starting today ---X"</cfif>></td>
						</tr>
						<tr>
							<td align="left"><span class="pix10navy">Priority</span></td><td align="left"><input type="Text" name="Priority" size="1" maxlength="1" 
								<cfif NewRecord IS "No">
									VALUE=<cfoutput>"#GetNoticeboard.Priority#"</cfoutput>
								<cfelse>
									VALUE="2"
								</cfif>> 
							</td>
							<td align="left"><span class="pix10navy">Start Date</span></td><td align="left"><input type="Text" name="StartDate" size="20" maxlength="20" <cfif NewRecord IS "No">VALUE=<cfoutput>"#DateFormat(GetNoticeboard.StartDate, 'DD MMM YYYY')#"</cfoutput><cfelse>VALUE=<cfoutput>"#DateFormat(Now(), 'DD MMM YYYY')#"</cfoutput></cfif>></td>
							<td align="left"><span class="pix10navy">End Date</span></td><td align="left"><input type="Text" name="EndDate" size="20" maxlength="20" <cfif NewRecord IS "No">VALUE=<cfoutput>"#DateFormat(GetNoticeboard.EndDate, 'DD MMM YYYY')#"</cfoutput><cfelse>VALUE=<cfoutput>"#DateFormat(DateAdd( 'ww', 10, Now() ), 'DD MMM YYYY')#"</cfoutput></cfif>></td>
							<td align="left"><input type="checkbox" name="Hide" <cfif NewRecord IS "No"><cfif GetNoticeboard.Hide IS "1">checked</cfif><cfelse></cfif>><span class="pix10navy">Hide</span></td>
						</tr>
						<tr>
							<td align="left"><span class="pix10navy">Show for these counties</span></td>
							<td colspan="5"><input type="Text" name="ShowForTheseCounties" size="100" maxlength="255" 
								<cfif NewRecord IS "No">
									VALUE=<cfoutput>"#GetNoticeboard.ShowForTheseCounties#"</cfoutput>
								<cfelse>
									VALUE="LondonMiddx,Surrey,Kent,Berks,Bucks,Herts,Essex"
								</cfif>></td>
							<td align="left"><input type="checkbox" name="ShowEverywhere" <cfif NewRecord IS "No"><cfif GetNoticeboard.ShowEverywhere IS "1">checked</cfif><cfelse></cfif>><span class="pix10navy">Show Everywhere</span></td>
						</tr>
						<tr>
							<td align="left"><span class="pix10navy">Show for these leagues</span></td>
							<td colspan="6"><input type="Text" name="ShowForTheseLeagues" size="100" maxlength="255" <cfif NewRecord IS "No">VALUE=<cfoutput>"#GetNoticeboard.ShowForTheseLeagues#"</cfoutput><cfelse>VALUE=""</cfif>></td>
						</tr>
						<tr>
							<td align="left"><span class="pix10navy">Advert HTML</span></td>
							<td colspan="6"><TEXTAREA NAME="AdvertHTML" cols="80" WRAP="VIRTUAL" rows="6"><cfif NewRecord IS "No"><cfoutput>#HTMLEditFormat(GetNoticeboard.AdvertHTML)#</cfoutput></cfif></TEXTAREA></td>
						</tr>
						<tr>
							<td align="left"><span class="pix10navy">Image File</span></td>
							<td colspan="6"><TEXTAREA name="ImageFile" cols="80" WRAP="VIRTUAL" rows="3"><cfif NewRecord IS "No"><cfoutput>#HTMLEditFormat(GetNoticeboard.ImageFile)#</cfoutput><cfelse><img src="marketplace/brentnal.jpg" border="0"><img src="leaguebadges/mdx.jpg" border="0"></cfif></TEXTAREA></td>
						</tr>
						<tr>
							<td align="left"><span class="pix10navy">Email Address</span></td>
							<td colspan="6"><input type="Text" name="EmailAddr" size="40" maxlength="255" <cfif NewRecord IS "No">VALUE=<cfoutput>"#GetNoticeboard.EmailAddr#"</cfoutput><cfelse>VALUE=""</cfif>></td>

						</tr>
						<tr>
							<td align="left"><span class="pix10navy">Contact Name</span></td>
							<td colspan="7"><input type="Text" name="ContactName" size="50" maxlength="255" <cfif NewRecord IS "No">VALUE=<cfoutput>"#GetNoticeboard.ContactName#"</cfoutput><cfelse>VALUE=""</cfif>></td>
						</tr>
						<tr>
							<td align="left"><span class="pix10navy">Telephone Numbers</span></td>
							<td colspan="7"><input type="Text" name="TelephoneNumbers" size="50" maxlength="255" <cfif NewRecord IS "No">VALUE=<cfoutput>"#HTMLEditFormat(GetNoticeboard.TelephoneNumbers)#"</cfoutput><cfelse>VALUE=""</cfif>></td>

						</tr>
						<tr>
							<td align="left"><span class="pix10navy">Notes</span></td>
							
					<td   align="left" >
						<cfoutput>
							<cfif NewRecord IS "Yes">
								<TEXTAREA class="ckeditor" NAME="Notes" cols="100" WRAP="VIRTUAL" rows="12">£10 cheque [details] OR internet payment - to be confirmed</TEXTAREA>
							<cfelse>
								<TEXTAREA class="ckeditor" NAME="Notes" cols="100" WRAP="VIRTUAL" rows="12">#GetNoticeboard.Notes#</TEXTAREA>
							</cfif>
						</cfoutput>
					</td>
				<!---
							
							<td colspan="7">
								<cfif (NewRecord)>
									<cfset fckEditor.value = "£10 cheque [details] OR internet payment - to be confirmed">
								<cfelse>
									<cfset fckEditor.value = "#GetNoticeboard.Notes#">
								</cfif>
								<cfmodule
								template="fckeditor/fckeditor.cfm"
								basePath="fckeditor/"
								instanceName="Notes"
								value="#fckEditor.value#"
								toolbarSet="Football"
								width="100%"
								height="300"
								>
							</td>
					--->		
							
							
							
							
						</tr>
						<cfif NOT (NewRecord)>
							<tr>
								<td colspan="7">
									<span class="pix13boldblack">
										<cfoutput>
										#GetNoticeboard.AdvertTitle#<br><br>
										Area covered: #GetNoticeboard.ShowForTheseCounties#<br><br>
										Advert expires: #DateFormat(GetNoticeboard.EndDate, 'DD MMMM YYYY')#<br><br>
										Please advise if you need to add/change text
										</cfoutput>
									</span>
								</td>
							</tr>
						</cfif>
					</table>
				</td>
			</tr>
				
		</CFCASE>
		<CFCASE VALUE="Document">
			<tr>
				<td align="left">
					<table border="1" cellpadding="2" cellspacing="0" >
						<tr>
							<td align="left"><span class="pix10navy">Description</span></td>
							<td colspan="6" align="left"><input type="Text" name="Description" size="100" maxlength="255" <cfif NewRecord IS "No">VALUE=<cfoutput>"#GetDocument.Description#"</cfoutput><cfelse>VALUE="XxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxX"</cfif>></td>
						</tr>
						<tr>
							<td align="left"><span class="pix10navy">Group Name</span></td>
							<td colspan="6" align="left"><input type="Text" name="GroupName" size="100" maxlength="255" <cfif NewRecord IS "No">VALUE=<cfoutput>"#GetDocument.GroupName#"</cfoutput><cfelse>VALUE="XxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxX"</cfif>></td>
						</tr>
						
					</table>
				</td>
			</tr>
				
		</CFCASE>
		<CFDEFAULTCASE>
		</CFDEFAULTCASE>	
	</CFSWITCH>
</table>
