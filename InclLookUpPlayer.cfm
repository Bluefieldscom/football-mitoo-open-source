
<table width="100%" border="0" cellpadding="5" cellspacing="5" class="loggedinScreen">
<!--- Football Association Number (FAN) --->
	<tr >
		<td colspan="4">
			<table border="0" align="center" cellpadding="2" cellspacing="0">
				<tr>
					<td align="right" valign="middle" bgcolor="#EEEEEE">
						<span class="pix13boldnavy"><strong>FAN</strong></span>
					</td>
				
					<td align="left" bgcolor="#EEEEEE" >
					
					<cfif FANPlayerRegNo IS "1" AND RandomPlayerRegNo IS "No" >
						<input tabindex="13" type="hidden" name="FANGang" value="1">
						<cfif NewRecord IS "Yes" >
							<input name="FAN" tabindex="13" type="text" disabled="true" size="8" maxlength="8" >
						<cfelse>
							<cfoutput>
								<input name="FAN" tabindex="13" type="text" disabled="true" VALUE="#GetTblName.FAN#" size="8" maxlength="8" >
								<cfif GetTblName.FAN IS GetTblName.ShortCol>
								<cfelse>
								<span class="pix24boldred">ERROR - FAN and Player Registration Number must be the same. Aborting. Please contact us with this message immediately.</span>
								<cfabort>
								</cfif>
							</cfoutput>
						</cfif>
					<cfelse>
						<input tabindex="13" type="hidden" name="FANGang" value="0">
						<cfif NewRecord IS "Yes" >
							<cfinput tabindex="13" type="Text" name="FAN" size="8" maxlength="8" validate="integer" message="FAN MUST be all numeric (no letters allowed)" >
						<cfelse>
							<cfinput tabindex="13" type="Text" name="FAN" size="8" maxlength="8" validate="integer" message="FAN MUST be all numeric (no letters allowed)" VALUE="#GetTblName.FAN#">
						</cfif>
					</cfif>
					<span class="pix10navy"><strong>F</strong>ootball <strong>A</strong>ssociation <strong>N</strong>umber</span>
					</td>
				</tr>
				<cfif FANPlayerRegNo IS "1" AND RandomPlayerRegNo IS "No" >
				<cfelse>
					<tr>
						<td colspan="2"><span class="pix10navy">If you want <strong>FAN</strong> same as <strong>Player Registration Number</strong> please contact us.</span></td>
					</tr>
				</cfif>				
			</table>
		</td>
	</tr>

	<tr>
		<td align="left" valign="top">
		<span class="pix10navy">Surname</span>
		</td>
		<td align="left" valign="top">
			<input type="Text" tabindex="1" name="Surname" size="20" maxlength="20"	<cfif NewRecord IS "No">VALUE=<cfoutput>"#GetTblName.Surname#"</cfoutput></cfif> >
		</td>
		<!--- applies to season 2012 onwards only --->
		<cfif RIGHT(request.dsn,4) GE 2012>
			<td rowspan="3" align="left" valign="top">
				<table border="0" cellpadding="2" cellspacing="0" bgcolor="#EEEEEE">
					<tr>
						<td align="left" valign="top">
							<span class="pix10navy"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Address</span><br>
							<input type="Text" tabindex="8"  name="AddressLine1" size="40" maxlength="40"	<cfif NewRecord IS "No">VALUE=<cfoutput>"#GetTblName.AddressLine1#"</cfoutput></cfif> ><br>
							<input type="Text" tabindex="9" name="AddressLine2" size="40" maxlength="40"	<cfif NewRecord IS "No">VALUE=<cfoutput>"#GetTblName.AddressLine2#"</cfoutput></cfif> ><br>
							<input type="Text" tabindex="10" name="AddressLine3" size="40" maxlength="40"	<cfif NewRecord IS "No">VALUE=<cfoutput>"#GetTblName.AddressLine3#"</cfoutput></cfif> ><br>
							<input type="Text" tabindex="11" name="Postcode" size="10" maxlength="10"	<cfif NewRecord IS "No">VALUE=<cfoutput>"#GetTblName.Postcode#"</cfoutput></cfif> ><span class="pix10navy"> Postcode<br>Please use this area for the address and <b>remove from Notes</b><br><br></span>
							<span class="pix10navy">&nbsp;&nbsp;&nbsp;Email <input type="Text" tabindex="12" name="Email1" size="40" maxlength="80"	<cfif NewRecord IS "No">VALUE=<cfoutput>"#GetTblName.Email1#"</cfoutput></cfif> ></span>
						</td>
					</tr>
				</table>
			</td>
		</cfif>
	</tr>
	<tr>
		<td align="left">
		<span class="pix10navy">Forename(s)</span>
		</td>
		<td align="left">
			<input type="Text"  tabindex="2" name="Forename" size="35" maxlength="35"	<cfif NewRecord IS "No">VALUE=<cfoutput>"#GetTblName.Forename#"</cfoutput></cfif> >
		</td>	
	</tr>
 
 	<tr>
		<td align="left">
		<span class="pix10navy"> Date of Birth</span><cfif NewRecord IS "No"><br /><cfoutput><span class="pix10grey">#DateFormat(GetTblName.MediumCol, 'dd mmmm yyyy')#</span></cfoutput></cfif>
		</td>
		<cfif NewRecord IS "Yes">
			<td align="left">
				<table>
					<tr>
						<td><cfinput  tabindex="3" name="DOB_DD"    type="text"  size="1" maxlength="2" range="1,31" required="no" message="Day must be numeric in range 01 to 31" validate="integer">&nbsp;&nbsp;</td>
						<td><cfinput  tabindex="4" name="DOB_MM"    type="text"  size="1" maxlength="2" range="1,12" required="no" message="Month must be numeric in range 01 to 12" validate="integer">&nbsp;&nbsp;</td>
						<td><cfinput  tabindex="5" name="DOB_YYYY"  type="text"  size="4" maxlength="4" range="1900,#YEAR(Now())-6#" validate="integer" message="Year must be numeric in range 1900 to #YEAR(Now())-6#"></td>
					</tr>
					<tr>
						<td><span class="pix10navy">dd</span></td>
						<td><span class="pix10navy">mm</span></td>
						<td><span class="pix10navy">yyyy</span></td>
					</tr>
				</table>
			</td>
		<cfelse>
			<td align="left">
				<table>
					<tr>
						<td><cfinput  tabindex="3" name="DOB_DD"    type="text"    value="#DateFormat(GetTblName.MediumCol, 'DD')#" size="1" maxlength="2" range="1,31" required="no" message="Day must be numeric in range 01 to 31" validate="integer">&nbsp;&nbsp;</td>
						<td><cfinput  tabindex="4" name="DOB_MM"    type="text"    value="#DateFormat(GetTblName.MediumCol, 'MM')#" size="1" maxlength="2" range="1,12" required="no" message="Month must be numeric in range 01 to 12" validate="integer">&nbsp;&nbsp;</td>
						<td><cfinput  tabindex="5" name="DOB_YYYY"  type="text"    value="#DateFormat(GetTblName.MediumCol, 'YYYY')#" size="4" maxlength="4" range="1900,#YEAR(Now())-6#" validate="integer" message="Year must be numeric in range 1900 to #YEAR(Now())-6#"></td>
					</tr>
					<tr>
						<td><span class="pix10navy">dd</span></td>
						<td><span class="pix10navy">mm</span></td>
						<td><span class="pix10navy">yyyy</span></td>
					</tr>
					<cfif IsDate(GetTblName.MediumCol)>
					<cfset ThisAge = DateDiff( "YYYY",  GetTblName.MediumCol, Now() ) >
						<tr>
							<cfif ThisAge LT 16 AND DefaultYouthLeague IS "No" >
								<td height="20" colspan="3" align="center" bgcolor="red"><span class="pix10boldwhite"><cfoutput>WARNING: Age #ThisAge#</cfoutput></span></td>
							<cfelse> 
								<td height="20" colspan="3" align="center" bgcolor="white"><span class="pix10"><cfoutput>Age #ThisAge#</cfoutput></span></td>
							</cfif>
						</tr>
					</cfif>
				</table>
			</td>
		</cfif>
	</tr>
	
	<tr>
		<td align="left">
		<cfoutput>
		<cfif RandomPlayerRegNo IS "Yes">
			<span class="pix10navy">Unique <strong>Player Registration Number</strong><br>MUST be all numeric (no letters allowed)</span>
			<cfif NewRecord IS "Yes">
				<br />
				<span class="pix10boldred">This number has been generated automatically.<br />
				Please <a href="mailto:INSERT_EMAIL_HERE?subject=I do not want to have player registration numbers generated automatically [#LeagueCode#]">contact us</a> if you wish to disable this.</span>
			</cfif>
		<cfelse>
			<cfif FANPlayerRegNo IS "1" >
				<span class="pix10navy">Unique <strong>FAN &amp; Player Registration Number</strong><br>MUST be all numeric (no letters allowed)</span>
			<cfelse>
				<span class="pix10navy">Unique <strong>Player Registration Number</strong><br>MUST be all numeric (no letters allowed)</span>
				<cfif NewRecord IS "Yes">
					<br />
					<span class="pix10boldred">Do you want a number to be generated automatically?<br />
					Please <a href="mailto:INSERT_EMAIL_HERE?subject=I want to have player registration numbers generated automatically [#LeagueCode#]">contact us</a> if you wish to enable this.</span>
				</cfif>
			</cfif>
		</cfif>			
		</cfoutput>
		</td>
		<td align="left" colspan="3">
		
		<!--- special code added for leagues that want to automatically provide an unused player reg. no. --->
		<cfif RandomPlayerRegNo IS "Yes">
			<cfset ThisRandomPlayerRegNo = RandRange(1,99999) >
			<cfinclude template="queries/qry_UniquePlayerRegNo.cfm">
			<cfloop condition="QUniquePlayerRegNo.RecordCount GT 0">
				<cfset ThisRandomPlayerRegNo = RandRange(1,99999) >
				<cfinclude template="queries/qry_UniquePlayerRegNo.cfm">
			</cfloop>
		</cfif>
		
		<cfif NewRecord IS "Yes" AND RandomPlayerRegNo IS "No" >
			<cfinput type="Text" tabindex="6" name="ShortCol" size="8" maxlength="8" validate="integer" message="Unique Player Registration Number MUST be all numeric (no letters allowed)">
		<cfelseif NewRecord IS "Yes" AND RandomPlayerRegNo IS "Yes" > 
			<cfinput type="Text"  tabindex="6" name="ShortCol" size="8" maxlength="8" validate="integer" message="Unique Player Registration Number MUST be all numeric (no letters allowed)" VALUE="#ThisRandomPlayerRegNo#">
		<cfelse>
			<cfinput type="Text"  tabindex="6" name="ShortCol" size="8" maxlength="8" validate="integer" message="Unique Player Registration Number MUST be all numeric (no letters allowed)" VALUE="#GetTblName.ShortCol#">
		</cfif>
		</td>
		
	</tr>
 <!--- Notes --->
	<tr>
		<td align="left">
			<span class="pix10navy">Notes - Maximum 255 characters allowed. </span>
			<cfif NewRecord IS "No">
				<cfoutput><span class="pix13bold"><a href="LUList.cfm?LeagueCode=#LeagueCode#&TblName=Player&FirstNumber=#GetTblName.ShortCol#&LastNumber=#GetTblName.ShortCol#"><BR><BR>click here</a> to see more information</span></cfoutput>
			</cfif>
		</td>
		<td colspan="3"  align="left">
			<cfoutput>
			<cfif NewRecord IS "Yes">
				<TEXTAREA  tabindex="7" NAME="Notes" cols="80" WRAP="VIRTUAL" rows="2"></TEXTAREA>
			<cfelse>
				<TEXTAREA  tabindex="7" NAME="Notes" cols="80" WRAP="VIRTUAL" rows="2">#HTMLEditFormat(GetTblName.Notes)#</TEXTAREA>
			</cfif>
			</cfoutput>
		</td>
	</tr>
