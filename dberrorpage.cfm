<cfparam name="attributes.source" default="">
<cfparam name="attributes.errortype" default="">
<cfparam name="attributes.message" default="">

<cfif attributes.source IS "generic">
	<cfset request.message = "..... You tried to delete a record from the <cfoutput>#TblName#</cfoutput> table. This record has dependent records in other tables.">
<cfelse>
	<cfif attributes.source IS "Player">
		<cfif attributes.errortype IS "duplicatekey">
			<cfif attributes.message IS "indexno">
				<cfset request.message = "You tried to add a player with a number that is already in use.">
		<cfelse>
				<cfset request.message = "An existing player has the same name and date of birth. If there really are two players with the same name and date of birth then differentiate between them by modifying the name of the second player.">
		</cfif>
		<cfelseif attributes.errortype IS "baddata">
			<cfset request.message = "You tried to insert a record into the <cfoutput>#attributes.source#</cfoutput> table. One of the fields you tried to insert has an incorrect value (most likely a code number containing characters other than the digits 0 to 9).">		
		</cfif>
	<cfelseif attributes.source IS "TeamList">
		<cfif attributes.errortype IS "duplicatekey">
			<cfset request.message = "An attempt to duplicate a player appearance has been detected. Please check the Team Sheet.">
		<cfelseif attributes.errortype IS "baddata">
			<cfset request.message = "You tried to insert a record into the <cfoutput>#attributes.source#</cfoutput> table. One of the fields you tried to insert has an incorrect value.">
		</cfif>		
	<cfelseif attributes.source IS "Event" OR attributes.source IS "RefAvailable">
		<cfif attributes.errortype IS "duplicatekey">
			<cfset request.message = "You tried to insert a duplicate record.">
		</cfif>
	<cfelseif attributes.source IS "clubinfo">
		<cfif attributes.errortype IS "duplicatekey">
			<cfset request.message = "You tried to insert a duplicate record.">
		</cfif>
	<cfelse>
		<cfset request.message = " ... You tried to delete a record from the <cfoutput>#attributes.source#</cfoutput> table. This record has dependent records in other tables.">
	</cfif>
</cfif>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>Untitled</title>
	<link rel="stylesheet" href="fmstyle.css" type="text/css">
</head>

<body>

<span class="pix24boldred">
Sorry! You can't do that.......
</span>
<p>
<span class="pix18">
<cfoutput>#request.message#</cfoutput>
</span>
</p>
<p>
<span class="pix18">
Click your browser 'back' button to return to the page you were on......<cfabort>
</span>
</p>
</body>
</html>