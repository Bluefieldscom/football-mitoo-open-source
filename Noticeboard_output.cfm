<table border="1" align="left" cellpadding="10" cellspacing="0" width="800">
	<cfoutput>
		<tr>
			<td width="800" colspan="3" rowspan="1" align="center" bgcolor="##EEEEEE" >
				<span class="pix14bold">#AdvertTitle#<BR></span>
				<span class="pix9">posted #DateFormat(StartDate, 'D MMMM YYYY')# &##8226; expires #DateFormat(EndDate, 'D MMMM YYYY')#</span>
			</td>
		</tr>
		<tr>
			<td width="150" colspan="1" rowspan="1" align="center" bgcolor="white">
				<span class="pix10">#ImageFile#</span>
			</td>
			<td width="500" colspan="1" rowspan="1" align="justify" bgcolor="white">
				<span class="pix10">#AdvertHTML#</span>
			</td>
			<td width="150" colspan="1" rowspan="1" align="center" bgcolor="white">
				<span class="pix10">
				<cfif ContactName IS ""><cfelse>Contact: #ContactName#<BR><BR></cfif>
				<cfif TelephoneNumbers IS ""><cfelse>Tel: #TelephoneNumbers#<BR><BR></cfif>
				<cfif EmailAddr IS ""><cfelse>Email: <a href="mailto:#EmailAddr#?subject=#AdvertTitle# (on football.mitoo)">#EmailAddr#</a></cfif>
				</span>
			</td>
		</tr>
	</cfoutput>
</table>
<div align="center">&nbsp;</div>   
