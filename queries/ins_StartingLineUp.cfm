<!--- called from UpdateStartingLineUpList.cfm --->

	<cfquery datasource="#request.DSN#">
	INSERT INTO
		shirtnumber
		(AppearanceID, NominalShirtNumber, ActualShirtNumber, LeagueCode)
	VALUES
		(
		<cfqueryparam value = #AID# 
			cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		<cfqueryparam value = #NSN#
			cfsqltype="CF_SQL_INTEGER" maxlength="3">, <!--- Nominal Shirt Number --->
		<cfqueryparam value = #ASN# 
			cfsqltype="CF_SQL_INTEGER" maxlength="3">, <!--- Actual Shirt Number --->
		<cfqueryparam value = '#request.filter#' 
			cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		)
	</cfquery>
