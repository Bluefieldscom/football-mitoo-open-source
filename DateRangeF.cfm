<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">

<cfform action="DateRangeF.cfm?LeagueCode=#LeagueCode#" method="post" name="DateRangeF">
	<cfif  StructKeyExists(form, "StateVector")>
		<cfset request.Date001 = DateFormat(GetToken(form.FirstDay,2,","), 'YYYY-MM-DD')>
		<cfset request.Date002 = DateFormat(GetToken(form.LastDay,2,","),  'YYYY-MM-DD')>
		<cfif Evaluate(DateDiff("D", GetToken(form.FirstDay,2,","), GetToken(form.LastDay,2,","))+1) LE 0>
			<!--- check to see if the first date is greater than the last date! --->
			<cfoutput>
				<span class="pix18boldred">DATE RANGE ERROR - from #form.FirstDay# to #form.LastDay#<br /><br /></span>
				<span class="pix10boldred">Please click on the Back button of your browser....</b><br /><br /><br /></span>
			</cfoutput>
			<cfabort>
		</cfif>
<!---			
											************************
											*                      *	
											************************
--->
		<cfif Form.Action IS "Report">
			<cfset  D1 = request.Date001 >
			<cfset  D2 = request.Date002 >
			<cflocation url="FixtureDetailsXLS.cfm?LeagueCode=#LeagueCode#&D1=#D1#&D2=#D2#" addtoken="no">
			<cfabort>
		</cfif>
</cfif>	
<!--- ================================================================================================================================================== --->	
		<cfif StructKeyExists(request, "Date001") AND StructKeyExists(request, "Date002")>
			<cfset Date01 = request.Date001 >
			<cfset Date02 = request.Date002 >
		<cfelse>
			<cfset Date01 = Now()>
			<cfset Date02 = Now()>
		</cfif>
		
		<SCRIPT type="text/javascript" src="CalendarPopup.js"></SCRIPT>	
		<!--- season dates - less one for start, plus one for end - this info used in calendar to block non-season dates! --->
		<cfset LOdate = DateAdd('D', -61, SeasonStartDate) >
		<cfset HIdate = DateAdd('D',  1, SeasonEndDate) >
		<SCRIPT type="text/javascript">
			// note date type on disable calls
			<cfoutput>
			var cal1 = new CalendarPopup(); 
			cal1.addDisabledDates(null, '#LSDateFormat(LOdate, "mmm dd, yyyy")#'); 
			cal1.addDisabledDates('#LSDateFormat(HIdate, "mmm dd, yyyy")#', null);
			cal1.offsetX = 150;
			cal1.offsetY = -150;
			</cfoutput>
		</SCRIPT>
		<input type="Hidden" name="StateVector" value="1">
		<table width="100%">
			<tr>
				<td align="CENTER">
					<table border="0" cellspacing="0" cellpadding="5" class="bg_suspend">
					<tr>
						<td colspan="2" align="center"><span class="pix10">Please specify the date range.<br>Restricted to maximum 500 fixtures/results.</span></td>
					</tr>
						<tr>
							<td colspan="2" align="right">
								<cfoutput>
									<span class="pix10">
									between <a href="DateRangeF.cfm?LeagueCode=#LeagueCode#"  NAME="anchor1" target="_blank" ID="anchor1" onClick="cal1.select(DateRangeF.FirstDay,'anchor1','EE, dd MMM yyyy'); return false;">
									choose</a> <input name="FirstDay" type="text" size="30" readonly="true" value="#DateFormat(Date01, "DDDD, DD MMMM YYYY")#" ></span>
								</cfoutput>
							</td>					
						</tr>
						<tr>
							<td colspan="2" align="right">
								<cfoutput>
									<span class="pix10">
									and <a href="DateRangeF.cfm?LeagueCode=#LeagueCode#"  NAME="anchor1" target="_blank" ID="anchor1" onClick="cal1.select(DateRangeF.LastDay,'anchor1','EE, dd MMM yyyy'); return false;">
									choose</a> <input name="LastDay" type="text" size="30" readonly="true" value="#DateFormat(Date02, "DDDD, DD MMMM YYYY")#" ></span>
								</cfoutput>
							</td>					
						</tr>
						<!---------
						<tr>
            				<td height="20" colspan="2" align="center"><span class="pix10bold">Please tick the columns you want<br>then click on Report button below</span></td>
						</tr>
						<tr>
            				<td align="right"><input name="WantReferee" type="checkbox"> </td>
							<td align="left"><span class="pix10bold">Referee Name</span></td>
						</tr>
						
						RefereeMarksH
						
						RefereeMarksA
						
						AsstRef1Name
						
						AsstRef1Name
						FourthOfficialName
						AssessorName
						AssessmentMarks
						MatchOfficialsExpenses
						HomeSportsmanshipMarks
						AwaySportsmanshipMarks
						Fixturenotes
						
						Attendance
						
						HospitalityMarks
						HomeTeamNotes
						AwayTeamNotes
						PrivateNotes
						KOTime
						RefereeReportReceived
						HideMatchOfficials
						
						--->
						<tr>
							<td align="center" colspan="2" ><span class="pix10"><input type="Submit" name="Action" value="Report"></span></td>
						</tr>
						

					</table>
				</td>
			</tr>
		</table>
</cfform>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br> 