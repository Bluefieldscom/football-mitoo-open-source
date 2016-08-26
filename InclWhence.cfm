<cfif NOT StructKeyExists(form, "Whence") >
	Form.Whence does not exist!
	<CFABORT>
<cfelse>	
	<CFSWITCH expression="#Form.Whence#">
		<CFCASE VALUE="MD"> <!--- Match Day --->
			<cfif StructKeyExists(session, "CurrentDate")>
				<CFLOCATION URL="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(session.CurrentDate)#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" ADDTOKEN="NO">
			<cfelse>
				<CFLOCATION URL="MtchDay.cfm?TblName=Matches&MDate=#URLEncodedFormat(Now())#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" ADDTOKEN="NO">
			</cfif>
		</CFCASE>
		<CFCASE VALUE="RH"> <!--- Referee's History --->
			<CFLOCATION URL="RefsHist.cfm?RI=#session.RefsID#&LeagueCode=#Form.LeagueCode#" ADDTOKEN="NO">
		</CFCASE>
		<CFCASE VALUE="MRX"> <!--- Missing Referees' Marks --->
			<CFLOCATION URL="MissingRefereesMarks.cfm?LeagueCode=#LeagueCode#&External=N" ADDTOKEN="NO">
		</CFCASE>
		<CFCASE VALUE="MR"> <!--- Missing Referees' Marks --->
			<CFLOCATION URL="MissingRefereesMarks.cfm?LeagueCode=#LeagueCode#" ADDTOKEN="NO">
		</CFCASE>
		<CFCASE VALUE="MSX"> <!--- Missing Sportsmanship Marks --->
			<CFLOCATION URL="MissingSportsmanshipMarks.cfm?LeagueCode=#LeagueCode#&External=N" ADDTOKEN="NO">
		</CFCASE>
		<CFCASE VALUE="MS"> <!--- Missing Sportsmanship Marks --->
			<CFLOCATION URL="MissingSportsmanshipMarks.cfm?LeagueCode=#LeagueCode#" ADDTOKEN="NO">
		</CFCASE>
		<CFCASE VALUE="PD"> <!--- Penalty Deciders --->
			<CFLOCATION URL="PenaltyDeciders.cfm?LeagueCode=#LeagueCode#" ADDTOKEN="NO">
		</CFCASE>
		<CFCASE VALUE="RD"> <!--- Refer To Discipline --->
			<CFLOCATION URL="ReferToDiscipline.cfm?LeagueCode=#LeagueCode#" ADDTOKEN="NO">
		</CFCASE>
		<CFCASE VALUE="CI"> <!--- Club Information --->
			<CFLOCATION URL="ClubList.cfm?LeagueCode=#LeagueCode#" ADDTOKEN="NO">
		</CFCASE>
		<CFCASE VALUE="RG"> <!--- Results Grid --->
			<CFLOCATION URL="ResultsGrid.cfm?DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" ADDTOKEN="NO">
		</CFCASE>
		<CFDEFAULTCASE>	<!--- Fixtures & Results --->
			<CFLOCATION URL="FixtResMonth.cfm?TblName=Matches&DivisionID=#Form.DivisionID#&LeagueCode=#Form.LeagueCode#&MonthNo=#Month(Now())#" ADDTOKEN="NO">
		</CFDEFAULTCASE>
	</CFSWITCH>
</cfif>

