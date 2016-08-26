<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfinclude template="InclBegin.cfm">
<FORM ACTION="SearchAction.cfm" METHOD="POST">
	<cfif TblName IS "Player">
		<table>
			<tr>
				<td align="left"><span class="pix13bold">Enter a string that will appear anywhere in the name</span></td>
				<td align="left"><input type="Text" name="Name" size="30" maxlength="50"></td>
			</tr>
			<tr>
				<td align="left" colspan="2"><span class="pix13bold">OR</span></td>
			</tr>
			<tr>
				<td align="left"><span class="pix13bold">Enter the unique player number</span></td>
				<td align="left"><input name="PlayerRegNo" type="text" size="8" maxlength="8"></td>
			</tr>
			<cfif FANPlayerRegNo IS "1">
				<INPUT type="Hidden" NAME="FAN" VALUE="">
			<cfelse>
				<tr>
					<td align="left" colspan="2"><span class="pix13bold">OR</span></td>
				</tr>
				
				<tr>
					<td align="left"><span class="pix13bold">Enter the FAN</span></td>
					<td align="left"><input name="FAN" type="text" size="8" maxlength="8"></td>
				</tr>
			</cfif>
			<tr>
				<td align="left" height="100"></td>
				<td align="left"><input type="Submit" name="SubmitButton" value="Search" ></td>
			</tr>
		</table>
	<cfelseif TblName IS "Noticeboard">
		<span class="pix13bold"><br />Enter a string that will appear anywhere in the Advert Title</span> 
		<INPUT type="Text" NAME="LongCol" size="30" maxlength="50">
		<input type="Submit" name="SubmitButton" value="Search" >
		<input type="Submit" name="SubmitButton" value="Search Old" >
	<cfelse>
		<span class="pix13bold"><br />Enter a string that will appear anywhere in the name</span> 
		<INPUT type="Text" NAME="LongCol" size="30" maxlength="50">
		<input type="Submit" name="SubmitButton" value="Search" >
	</cfif>
	<INPUT type="Hidden" NAME="TblName" VALUE="<cfoutput>#TblName#</cfoutput>">
	<INPUT type="Hidden" NAME="LeagueCode" VALUE="<cfoutput>#LeagueCode#</cfoutput>">
</FORM>
