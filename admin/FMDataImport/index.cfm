<!---
index.cfm
Purpose:	Main application start
Created:	13 July 2004
By:			Terry Riley
Calls:		queries/qry_setAppVars.cfm
			queries/qry_checkTarget.cfm
			header.cfm
			footer.cfm
Links to:	index2.cfm
Notes:		self-referential on Continue
--->

<!--- prevent cross-year imports, except 03 to 04 --->
<cfif IsDefined("form.action")>
	<cfif (form.to_year GT form.from_year 
		AND form.from_year NEQ '2003') OR (form.from_year GT form.to_year)>
		<cfinclude template="header.cfm">
		<p>
		<span class="textred">This does not compute!</span> 
		<br /><br />
		<cfoutput>You can't import from <strong>#form.from_year#</strong> to <strong>#form.to_year#</strong>.</cfoutput>
		<br /><br />Please start again <a href="index.cfm">here</a>
		<cfinclude template="footer.cfm">
		<cfabort>
	</cfif>

	<cfinclude template="queries/qry_setAppVars.cfm">
	
	<cfinclude template="queries/qry_checktarget.cfm">

	<cfif variables.targetexists IS 1>

		<cfinclude template="header.cfm">
		<p>
		<cfoutput><strong>#application.DSN#</strong></cfoutput> is registered with CFAdmin.
		<p>
		(To be included, any MDB to be imported <strong>must</strong> be registered as a DSN with ColdFusion)
		<br /><br />
		<strong>Current settings:</strong><br /><br />
		<cfoutput>
			Year to import from:&nbsp;#application.year#<br />
			Year to import to:&nbsp;#application.newyear#<br />
			<cfif application.year NEQ application.newyear>
			New Season Name:&nbsp;#application.newseasonname#<br />
			Season Starts:&nbsp;#application.newseasonstartdate#<br />
			Season Ends:&nbsp;#application.newseasonenddate#
			</cfif>
		</cfoutput>
		</p>
		<p>
		<a href="index.cfm">Return to re-set variables</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="index2.cfm">Continue</a>
		</p>
	<cfelse>
		<!-- error to signify fmxxxx is not registered -->
		<p>The target database <cfoutput><strong>#application.DSN#</strong></cfoutput> does not exist, or is not registered with CFAdmin.<br /><br />
		Please set it up before proceeding.<br /><br />
		<a href="index.cfm">Return to re-set variables</a>
		</p>
		<cfinclude template="footer.cfm"><cfabort>
	</cfif>	
	
<cfelse>
	
	<cfinclude template="header.cfm">

	<p>
Select the from and to years below, then 'Continue'. The only 'uplift' you can do is from xxx03.mdb to fm2004. Any such imports will automatically have seasonname and start/end dates added.
	</p>
	<form action="" method="post">
		<table>
			<tr>
				<td>Import From:</td><td>
				<select name="from_year">
					<option value="1999" <cfif application.year IS '1999'>selected</cfif> >1999</option>
					<option value="2000" <cfif application.year IS '2000'>selected</cfif> >2000</option>
					<option value="2001" <cfif application.year IS '2001'>selected</cfif> >2001</option>
					<option value="2002" <cfif application.year IS '2002'>selected</cfif> >2002</option>
					<option value="2003" <cfif application.year IS '2003'>selected</cfif> >2003</option>
					<option value="2004" <cfif application.year IS '2004'>selected</cfif> >2004</option>
				</select>
				</td>
				<td>&nbsp;&nbsp;To:</td><td>
				<select name="to_year">
					<option value="1999" <cfif application.newyear IS '1999'>selected</cfif> >1999</option>
					<option value="2000" <cfif application.newyear IS '2000'>selected</cfif> >2000</option>
					<option value="2001" <cfif application.newyear IS '2001'>selected</cfif> >2001</option>
					<option value="2002" <cfif application.newyear IS '2002'>selected</cfif> >2002</option>
					<option value="2003" <cfif application.newyear IS '2003'>selected</cfif> >2003</option>
					<option value="2004" <cfif application.newyear IS '2004'>selected</cfif> >2004</option>
				</select>
				</td>
			</tr>	
			<tr><td colspan=2>&nbsp;</td></tr>		
			<tr><td colspan=2><input type="submit" name="action" value=" Continue ">
		</table>
	</form>

</cfif>

<cfinclude template="footer.cfm">
