<cfinclude template="queries/qry_GetPitchNoInfo.cfm">
<cfinclude template="queries/qry_GetPitchStatusInfo.cfm">
<cfinclude template="queries/qry_GetVenue.cfm">
<INPUT TYPE="HIDDEN" NAME="TeamID" VALUE="<cfoutput>#TeamID#</cfoutput>">
<INPUT TYPE="HIDDEN" NAME="OrdinalID" VALUE="<cfoutput>#OrdinalID#</cfoutput>">

<cfif StructKeyExists(URL, "FID")>
	<INPUT TYPE="HIDDEN" NAME="FID" VALUE="<cfoutput>#url.FID#</cfoutput>">
</cfif>

<table width="100%" border="0" cellspacing="0" cellpadding="5" align="CENTER">
	<tr>
		<td colspan="5" align="CENTER">
			<cfoutput><a href="PitchAvailableList.cfm?TblName=PitchAvailable&VenueID=#VenueID#&PitchNoID=#PitchNoID#&PitchStatusID=#PitchStatusID#&LeagueCode=#LeagueCode#&TeamID=#TeamID#&OrdinalID=#OrdinalID#&PA=#ThisPA#"><span class="pix18bold">List</span></a></cfoutput>
		</td>
	</tr>
	<tr>
		<td colspan="10">
			<table border="1" align="center" cellpadding="3" cellspacing="0">
				<cfif NewRecord IS "Yes">
					<tr>
						<td colspan="1" align="center"><span class="pix10">&nbsp;</span></td>
						<td colspan="3" align="center"><span class="pix10bold">FROM</span></td>
						<td colspan="3" align="center"><span class="pix10bold">TO</span></td>
						<td colspan="7" align="center"><span class="pix10">&nbsp;</span></td>
						
					</tr>
				</cfif>
				<tr>
					<cfif NewRecord IS "Yes">
						<td align="right">
							<span class="pix10">Every</span><INPUT NAME="RadioButton" TYPE="radio" VALUE="1" checked ><br />
							<span class="pix10">Every Other</span><INPUT NAME="RadioButton" TYPE="radio" VALUE="2" >
						</td>
						<td align="center"><span class="pix10">Day</span></td>
						<td align="center"><span class="pix10">Month</span></td>
						<td align="center"><span class="pix10">Year</span></td>
						<td align="center"><span class="pix10">Day</span></td>
						<td align="center"><span class="pix10">Month</span></td>
						<td align="center"><span class="pix10">Year</span></td>
					<cfelse>
						<td align="center"><span class="pix10">week</span></td>
						<td align="center"><span class="pix10">day</span></td>
						<td align="center"><span class="pix10">&nbsp;</span></td>
						<td align="center"><span class="pix10">day</span></td>
						<td align="center"><span class="pix10">week</span></td>
					</cfif>
					<td align="center" <cfif PitchStatusID GT 1>bgcolor="pink"</cfif>><span class="pix10">Status</span></td>
					
					<td align="center"><span class="pix10">Pitch No.</span></td>
					<td align="center"><span class="pix10">Venue Name</span></td>
				</tr>

				<tr>
					<cfif NewRecord IS "Yes">
						<td>
							<SELECT NAME="DayOfWeek" size="1">
								<cfoutput>
									<cfloop from="1" to="7" step="1" index="i">
										<OPTION VALUE="#i#" <cfif StructKeyExists(URL, "FixtureDate") and DayOfWeek(url.FixtureDate) IS i >selected</cfif><cfif NOT StructKeyExists(URL, "FixtureDate") AND DayOfWeek(SeasonStartDate) IS #i#>selected</cfif> >#DayOfWeekAsString(i)#</OPTION>
									</cfloop>
								</cfoutput>
							</select>
						</td>
						<td>
							<SELECT NAME="StartDay" size="1">
								<cfoutput>
									<cfloop from="1" to="31" step="1" index="i">
										<OPTION VALUE="#i#" <cfif StructKeyExists(URL, "FixtureDate") and DateFormat(url.FixtureDate, 'DD') IS i >selected</cfif><cfif NOT StructKeyExists(URL, "FixtureDate") AND Day(SeasonStartDate) IS #i#>selected</cfif> >#i#</OPTION>
									</cfloop>
								</cfoutput>
							</select>
						</td>
						
						<td>
							<SELECT NAME="StartMonth" size="1">
								<cfoutput>
									<cfloop from="1" to="12" step="1" index="i">
										<OPTION VALUE="#i#" <cfif StructKeyExists(URL, "FixtureDate") and DateFormat(url.FixtureDate, 'MM') IS i >selected</cfif><cfif NOT StructKeyExists(URL, "FixtureDate") AND Month(SeasonStartDate) IS #i#>selected</cfif> >#Left(MonthAsString(i),3)#</OPTION>
									</cfloop>
								</cfoutput>
							</select>
						</td>
						<td>
							<SELECT NAME="StartYear" size="1">
								<cfoutput>
									<cfloop from="#LeagueCodeYear#" to="#LeagueCodeYear+1#" step="1" index="i">
										<OPTION VALUE="#i#" <cfif StructKeyExists(URL, "FixtureDate") and DateFormat(url.FixtureDate, 'YYYY') IS i >selected</cfif><cfif NOT StructKeyExists(URL, "FixtureDate") AND Year(SeasonStartDate) IS #i#>selected</cfif> >#i#</OPTION>
									</cfloop>
								</cfoutput>
							</select>
						</td>
						<td>
							<SELECT NAME="EndDay" size="1">
								<cfoutput>
									<cfloop from="1" to="31" step="1" index="i">
										<OPTION VALUE="#i#" <cfif StructKeyExists(URL, "FixtureDate") and DateFormat(url.FixtureDate, 'DD') IS i >selected</cfif><cfif NOT StructKeyExists(URL, "FixtureDate") AND Day(SeasonEndDate) IS #i#>selected</cfif> >#i#</OPTION>
									</cfloop>
								</cfoutput>
							</select>
						</td>
						<td>
							<SELECT NAME="EndMonth" size="1">
								<cfoutput>
									<cfloop from="1" to="12" step="1" index="i">
										<OPTION VALUE="#i#" <cfif StructKeyExists(URL, "FixtureDate") and DateFormat(url.FixtureDate, 'MM') IS i >selected</cfif><cfif NOT StructKeyExists(URL, "FixtureDate") AND Month(SeasonEndDate) IS #i#>selected</cfif> >#Left(MonthAsString(i),3)#</OPTION>
									</cfloop>
								</cfoutput>
							</select>
						</td>
						<td>
							<SELECT NAME="EndYear" size="1">
								<cfoutput>
									<cfloop from="#LeagueCodeYear#" to="#LeagueCodeYear+1#" step="1" index="i">
										<OPTION VALUE="#i#" <cfif StructKeyExists(URL, "FixtureDate") and DateFormat(url.FixtureDate, 'YYYY') IS i >selected</cfif><cfif NOT StructKeyExists(URL, "FixtureDate") AND Year(SeasonEndDate) IS #i#>selected</cfif> >#i#</OPTION>
									</cfloop>
								</cfoutput>
							</select>
						</td>
					<cfelse>
						<cfinclude template="queries/qry_QPitchAvailable2.cfm">
						<cfif QPitchAvailable2.RecordCount IS 0>
							<center><span class="pix13boldred">Pitch Availability not found</span></center>
							<cfabort>
						<cfelse>
							<cfoutput query="QPitchAvailable2">
								<td align="center" valign="middle"><a href="UpdateForm.cfm?TblName=PitchAvailable&id=#ID#&TeamID=#TeamID#&OrdinalID=#OrdinalID#&VenueID=#VenueID#&PitchNoID=#PitchNoID#&PitchStatusID=#PitchStatusID#&LeagueCode=#LeagueCode#&Arrow=LW&PA=#ThisPA#"><img src="left.jpg" border="0"></a></td>
								<td align="center" valign="middle"><a href="UpdateForm.cfm?TblName=PitchAvailable&id=#ID#&TeamID=#TeamID#&OrdinalID=#OrdinalID#&VenueID=#VenueID#&PitchNoID=#PitchNoID#&PitchStatusID=#PitchStatusID#&LeagueCode=#LeagueCode#&Arrow=LD&PA=#ThisPA#"><img src="left.jpg" border="0"></a></td>

								<td>
									<cfif StructKeyExists(session,"BookingDate") AND StructKeyExists(URL,"Arrow")>
										<cflock scope="session" timeout="10" type="readonly">
											<cfset request.BookingDate = session.BookingDate >
										</cflock>
									<cfelse>
										<cfset request.BookingDate = QPitchAvailable2.BookingDate >
									</cfif>
									<cfif StructKeyExists(URL,"Arrow") AND url.Arrow IS "LW">
										<cfset EarlierBookingDate = DateAdd('D', -7, request.BookingDate) >
										<span class="pix13bold">#DateFormat(EarlierBookingDate, 'DDDD, DD MMMM YYYY')#</span>
										<INPUT TYPE="HIDDEN" NAME="BookingDate" VALUE="#DateFormat(EarlierBookingDate, 'YYYY-MM-DD')#">
										<cfset request.BookingDate = EarlierBookingDate >
									<cfelseif StructKeyExists(URL,"Arrow") AND url.Arrow IS "RW">
										<cfset LaterBookingDate = DateAdd('D', 7, request.BookingDate) >
										<span class="pix13bold">#DateFormat(LaterBookingDate, 'DDDD, DD MMMM YYYY')#</span>
										<INPUT TYPE="HIDDEN" NAME="BookingDate" VALUE="#DateFormat(LaterBookingDate, 'YYYY-MM-DD')#">
										<cfset request.BookingDate = LaterBookingDate >
									<cfelseif StructKeyExists(URL,"Arrow") AND url.Arrow IS "LD">
										<cfset EarlierBookingDate = DateAdd('D', -1, request.BookingDate) >
										<span class="pix13bold">#DateFormat(EarlierBookingDate, 'DDDD, DD MMMM YYYY')#</span>
										<INPUT TYPE="HIDDEN" NAME="BookingDate" VALUE="#DateFormat(EarlierBookingDate, 'YYYY-MM-DD')#">
										<cfset request.BookingDate = EarlierBookingDate >
									<cfelseif StructKeyExists(URL,"Arrow") AND url.Arrow IS "RD">
										<cfset LaterBookingDate = DateAdd('D', 1, request.BookingDate) >
										<span class="pix13bold">#DateFormat(LaterBookingDate, 'DDDD, DD MMMM YYYY')#</span>
										<INPUT TYPE="HIDDEN" NAME="BookingDate" VALUE="#DateFormat(LaterBookingDate, 'YYYY-MM-DD')#">
										<cfset request.BookingDate = LaterBookingDate >
									<cfelse>
										<cfset ThisWeeksBookingDate = request.BookingDate >
										<span class="pix13bold">#DateFormat(ThisWeeksBookingDate, 'DDDD, DD MMMM YYYY')#</span>
										<INPUT TYPE="HIDDEN" NAME="BookingDate" VALUE="#DateFormat(ThisWeeksBookingDate, 'YYYY-MM-DD')#">
										<cfset request.BookingDate = ThisWeeksBookingDate >
									</cfif>
									<cflock scope="session" timeout="10" type="exclusive">
										<cfset session.BookingDate = request.BookingDate >
									</cflock>
								</td>
								<td align="center" valign="middle"><a href="UpdateForm.cfm?TblName=PitchAvailable&id=#ID#&TeamID=#TeamID#&OrdinalID=#OrdinalID#&VenueID=#VenueID#&PitchNoID=#PitchNoID#&PitchStatusID=#PitchStatusID#&LeagueCode=#LeagueCode#&Arrow=RD&PA=#ThisPA#"><img src="right.jpg" border="0"></a>
								<td align="center" valign="middle"><a href="UpdateForm.cfm?TblName=PitchAvailable&id=#ID#&TeamID=#TeamID#&OrdinalID=#OrdinalID#&VenueID=#VenueID#&PitchNoID=#PitchNoID#&PitchStatusID=#PitchStatusID#&LeagueCode=#LeagueCode#&Arrow=RW&PA=#ThisPA#"><img src="right.jpg" border="0"></a>
								</td>
							</cfoutput>
						</cfif>
					</cfif>
					<td <cfif PitchStatusID GT 1>bgcolor="pink"</cfif> >
						<SELECT NAME="PitchStatusID" size="1">
							<cfoutput query="GetPitchStatusInfo" >
								<OPTION VALUE="#ID#" <cfif GetPitchStatusInfo.ID IS #PitchStatusID#>selected</cfif> >#LongCol#</OPTION>
							</cfoutput>
						</select>
					</td>
					<td>
						<SELECT NAME="PitchNoID" size="1">
							<cfoutput query="GetPitchNoInfo" >
								<OPTION VALUE="#ID#" <cfif GetPitchNoInfo.ID IS #PitchNoID#>selected</cfif> >#LongCol#</OPTION>
							</cfoutput>
						</select>
					</td>
					<td>
						<SELECT NAME="VenueID" size="1">
							<cfoutput query="GetVenue" >
								<OPTION VALUE="#ID#"  <cfif GetVenue.ID IS #VenueID#>selected</cfif>  >#VenueName#</OPTION>
							</cfoutput>
						</select>
					</td>
				
					
				</tr>
			</table>
		</td>
	</tr>
</table>
