<!---
*******************************
* "Update" & "Delete" Buttons *
*******************************
--->

<cfparam name="request.showdelete" default="1">

<table width="100%" border="0" cellspacing="0" cellpadding="0" align="CENTER">
	<tr>
		<td align="CENTER">
			<INPUT TYPE="Submit" NAME="Operation" VALUE="Update">
		</td>
		<cfif request.showdelete IS 1>
		<td align="CENTER">
			<INPUT TYPE="Submit" NAME="Operation" VALUE="Delete">
		</td>
		<cfelse>
		<td align="CENTER">
			<INPUT TYPE="Submit" NAME="Operation" VALUE="Delete" disabled="disabled">
		</td>		
		</cfif>
	</tr>
</table>

