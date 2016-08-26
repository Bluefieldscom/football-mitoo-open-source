<!---
qry_truncatedb.cfm
Purpose:	remove data from all tables and reset auto_increment to zero
			prior to re-starting an import sequence
Created:	14 July 2004
By:			Terry Riley
Calls:		nothing
Links to:	automatically to index2.cfm
Passes:		nothing
Available from: index2.cfm
Notes:		none
--->

<cfquery name="unhookFK" datasource="#application.DSN#">
	SET FOREIGN_KEY_CHECKS=0
</cfquery>

<cfquery name="zap_app" datasource="#application.DSN#">
	TRUNCATE TABLE appearance
</cfquery>
<cfquery name="zero_app" datasource="#application.DSN#">
	ALTER TABLE appearance AUTO_INCREMENT=0
</cfquery>

<cfquery name="zap_comm" datasource="#application.DSN#">
	TRUNCATE TABLE committee
</cfquery>
<cfquery name="zero_comm" datasource="#application.DSN#">
	ALTER TABLE committee AUTO_INCREMENT=0
</cfquery>

<cfquery name="zap_con" datasource="#application.DSN#">
	TRUNCATE TABLE constitution
</cfquery>
<cfquery name="zero_con" datasource="#application.DSN#">
	ALTER TABLE constitution AUTO_INCREMENT=0
</cfquery>

<cfquery name="zap_div" datasource="#application.DSN#">
	TRUNCATE TABLE division
</cfquery>
<cfquery name="zero_div" datasource="#application.DSN#">
	ALTER TABLE division AUTO_INCREMENT=0
</cfquery>

<cfquery name="zap_fix" datasource="#application.DSN#">
	TRUNCATE TABLE fixture
</cfquery>
<cfquery name="zero_fix" datasource="#application.DSN#">
	ALTER TABLE fixture AUTO_INCREMENT=0
</cfquery>

<cfquery name="zap_ko" datasource="#application.DSN#">
	TRUNCATE TABLE KOround
</cfquery>
<cfquery name="zero_ko" datasource="#application.DSN#">
	ALTER TABLE KOround AUTO_INCREMENT=0
</cfquery>

<cfquery name="zap_matchno" datasource="#application.DSN#">
	TRUNCATE TABLE matchno
</cfquery>
<cfquery name="zero_matchno" datasource="#application.DSN#">
	ALTER TABLE matchno AUTO_INCREMENT=0
</cfquery>

<cfquery name="zap_rep" datasource="#application.DSN#">
	TRUNCATE TABLE matchreport
</cfquery>
<cfquery name="zero_rep" datasource="#application.DSN#">
	ALTER TABLE matchreport AUTO_INCREMENT=0
</cfquery>

<cfquery name="zap_news" datasource="#application.DSN#">
	TRUNCATE TABLE newsitem
</cfquery>
<cfquery name="zero_news" datasource="#application.DSN#">
	ALTER TABLE newsitem AUTO_INCREMENT=0
</cfquery>

<cfquery name="zap_ord" datasource="#application.DSN#">
	TRUNCATE TABLE ordinal
</cfquery>
<cfquery name="zero_ord" datasource="#application.DSN#">
	ALTER TABLE ordinal AUTO_INCREMENT=0
</cfquery>

<cfquery name="zap_player" datasource="#application.DSN#">
	TRUNCATE TABLE player
</cfquery>
<cfquery name="zero_player" datasource="#application.DSN#">
	ALTER TABLE player AUTO_INCREMENT=0
</cfquery>

<cfquery name="zap_ref" datasource="#application.DSN#">
	TRUNCATE TABLE referee
</cfquery>
<cfquery name="zero_ref" datasource="#application.DSN#">
	ALTER TABLE referee AUTO_INCREMENT=0
</cfquery>

<cfquery name="zap_reg" datasource="#application.DSN#">
	TRUNCATE TABLE register
</cfquery>
<cfquery name="zero_reg" datasource="#application.DSN#">
	ALTER TABLE register AUTO_INCREMENT=0
</cfquery>

<cfquery name="zap_spon" datasource="#application.DSN#">
	TRUNCATE TABLE sponsor
</cfquery>
<cfquery name="zero_spon" datasource="#application.DSN#">
	ALTER TABLE sponsor AUTO_INCREMENT=0
</cfquery>

<cfquery name="zap_sus" datasource="#application.DSN#">
	TRUNCATE TABLE suspension
</cfquery>
<cfquery name="zero_sus" datasource="#application.DSN#">
	ALTER TABLE suspension AUTO_INCREMENT=0
</cfquery>

<cfquery name="zap_team" datasource="#application.DSN#">
	TRUNCATE TABLE team
</cfquery>
<cfquery name="zero_team" datasource="#application.DSN#">
	ALTER TABLE team AUTO_INCREMENT=0
</cfquery>

<cfquery name="rehookFK" datasource="#application.DSN#">
	SET FOREIGN_KEY_CHECKS=1
</cfquery>

<CFLOCATION url="../index2.cfm">