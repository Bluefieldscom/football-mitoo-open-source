<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">

<cfif StructKeyExists(form, "OKButton")>
	<cfset request.Date001 = DateFormat(FirstDay,'YYYY-MM-DD')>
	<cfset request.Date002  = DateFormat(LastDay,'YYYY-MM-DD')>
	<cfset Date01 = request.Date001 >
	<cfset Date02 = request.Date002 >
	<cfif DateDiff('d', Date01, Date02) LT 0>
		<span class="pix18boldred">Invalid date range</span>
	<cfelse>
		<cflocation url="RefMarksXLS.cfm?LeagueCode=#LeagueCode#&Date01=#Date01#&Date02=#Date02#" addtoken="no">
	</cfif>
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

<cfform action="DateRange1.cfm?LeagueCode=#LeagueCode#" method="post" name="DateRange1Form">
		<input type="Hidden" name="StateVector" value="1">
		<table width="100%">
			<tr>
				<td align="CENTER">
					<table border="0" cellspacing="0" cellpadding="5" class="bg_suspend">
					<tr>
						<td align="left" colspan="2"><span class="pix10">Please specify the date range ... </span></td>
					</tr>
						<tr>
							<td colspan="2" align="right">
								<cfoutput>
									<span class="pix10">
									between <a href="DateRange1.cfm?LeagueCode=#LeagueCode#"  NAME="anchor1" target="_blank" ID="anchor1" onClick="cal1.select(DateRange1Form.FirstDay,'anchor1','EE, dd MMM yyyy'); return false;">
									<u>choose</u></a> <input name="FirstDay" type="text" size="30" readonly="true" value="#DateFormat(Date01, "DDDD, DD MMMM YYYY")#" ></span>
								</cfoutput>
							</td>					
						</tr>
						<tr>
							<td colspan="2" align="right">
								<cfoutput>
									<span class="pix10">
									and <a href="DateRange1.cfm?LeagueCode=#LeagueCode#"  NAME="anchor1" target="_blank" ID="anchor1" onClick="cal1.select(DateRange1Form.LastDay,'anchor1','EE, dd MMM yyyy'); return false;">
									<u>choose</u></a> <input name="LastDay" type="text" size="30" readonly="true" value="#DateFormat(Date02, "DDDD, DD MMMM YYYY")#" ></span>
								</cfoutput>
							</td>					
						</tr>
						<tr>
							<td height="40" colspan="2" align="center">
								<input type="submit" name="OKButton" value="OK">
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
</cfform>
