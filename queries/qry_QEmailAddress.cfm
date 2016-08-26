<!--- called by InclInsrtEmailAddr.cfm --->

<CFQUERY NAME="QEmailAddress" datasource="ZMAST" >
SELECT
	ID
FROM
	userdetail
WHERE
	EmailAddr = '#request.EmailAddr#'
</CFQUERY>