<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfinclude template="InclBegin.cfm">
<cfif StructKeyExists(form, "PA" ) >
	<cfset ThisPA = form.PA >
<cfelseif StructKeyExists(url, "PA" )>
	<cfset ThisPA = url.PA >
<cfelse> 
	<cfoutput>#CGI.Script_Name# - PA is not defined - aborting</cfoutput> 
	<cfabort>
</cfif>
 
<!--- This deletes all status=OK pitchavailable rows that were unused for fixtures before today's date ------>
<cfinclude template="queries/del_AllUnusedPitchAvailability.cfm">

<!--- This section deletes rows where they have been ticked ---------------->
<cfif StructKeyExists(form, "Button" ) AND StructKeyExists(form, "NoOfRows")  AND StructKeyExists(form, "VenueID" ) AND NOT StructKeyExists(form, "TeamID" ) >
	<cfif form.Button IS "Delete Ticked">
		<cfloop from="1" to="#form.NoOfRows#" step="1" index="i">
			<cfif StructKeyExists(form, "L#i#")>
				<cfset DeleteID = "L#i#">
				<cfset DeleteID = Evaluate(DeleteID)>
				<cfinclude template="queries/del_PitchAvailable.cfm">
				<!--- update the fixture record (parent) PitchAvailableID - set it to zero --->
				<cfset ThisPA_ID = DeleteID >
				<cfset ThisBookingDate = "BD#i#">
				<cfset ThisBookingDate = Evaluate(ThisBookingDate)>
				<cfset ThisBookingDate = DateFormat(ThisBookingDate,'YYYY-MM-DD')>
				<cfinclude template="queries/upd_Fixture_PitchAvailableID2.cfm">   
			</cfif>
		</cfloop>
	</cfif>
<cfelseif StructKeyExists(form, "Button" ) AND StructKeyExists(form, "NoOfRows")  AND StructKeyExists(form, "TeamIDOrdinalID" )  AND NOT StructKeyExists(form, "VenueID" ) >
	<cfif form.Button IS "Delete Ticked">
		<cfloop from="1" to="#form.NoOfRows#" step="1" index="i">
			<cfif StructKeyExists(form, "L#i#")>
				<cfset DeleteID = "L#i#">
				<cfset DeleteID = Evaluate(DeleteID)>
				<cfinclude template="queries/del_PitchAvailable.cfm">
				<!--- update the fixture record (parent) PitchAvailableID - set it to zero --->
				<cfset ThisPA_ID = DeleteID >
				<cfset ThisBookingDate = "BD#i#">
				<cfset ThisBookingDate = Evaluate(ThisBookingDate)>
				<cfset ThisBookingDate = DateFormat(ThisBookingDate,'YYYY-MM-DD')>
				<cfinclude template="queries/upd_Fixture_PitchAvailableID2.cfm">   
			</cfif>
		</cfloop>
	</cfif>
</cfif> 

<cfif ThisPA IS "Venue">
	<!--- Pitch Availability by Venue --->
	<cfif StructKeyExists(form, "VenueID" ) >
		<cfset ThisVenueID = form.VenueID >
	<cfelseif StructKeyExists(url, "VenueID" )>
		<cfset ThisVenueID = url.VenueID >
	<cfelse> 
		<cfoutput>#CGI.Script_Name# - ThisVenueID error - aborting</cfoutput> 
		<cfabort>
	</cfif>
<cfelseif ThisPA IS "Team">
 
	<!--- Pitch Availability by Team --->
	<cfif StructKeyExists(form, "TeamIDOrdinalID" )  >
		<cfset ThisTeamID = GetToken(form.TeamIDOrdinalID, 1, '^' ) >
		<cfset ThisOrdinalID = GetToken(form.TeamIDOrdinalID, 2, '^' ) >
	<cfelseif StructKeyExists(url, "TeamID" ) AND StructKeyExists(url, "OrdinalID" ) >
		<cfset ThisTeamID = url.TeamID >
		<cfset ThisOrdinalID = url.OrdinalID >
	<cfelse> 
		<cfoutput>#CGI.Script_Name# - ThisTeamID/ThisOrdinalID error - aborting</cfoutput> 
		<cfabort>
	</cfif>
