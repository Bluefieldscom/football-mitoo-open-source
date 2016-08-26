<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
<cfelse>
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<cfset BatchInput = "Yes">

<cfinclude template="InclBegin.cfm">


<FORM ACTION="BatchUpdate.cfm" METHOD="POST">
<!---
									*********************
									* Batch Input Area  *
									*********************
--->
<cfoutput>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td colspan="2" align="center"><span class="pix10">Paste your selection into the area below</span></td>
	</tr>
	<tr align="CENTER">
		<td colspan="2"><textarea name="BatchInput" cols="80" rows="10" wrap="OFF"></textarea></td>
	</tr>
	<tr>
		<td colspan="1" height="50" align="center">
		<input type="Submit" name="Operation" value="Submit">
		</td>
		<td colspan="1" height="50" align="center">
		<input type="Reset" name="Operation" value="Clear">
		</td>
	</tr>
</table>
	<input type="Hidden" name="LeagueCode" value="#LeagueCode#">
	<input type="Hidden" name="LeagueID" value="#request.LeagueID#">
	
</cfoutput>
</FORM>
