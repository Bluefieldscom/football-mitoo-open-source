


<cfquery name="QPWDThisLeague" datasource="zmast" >
	SELECT 
		pwd 
	FROM 
		identity 
	WHERE 
		leaguecodeprefix = '#arguments.leagueCode#';
</cfquery>
<cfset ThisPWD = TRIM(QPWDThisLeague.pwd) >
<!--- 
Create the three character password from the First, Third and Last characters of the full password 
<cfset ThisPWD3 = "#LEFT(ThisPWD,1)##MID(ThisPWD,3,1)##RIGHT(ThisPWD,1)#">
<cfset ThisPWD3 = UCase(ThisPWD3) >
--->

<cfif ThisPWD EQ #arguments.password#>
	<cfset password_correct = 1>
</cfif>