<cfelse> 
	<cfoutput>#CGI.Script_Name# - ThisPA error - aborting</cfoutput> 
	<cfabort>
</cfif>
<cfinclude template="queries/qry_QPitchAvailable.cfm">
<cfoutput>
<form NAME="CheckBoxes" ACTION="PitchAvailableList.cfm"  METHOD="POST" >
</cfoutput>
 <!--- <cfdump var="#QPitchAvailable#"><cfabort>  --->
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="loggedinScreen">
		<tr>
			<td align="CENTER">
				<cfoutput>
					<cfif ThisPA IS "Venue">
						<a href="UpdateForm.cfm?TblName=PitchAvailable&VenueID=#ThisVenueID#&TeamID=0&OrdinalID=0&PitchNoID=0&PitchStatusID=0&LeagueCode=#LeagueCode#&PA=Venue"><span class="pix18bold">Add</span></a>
					<cfelseif ThisPA IS "Team">

						<!--- get the default venue and pitch no. IDs for the home team --->
						<cfinclude template="queries/qry_TeamDetails.cfm">

					
						<a href="UpdateForm.cfm?TblName=PitchAvailable&VenueID=#QTeamDetails.VenueID#&TeamID=#ThisTeamID#&OrdinalID=#ThisOrdinalID#&PitchNoID=#QTeamDetails.PitchNoID#&PitchStatusID=0&LeagueCode=#LeagueCode#&PA=Team"><span class="pix18bold">Add</span></a>
					<cfelse>
						#CGI.Script_Name# - ThisPA is "#ThisPA#" - aborting
						<cfabort>
					</cfif>
				</cfoutput>
			</td>
		</tr>
	</table>		
<cfif QPitchAvailable.RecordCount IS "0">
	<cfif ThisPA IS "Venue">
		<span class="pix13bold">No Teams have been associated with this Venue</span>
	<cfelseif ThisPA IS "Team">
		<span class="pix13bold">No Venues have been associated with this Team</span>
	<cfelse>
		<cfoutput>#CGI.Script_Name# - ThisPA is "#ThisPA#" - aborting</cfoutput> 
		<cfabort>
	</cfif>
