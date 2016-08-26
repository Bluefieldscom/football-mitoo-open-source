<CFQUERY NAME="GetTeam" datasource=#ODBC_DataSource#>
		SELECT
			ID,
			Long
		FROM
			Team
		WHERE ID NOT IN(SELECT ID FROM Team WHERE LEFT(Notes,7) = 'NoScore' OR Short = 'GUEST' )
		ORDER BY Long
</CFQUERY>

<table width="100%" border="0" cellspacing="0" cellpadding="15" bgcolor=<CFOUTPUT>#BG_Color#</CFOUTPUT> >
<tr>
	<td align="CENTER"><CFOUTPUT><font face="#Font_Face#" size="-2" >Please choose the Football Club from<BR>the dropdown list and then click on OK</font></cfoutput></td>
</tr>

<tr>
	<td align="CENTER">
		
		<select name="TeamID" size="1">
		<CFOUTPUT query="GetTeam" >
	    	<option value="#ID#" <CFIF GetTeam.ID IS #TeamID#>selected
				</cfif> >#Long#</option>
		</CFOUTPUT>
		</select>
		
		
	</td>
</tr>

<tr>
	<td align="CENTER">
		<INPUT TYPE="Submit" NAME="Operation" VALUE="OK">
	</td>
</tr>

</table>
