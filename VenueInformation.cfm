<link href="fmstyle.css" rel="stylesheet" type="text/css">
<table border="0" width="100%" align="center" cellpadding="5" cellspacing="0">
	<cfinclude template="queries/qry_QThisVenue.cfm">
	<cfoutput query="QThisVenue">
		<tr>
			<td colspan="2" align="center" bgcolor="silver"><span class="pix18bold">#VenueDescription#</span></td>
		</tr>
		<tr>
			<td><span class="pix13">#AddressLine1#<cfif Len(Trim(AddressLine2)) GT 0><br />#AddressLine2#</cfif><cfif Len(Trim(AddressLine3)) GT 0><br />#AddressLine3#</cfif><br />#Postcode#</span></td>
			<td align="right">
				<CFSWITCH expression="#CompassPoint#">
					<CFCASE VALUE=1>
						<img src="gif/CompassGridC.gif" width="90" height="90" border="0" align="absmiddle">
					</CFCASE>
					<CFCASE VALUE=2>
						<img src="gif/CompassGridN.gif" width="90" height="90" border="0" align="absmiddle">
					</CFCASE>
					<CFCASE VALUE=3>
						<img src="gif/CompassGridNE.gif" width="90" height="90" border="0" align="absmiddle">
					</CFCASE>
					<CFCASE VALUE=4>
						<img src="gif/CompassGridE.gif" width="90" height="90" border="0" align="absmiddle">
					</CFCASE>
					<CFCASE VALUE=5>
						<img src="gif/CompassGridSE.gif" width="90" height="90" border="0" align="absmiddle">
					</CFCASE>
					<CFCASE VALUE=6>
						<img src="gif/CompassGridS.gif" width="90" height="90" border="0" align="absmiddle">
					</CFCASE>
					<CFCASE VALUE=7>
						<img src="gif/CompassGridSW.gif" width="90" height="90" border="0" align="absmiddle">
					</CFCASE>
					<CFCASE VALUE=8>
						<img src="gif/CompassGridW.gif" width="90" height="90" border="0" align="absmiddle">
					</CFCASE>
					<CFCASE VALUE=9>
						<img src="gif/CompassGridNW.gif" width="90" height="90" border="0" align="absmiddle">
					</CFCASE>
				</cfswitch>
			</td>
		</tr>
		<tr>
			<cfif VenueTel IS "">
				<td colspan="2"><span class="pix13">telephone number not available</span></td>
			<cfelse>
				<td colspan="2"><span class="pix13">#VenueTel#</span></td>
		</cfif>
		</tr>
		<tr>
			<cfif MapURL IS "">
				<td colspan="2"><span class="pix13">map not available</span></td>
			<cfelse>
				<td colspan="2"><span class="pix13"><a href="#MapURL#" target="_blank">see map</a></span></td>
			</cfif>
		</tr>
		<tr>
			<td colspan="2"><span class="pix13">#Notes#</span></td>
		</tr>

	</cfoutput>
</table>