<cfelse>
	<cfif StructKeyExists(session,"BookingDate")>
		<cflock scope="session" timeout="10" type="readonly">
			<cfset request.BookingDate = session.BookingDate >
		</cflock>
	<cfelse>
		<cfset request.BookingDate = CreateDate(1900,1,1) >
	</cfif>
	<cfset ThisColSpan = 6 >
	<table width="80%" border="1" align="center" cellpadding="3" cellspacing="0" class="loggedinScreen">
		<tr class="bg_white">
			<cfoutput>
			<td colspan="#ThisColSpan#">
				<span class="pix13bold">#QPitchAvailable.RecordCount# in list</span>
			</td>
			</cfoutput>
		</tr>
		<cfoutput>
		<input type="Hidden" name="NoOfRows" value="#QPitchAvailable.RecordCount#" >
		</cfoutput>
		<cfif ThisPA IS "Venue">
			<cfoutput><input type="Hidden" name="VenueID" value="#ThisVenueID#"></cfoutput>
			<tr>
				<cfoutput><td height="40" colspan="#ThisColSpan#" align="center"><span class="pix13boldnavy">#GetVenueDescription.VenueDescription#</span></td></cfoutput>
			</tr>
		</cfif>
		<cfif ThisPA IS "Team">
			<cfoutput><input type="Hidden" name="TeamIDOrdinalID" value="#ThisTeamID#^#ThisOrdinalID#"></cfoutput>
			<tr>
				<cfoutput><td height="40" colspan="#ThisColSpan#" align="center"><span class="pix13boldnavy">#GetTeamOrdinalDescription.TeamOrdinalDescription#</span></td></cfoutput>
			</tr>
		</cfif>
		<tr>
			<!--- <td width="10" align="center"> <span class="pix13bold">Select</span></td> --->
			<cfoutput>
					<cfif ThisPA IS "Venue">
						<td>&nbsp;</td>
						<td align="center"><span class="pix13">Status</span></td>
						<td><span class="pix13">Date</span></td>
						<td align="center"><span class="pix13">Pitch</span></td>
						<td><span class="pix13">Team</span></td>
						<td><span class="pix13bold">&nbsp;</span></td>
					<cfelseif ThisPA IS "Team">
						<td>&nbsp;</td>
						<td align="center"><span class="pix13">Status</span></td>
						<td><span class="pix13">Date</span></td>
						<td align="center"><span class="pix13">Pitch</span></td>
						<td><span class="pix13">Venue</span></td>
						<td><span class="pix13bold">&nbsp;</span></td>
					<cfelse>
						#CGI.Script_Name# - ThisPA is "#ThisPA#" - aborting
						<cfabort>
					</cfif>
			</cfoutput>
		</tr>
		<cfset ThisPitchNoID = 0>
		<cfset ThisPitchStatusID = 0>
		<cfset ThisVenueID = 0 >
		<cfset ThisTeamID = 0 >
		<cfset ThisOrdinalID = 0>
		<cfset ThisBookingDate = CreateDate(1900,1,1) >
		<cfoutput query="QPitchAvailable">
			<cfset DuplicateDetails = "No">
			<cfset DuplicatePitch = "No">
			<cfif PNID IS ThisPitchNoID AND HTID IS ThisTeamID AND HOID IS ThisOrdinalID AND BookingDate IS ThisBookingDate>
				<cfset DuplicateDetails = "Yes">
			<cfelseif PNID IS ThisPitchNoID AND BookingDate IS ThisBookingDate>
				<cfset DuplicatePitch = "Yes">
			<cfelse>
			</cfif>
			
			<CFSWITCH expression="#xtype#">





				<CFCASE VALUE="c">    <!--- pitch bookings with no matching fixtures --->
			<tr <cfif StructKeyExists(url, "ThisFixtureDate") AND QPitchAvailable.BookingDate IS ThisFixtureDate>bgcolor="white"</cfif> >
				<!--- Select check box --->
				<cfif StructKeyExists(form, "Button") AND form.Button IS "Tick All">
					<td width="10" align="center">
						<input name="L#CurrentRow#" type="checkbox" value="#HID#" checked >
					</td>
				<cfelseif StructKeyExists(form, "Button") AND form.Button IS "Untick All">
					<td width="10" align="center">
						<input name="L#CurrentRow#" type="checkbox" value="#HID#" >
					</td>
				<cfelse>
					<td width="10" align="center">
						<input name="L#CurrentRow#" type="checkbox" value="#HID#" >
					</td>
				</cfif>
				<!--- Pitch Status --->
					<td align="center" <cfif PitchStatus GT 1>bgcolor="pink"</cfif>>
						<span class="pix13"><cfif PitchStatus IS "">Unspecified<cfelse>#PitchStatus#</cfif></span>
					</td>
				
				<!--- Date --->
				<input type="Hidden" name="BD#CurrentRow#" value="#BookingDate#" >
				<td>
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td align="center" bgcolor="lightgreen"><span class="pix10boldnavy">No home fixture</span></td>
						</tr>
						<tr>
							<td>
								<a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(BookingDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#&fmTeamID=#HTID#"><span class="pix13">#DateFormat(BookingDate, 'DDDD, DD MMMM YYYY')#</span></a>
					<cfif DuplicateDetails IS "Yes"><span class="pix13boldred"><br />DUPLICATE</span></cfif>
					<cfif DuplicatePitch IS "Yes"><span class="pix13boldred"><br />WARNING - Same Date and Pitch</span></cfif>
							</td >
						</tr>
					</table>
				</td >
				<!--- Pitch --->
					<td align="center"><span class="pix13"><cfif PitchName IS "">Unspecified<cfelse>#PitchName#</cfif></span></td>
				<cfif ThisPA IS "Venue">
					<!--- Team Link --->
					<td><a href="PitchAvailableList.cfm?TblName=#TblName#&TeamID=#HTID#&OrdinalID=#HOID#&LeagueCode=#LeagueCode#&PA=Team&month_to_view=#Month(BookingDate)#&year_to_view=#Year(BookingDate)#"><span class="pix13">#TeamName# #OrdinalName#</span></a></td>
				<cfelseif ThisPA IS "Team">
					<!--- Venue Link --->
					<td><a href="PitchAvailableList.cfm?TblName=#TblName#&VenueID=#HVID#&LeagueCode=#LeagueCode#&PA=Venue&year_to_view=#Year(BookingDate)#&month_to_view=#Month(BookingDate)#"><span class="pix13">#VenueName#</span></a></td>
				<cfelse>
					#CGI.Script_Name# - ThisPA is "#ThisPA#" - aborting
					<cfabort>
				</cfif>
				<cfif ThisPA IS "Venue">
					<!--- Upd/Del --->
					<td align="center"> 
						<a href="UpdateForm.cfm?TblName=PitchAvailable&id=#HID#&TeamID=#HTID#&OrdinalID=#HOID#&VenueID=#HVID#&PitchNoID=#PNID#&PitchStatusID=#PSID#&LeagueCode=#LeagueCode#&PA=#ThisPA#&FixtureDate=#DateFormat(BookingDate,'YYYY-MM-DD')#">   
						<span class="pix10">Upd/Del</span></a>
					</td>
				<cfelseif ThisPA IS "Team">
					<!--- Upd/Del --->
					<td align="center"> 
						<a href="UpdateForm.cfm?TblName=PitchAvailable&id=#HID#&TeamID=#HTID#&OrdinalID=#HOID#&VenueID=#HVID#&PitchNoID=#PNID#&PitchStatusID=#PSID#&LeagueCode=#LeagueCode#&PA=#ThisPA#&FixtureDate=#DateFormat(BookingDate,'YYYY-MM-DD')#&year_to_view=#Year(BookingDate)#&month_to_view=#Month(BookingDate)#">   
						<span class="pix10">Upd/Del</span></a>
					</td>
				<cfelse>
					#CGI.Script_Name# - xxxxxxxx ThisPA is "#ThisPA#" - aborting
					<cfabort>
				</cfif>
				

				<cfset ThisPitchNoID = PNID>
				<cfset ThisPitchStatusID = PSID>
				<cfset ThisTeamID = HTID >
				<cfset ThisOrdinalID = HOID>
				<cfset ThisBookingDate = BookingDate >
			</tr>
				</CFCASE>
				
				
				
				
				<CFCASE VALUE="a">    <!--- matching fixtures and pitch bookings  --->
			<tr  <!---<cfif QPitchAvailable.BookingDate IS request.BookingDate>bgcolor="silver"</cfif> ---> <cfif StructKeyExists(url, "ThisFixtureDate") AND QPitchAvailable.BookingDate IS ThisFixtureDate>bgcolor="white"</cfif> <!---<cfif PitchStatus IS " OK"><cfelse>bgcolor="pink"</cfif>--->  >
				<!--- Select check box --->
				<cfif StructKeyExists(form, "Button") AND form.Button IS "Tick All">
					<td width="10" align="center">
						<input name="L#CurrentRow#" type="checkbox" value="#HID#" checked >
					</td>
				<cfelseif StructKeyExists(form, "Button") AND form.Button IS "Untick All">
					<td width="10" align="center">
						<input name="L#CurrentRow#" type="checkbox" value="#HID#" >
					</td>
				<cfelse>
					<td width="10" align="center">
						<input name="L#CurrentRow#" type="checkbox" value="#HID#" >
					</td>
				</cfif>
				<!--- Pitch Status --->
					<td align="center">
						<span class="pix13"><cfif PitchStatus IS "">Unspecified<cfelse>#PitchStatus#</cfif></span>
					</td>
				
				<!--- Date --->
				<input type="Hidden" name="BD#CurrentRow#" value="#BookingDate#" >
				<td>
					<a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(BookingDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#&fmTeamID=#HTID#"><span class="pix13">#DateFormat(BookingDate, 'DDDD, DD MMMM YYYY')#</span></a>
					<cfif DuplicateDetails IS "Yes"><span class="pix13boldred"><br />DUPLICATE</span></cfif>
					<cfif DuplicatePitch IS "Yes"><span class="pix13boldred"><br />WARNING - Same Date and Pitch</span></cfif>
				</td >
				<!--- Pitch --->
					<td align="center"><span class="pix13"><cfif PitchName IS "">Unspecified<cfelse>#PitchName#</cfif></span></td>
				<cfif ThisPA IS "Venue">
					<!--- Team Link --->
					<td><a href="PitchAvailableList.cfm?TblName=#TblName#&TeamID=#HTID#&OrdinalID=#HOID#&LeagueCode=#LeagueCode#&PA=Team&month_to_view=#Month(BookingDate)#&year_to_view=#Year(BookingDate)#"><span class="pix13">#TeamName# #OrdinalName#</span></a></td>
				<cfelseif ThisPA IS "Team">
					<!--- Venue Link --->
					<td><a href="PitchAvailableList.cfm?TblName=#TblName#&VenueID=#HVID#&LeagueCode=#LeagueCode#&PA=Venue"><span class="pix13">#VenueName#</span></a></td>
				<cfelse>
					#CGI.Script_Name# - ThisPA is "#ThisPA#" - aborting
					<cfabort>
				</cfif>
				<cfif ThisPA IS "Venue">
					<!--- Upd/Del --->
					<td align="center"> 
						<a href="UpdateForm.cfm?TblName=PitchAvailable&id=#HID#&TeamID=#HTID#&OrdinalID=#HOID#&VenueID=#HVID#&PitchNoID=#PNID#&PitchStatusID=#PSID#&LeagueCode=#LeagueCode#&PA=#ThisPA#&FixtureDate=#DateFormat(BookingDate,'YYYY-MM-DD')#">   
						<span class="pix10">Upd/Del</span></a>
					</td>
				<cfelseif ThisPA IS "Team">
					<!--- Upd/Del --->
					<td align="center"> 
						<a href="UpdateForm.cfm?TblName=PitchAvailable&id=#HID#&TeamID=#HTID#&OrdinalID=#HOID#&VenueID=#HVID#&PitchNoID=#PNID#&PitchStatusID=#PSID#&LeagueCode=#LeagueCode#&PA=#ThisPA#&FixtureDate=#DateFormat(BookingDate,'YYYY-MM-DD')#&year_to_view=#Year(BookingDate)#&month_to_view=#Month(BookingDate)#">   
						<span class="pix10">Upd/Del</span></a>
					</td>
				<cfelse>
					#CGI.Script_Name# - xxxxxxxx ThisPA is "#ThisPA#" - aborting
					<cfabort>
				</cfif>
				

				<cfset ThisPitchNoID = PNID>
				<cfset ThisPitchStatusID = PSID>
				<cfset ThisTeamID = HTID >
				<cfset ThisOrdinalID = HOID>
				<cfset ThisBookingDate = BookingDate >
			</tr>
				
				</CFCASE>
				
				
				
				
				
				
				
				
				
				
				<CFCASE VALUE="b">    <!--- fixtures without a pitch booking  --->

			<tr  <!---<cfif QPitchAvailable.BookingDate IS request.BookingDate>bgcolor="silver"</cfif> ---> <cfif StructKeyExists(url, "ThisFixtureDate") AND QPitchAvailable.BookingDate IS ThisFixtureDate>bgcolor="white"</cfif> <!---<cfif PitchStatus IS " OK"><cfelse>bgcolor="pink"</cfif>--->  >
				<!--- Select check box --->
				<cfif StructKeyExists(form, "Button") AND form.Button IS "Tick All">
					<td width="10" align="center">
						<input name="L#CurrentRow#" type="checkbox" value="#HID#" disabled >
					</td>
				<cfelseif StructKeyExists(form, "Button") AND form.Button IS "Untick All">
					<td width="10" align="center">
						<input name="L#CurrentRow#" type="checkbox" value="#HID#" disabled>
					</td>
				<cfelse>
					<td width="10" align="center">
						<input name="L#CurrentRow#" type="checkbox" value="#HID#" disabled >
					</td>
				</cfif>
				<!--- Pitch Status --->
					<td align="center">
						<span class="pix13">&nbsp;</span>
					</td>
				
				<!--- Date --->
				<input type="Hidden" name="BD#CurrentRow#" value="#BookingDate#" >
				<td>
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td align="center" bgcolor="lightgreen"><span class="pix10boldnavy">[venue not specified]</span></td>
						</tr>
						<tr>
							<td>
								<a href="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(BookingDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#&fmTeamID=#HTID#"><span class="pix13">#DateFormat(BookingDate, 'DDDD, DD MMMM YYYY')#</span></a>
								<cfif DuplicateDetails IS "Yes"><span class="pix13boldred"><br />DUPLICATE</span></cfif>
								<cfif DuplicatePitch IS "Yes"><span class="pix13boldred"><br />WARNING - Same Date and Pitch</span></cfif>
							</td>
						</tr>
					</table>
				</td >
				<!--- Pitch --->
					<td align="center"><span class="pix13">&nbsp;</span></td>
				<cfif ThisPA IS "Venue">
					<!--- Team Link --->
					<td><a href="PitchAvailableList.cfm?TblName=#TblName#&TeamID=#HTID#&OrdinalID=#HOID#&LeagueCode=#LeagueCode#&PA=Team&month_to_view=#Month(BookingDate)#&year_to_view=#Year(BookingDate)#"><span class="pix13">#TeamName# #OrdinalName#</span></a></td>
				<cfelseif ThisPA IS "Team">
					<!--- Venue Link --->
					<td><span class="pix13">&nbsp;</span></a></td>
				<cfelse>
					#CGI.Script_Name# - ThisPA is "#ThisPA#" - aborting
					<cfabort>
				</cfif>
				<cfif ThisPA IS "Venue">
					<!--- Upd/Del --->
					<td align="center"> 
						<a href="UpdateForm.cfm?TblName=PitchAvailable&id=#HID#&TeamID=#HTID#&OrdinalID=#HOID#&VenueID=#HVID#&PitchNoID=#PNID#&PitchStatusID=#PSID#&LeagueCode=#LeagueCode#&PA=#ThisPA#&FixtureDate=#DateFormat(BookingDate,'YYYY-MM-DD')#">   
						<span class="pix10">Upd/Del</span></a>
					</td>
				<cfelseif ThisPA IS "Team">
					<!--- Add --->
					<td align="center"><a href="UpdateForm.cfm?TblName=PitchAvailable&LeagueCode=#LeagueCode#&VenueID=#QTeamDetails.VenueID#&TeamID=#HeadingTeamID#&OrdinalID=#HeadingOrdinalID#&PA=#ThisPA#&PitchNoID=#QTeamDetails.PitchNoID#&PitchStatusID=0&FixtureDate=#DateFormat(BookingDate,'YYYY-MM-DD')#"><span class="pix10">Add</span></a></td>
				
				<cfelse>
					#CGI.Script_Name# - xxxxxxxx ThisPA is "#ThisPA#" - aborting
					<cfabort>
				</cfif>
				

				<cfset ThisPitchNoID = PNID>
				<cfset ThisPitchStatusID = PSID>
				<cfset ThisTeamID = HTID >
				<cfset ThisOrdinalID = HOID>
				<cfset ThisBookingDate = BookingDate >
			</tr>
			</CFCASE>
		</CFSWITCH>
			
			
		</cfoutput>

		<cfset StructDelete(session, "BookingDate")>
		
		<cfoutput>
			<cfif ThisPA IS "Venue">
				<tr>
					<td colspan="#ThisColSpan#">
					<input type="Submit" name="Button" value="Delete Ticked">
					<input type="Submit" name="Button" value="Tick All">
					<input type="Submit" name="Button" value="Untick All">
					</td>
				</tr>
			<cfelseif ThisPA IS "Team">
				<tr>
					<td colspan="#ThisColSpan#">
					<input type="Submit" name="Button" value="Delete Ticked">
					<input type="Submit" name="Button" value="Tick All">
					<input type="Submit" name="Button" value="Untick All">
					</td>
				</tr>
			<cfelse>
				#CGI.Script_Name# - ThisPA is "#ThisPA#" - aborting
				<cfabort>
			</cfif>
		</cfoutput>
	</table>
</cfif>
<cfoutput>
<input type="Hidden" name="LeagueCode" value="#LeagueCode#" >
<input type="Hidden" name="PA" value="#ThisPA#" >
</cfoutput>
</form>
<br><br><br><br><br><br><br><br><br><br><br><br>