<cfif NewRecord IS "No">
	<tr>
		<cfinclude template="queries/qry_QSimilarSurnames.cfm">
		<cfif QSimilarSurnames.RecordCount GT 0>
			<td valign="top" align="left">
				<table border="1" cellpadding="4" cellspacing="0">
					<tr>
						<td align="left" colspan="5"><span class="pix10bold">Players with similar Surnames ...</span></td>
					</tr>
					<cfoutput query="QSimilarSurnames">
						<cfif shortcol IS GetTblName.shortcol >
							<tr class="bg_highlight">
								<td><span class="pix10bold">&nbsp;</span></td>
								<td align="left"><span class="pix10bold">#surname#</span></td>
								<td align="left"><span class="pix10bold">#forename#</span></td>
								<td align="center"><span class="pix10bold">#DateFormat(mediumcol, 'DD/MM/YYYY')#</span></td>
								<td align="right"><span class="pix10bold">#shortcol#</span></td>
							</tr>
						<cfelse>
							<tr>
								<td align="left"><a href="UpdateForm.cfm?TblName=Player&ID=#ID#&LeagueCode=#LeagueCode#"><span class="pix10">upd/del</span></a></td>
								<td align="left"><span class="pix10">#surname#</span></td>
								<td align="left"><span class="pix10">#forename#</span></td>
								<td align="center"><span class="pix10">#DateFormat(mediumcol, 'DD/MM/YYYY')#</span></td>
								<td align="right"><span class="pix10">#shortcol#</span></td>
							</tr>
						</cfif>
					</cfoutput>
				</table>
			</td>
		<cfelse>
			<td></td>			
		</cfif>
		<cfinclude template="queries/qry_QSameDOBs.cfm">
		<cfif QSameDOBs.RecordCount GT 0>
			<td valign="top">
				<table border="1" cellpadding="4" cellspacing="0">
					<tr>
						<td align="left" colspan="5"><span class="pix10bold">Players with the same Date of Birth ...</span></td>
					</tr>
					<cfoutput query="QSameDOBs">
						<cfif shortcol IS GetTblName.shortcol >
							<tr class="bg_highlight">
								<td align="left"><span class="pix10bold">&nbsp;</span></td>
								<td align="left"><span class="pix10bold">#surname#</span></td>
								<td align="left"><span class="pix10bold">#forename#</span></td>
								<td align="center"><span class="pix10bold">#DateFormat(mediumcol, 'DD/MM/YYYY')#</span></td>
								<td align="right"><span class="pix10bold">#shortcol#</span></td>
							</tr>
						<cfelse>
							<tr>
								<td align="left"><a href="UpdateForm.cfm?TblName=Player&ID=#ID#&LeagueCode=#LeagueCode#"><span class="pix10">upd/del</span></a></td>
								<td align="left"><span class="pix10">#surname#</span></td>
								<td align="left"><span class="pix10">#forename#</span></td>
								<td align="center"><span class="pix10">#DateFormat(mediumcol, 'DD/MM/YYYY')#</span></td>
								<td align="right"><span class="pix10">#shortcol#</span></td>
							</tr>
						</cfif>
					</cfoutput>
				</table>
			</td>
		<cfelse>
			<td></td>			
		</cfif>
	</tr>	
</cfif>	
</table>
