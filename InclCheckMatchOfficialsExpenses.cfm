<link href="fmstyle.css" rel="stylesheet" type="text/css">
	
<!--- Check Match Officials Expenses in range 0.00 to 999.99 --->
<cfif IsNumeric(Form.MatchOfficialsExpenses)>
	<cfif Form.MatchOfficialsExpenses LT 0>
		<cfoutput>
			<span class="pix24boldred">
				Match Officials Expenses must be numeric and in the range 0.00 to 999.99<br /><br />
				Press the Back button on your browser.....
			</span>
		</cfoutput>
		<cfabort>
	</cfif>
	<cfif Form.MatchOfficialsExpenses GT 999.99>
		<cfoutput>
			<span class="pix24boldred">
				Match Officials Expenses must be numeric and in the range 0.00 to 999.99<br /><br />
				Press the Back button on your browser.....
			</span>
		</cfoutput>
		<cfabort>
	</cfif>
<cfelseif TRIM(Form.MatchOfficialsExpenses) IS "">
<cfelse>
	<cfoutput>
		<span class="pix24boldred">
			Match Officials Expenses must be numeric and in the range 0.00 to 999.99<br /><br />
			Press the Back button on your browser.....
		</span>
	</cfoutput>
	<cfabort>
</cfif>
