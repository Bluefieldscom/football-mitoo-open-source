<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cfabort>
</cfif>
<link href="fmstyle.css" rel="stylesheet" type="text/css">
<table border="1" align="center" cellpadding="5" cellspacing="0">
	<cfinclude template="queries/qry_QRefereeCards.cfm">
	<tr>
		<td colspan="3" align="center"><cfoutput><span class="pix18bold">Cautions & Sendings Off<br>#DateFormat(ThisDate, 'DDDD, DD MMMM YYYY')#</span></cfoutput></td>
	</tr>
	
	<tr>
		<td colspan="2" align="center"><span class="pix10bold">Player</span></td>
		<td width="5" colspan="1" align="center"><span class="pix10bold">&nbsp;</span></td>
	</tr>
	<tr>
		<td align="right"><span class="pix10bold">Reg No</span></td>
		<td><span class="pix10bold">Name</span></td>
		<td><span class="pix10">&nbsp;</span></td>
		
	</tr>
	<cfoutput query="QRefereeCards" group="SortOrder">
		<tr>
		<td colspan="5" bgcolor="silver"><span class="pix13bold">#CompetitionName#</span></td>
		</tr>
		<cfoutput group="ClubName">
			<tr>
				<td colspan="1" align="left"  ><span class="pix10bold">#ClubName#</span></td>
				<td colspan="1" align="left"  ><span class="pix10boldnavy">#RefereeName#</span></td>
		<td><span class="pix10">&nbsp;</span></td>
			</tr>
			<cfoutput>
				<tr>
					<td align="right"><span class="pix10">#RegNo#</span></td>
					<td><span class="pix10"> #Forename# <strong>#Surname#</strong></span></td>
					<cfif CardValue IS 1>
						<td align="center" bgcolor="Yellow">
							<span class="pix13boldblack">Y</span>
						</td>
					<cfelseif CardValue IS 3>
						<td align="center" bgcolor="Red">
							<span class="pix13boldwhite">R</span>
						</td>
					<cfelseif CardValue IS 4>
						<td align="center" bgcolor="Orange">
							<span class="pix13boldblack">4</span>
						</td>
					<cfelse>
						<span class="pix13bold">ERROR</span>
					</cfif>
				</tr>
			</cfoutput>
		</cfoutput>
	</cfoutput>
</table>



