<link href="fmstyle.css" rel="stylesheet" type="text/css">
<cflock scope="session" timeout="10" type="readonly">
	<cfset request.SportsmanshipMarksOutOfHundred = session.SportsmanshipMarksOutOfHundred>
</cflock> 

<!--- Check maximum marks not exceeded, 10 or 100 for each club --->
<cfif Form.HomeSportsmanshipMarks IS NOT "">
	<cfif request.SportsmanshipMarksOutOfHundred IS "1" >
		<cfif Form.HomeSportsmanshipMarks GT 100 >
			<cfoutput>
				<span class="pix24boldred">
					Home Team has been given #form.HomeSportsmanshipMarks# marks! Maximum is 100<BR><BR>
					Press the Back button on your browser.....
				</span>
			<CFABORT>
			</cfoutput>
		</cfif>
	<cfelse>
		<cfif Form.HomeSportsmanshipMarks GT 10 >
			<cfoutput>
				<span class="pix24boldred">
					Home Team has been given #form.HomeSportsmanshipMarks# marks! Maximum is 10<BR><BR>
					Press the Back button on your browser.....
				</span>
			<CFABORT>
			</cfoutput>
		</cfif>
	</cfif>
</cfif>

<cfif Form.AwaySportsmanshipMarks IS NOT "">
	<cfif request.SportsmanshipMarksOutOfHundred IS "1" >
		<cfif Form.AwaySportsmanshipMarks GT 100 >
			<cfoutput>
				<span class="pix24boldred">
					Away Team has been given #form.AwaySportsmanshipMarks# marks! Maximum is 100<BR><BR>
					Press the Back button on your browser.....
				</span>
			<CFABORT>
			</cfoutput>
		</cfif>
	<cfelse>
		<cfif Form.AwaySportsmanshipMarks GT 10 >
			<cfoutput>
				<span class="pix24boldred">
					Away Team has been given #form.AwaySportsmanshipMarks# marks! Maximum is 10<BR><BR>
					Press the Back button on your browser.....
				</span>
			<CFABORT>
			</cfoutput>
		</cfif>
	</cfif>
</cfif>
