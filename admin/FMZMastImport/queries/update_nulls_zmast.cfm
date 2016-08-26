<!--- 
update_nulls_zmast.cfm 
Purpose:		Set empty values to NULL where reuired by table spec
Created by:		Terry Riley
On:				14 July 2004
Calls:			nothing
Called by:  	dsp_process.cfm		
--->
<cfquery name="gettables" datasource="ZMASTX">
	show tables
</cfquery>

<cfloop query="gettables">
	<cfset tablename = #tables_in_ZMASTX#>
	<cfquery name="getit" datasource="ZMASTX">
		explain #tablename#
	</cfquery>
	<cfloop query="getit">
		<cfif #getit.null# IS "YES">
			<cfquery name="changeit" datasource="ZMASTX">
				UPDATE #tablename#
				SET #getit.field# = NULL
				WHERE LENGTH(TRIM(#getit.field#)) = 0
			</cfquery>
		</cfif>
	</cfloop>
</cfloop>
