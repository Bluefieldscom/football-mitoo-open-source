<!---
*******************************
* "Add" & "Add many" Buttons *
*******************************
--->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<cfif ListFindNoCase( "Player,Matches,MatchReport,PitchAvailable,Committee", TblName ) GT 0 >
			<td align="CENTER">
				<input type="Submit" name="Operation" value="Add">
			</td>
		<cfelse>
			<td width = "30%" >
			</td>
			<td width = "20%" align="CENTER">
				<input type="Submit" name="Operation" value="Add">
			</td>
			<td width = "20%" align="CENTER">
				<input type="Submit" name="Operation" value="Add many">
			</td>
			<td width = "30%">
			</td>
		</cfif>
		</td>
	</tr>
</table>
