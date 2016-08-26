<!--- Called by MtchDay.cfm --->
<cfinclude template="queries/qry_GetFreeDayH.cfm">
<cfif QGetFreeDayH.RecordCount IS 1>
	<tr>
		<td height="30" colspan="3" align="center" class="bg_pink"><span class="pix13bold">WARNING: Home team <img src="gif/unavailable.gif"></span></td><!--- FREE DAY --->
	</tr>
</cfif>
<cfinclude template="queries/qry_GetFreeDayA.cfm">
<cfif QGetFreeDayA.RecordCount IS 1>
	<tr>
		<td height="30" colspan="3" align="center" class="bg_pink"><span class="pix13bold">WARNING: Away team <img src="gif/unavailable.gif"></span></td><!--- FREE DAY --->
	</tr>
</cfif>
