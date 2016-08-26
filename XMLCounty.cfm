<cfsilent>
<!--- e.g. XMLCounty.cfm --->
<cfquery name="QCounty" datasource="zmast">
	SELECT
		countycode,
		countyname 
	FROM 
		countyinfo
	ORDER BY
		countyname
</cfquery></cfsilent>
<xml>
<cfoutput query="QCounty">
<cfif countycode IS "TEST">
<cfelse>
<county>
<code>#countycode#</code>
<name>#countyname#</name></cfif>
</county>
</cfoutput>
</xml>