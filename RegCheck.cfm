<link href="fmstyle.css" rel="stylesheet" type="text/css">
<cfif NOT StructKeyExists(form, "CaptchaVerify")>
  <span class="pix24boldred"><BR>Please enter the verification number (5 digits).<BR><BR>Press the Back button on your browser.....</span>
  <cfabort>
</cfif>
<cfset InputCaptcha = replace(form.CaptchaVerify,' ','','ALL') >
<cfset InputCaptcha = Trim(InputCaptcha) >
<cfif Len(InputCaptcha) NEQ 5>
  <span class="pix24boldred"><BR>Please enter the verification number (5 digits).<BR><BR>Press the Back button on your browser.....</span>
  <cfabort>
</cfif>
<cfif InputCaptcha  NEQ ThisCaptchaNumber >
  <span class="pix24boldred"><BR>Incorrect verification number (5 digits).<BR><BR>Press the Back button on your browser.....</span>
  <cfabort>
</cfif>
<cfif NOT StructKeyExists(form, "forename")>
  <span class="pix24boldred"><BR>Please enter your forename.<BR><BR>Press the Back button on your browser.....</span>
  <cfabort>
</cfif>
<cfif Len(Trim(form.forename)) IS 0>
  <span class="pix24boldred"><BR>Please enter your forename.<BR><BR>Press the Back button on your browser.....</span>
  <cfabort>
</cfif>
<cfif NOT StructKeyExists(form, "surname")>
  <span class="pix24boldred"><BR>Please enter your surname.<BR><BR>Press the Back button on your browser.....</span>
  <cfabort>
</cfif>
<cfif Len(Trim(form.surname)) IS 0>
  <span class="pix24boldred"><BR>Please enter your surname.<BR><BR>Press the Back button on your browser.....</span>
  <cfabort>
</cfif>
<cfset ThisInputEmailAddr = Trim(form.InputEmailAddr)>
<!--- Check to see if they have entered something in the "email" field --->
<cfif Len(ThisInputEmailAddr) IS 0 >
  <span class="pix24boldred"><BR>Please enter your email address.<BR><BR>Press the Back button on your browser.....</span>
  <cfabort>
</cfif>
<cfif StructKeyExists(form,"AgeRange")>
	<cfif (form.AgeRange GE "1") AND (form.AgeRange LE "8") >
	<cfelse>
	  <span class="pix24boldred"><BR>Please enter your age range.<BR><BR>Press the Back button on your browser.....</span>
	  <cfabort>
	</cfif>
<cfelse>
  <span class="pix24boldred"><BR>Please enter your age range.<BR><BR>Press the Back button on your browser.....</span>
  <cfabort>
</cfif>

<cfif StructKeyExists(form,"RoleList")>
	<cfif ListFind(form.RoleList, 6 ) >
		<cfif Len(Trim(form.other)) GT 0  >
		<cfelse>
		  <span class="pix24boldred"><BR>Please enter other role<BR><BR>Press the Back button on your browser.....</span>
		  <cfabort>
		</cfif>
	</cfif>
</cfif>

<cfsilent>
<cfinclude template="queries/ins_QRegInsert.cfm">
</cfsilent>
<cfmail to="#form.InputEmailAddr#" from="#form.InputEmailAddr#"  type="text" subject="Thank you for registering" bcc="INSERT_EMAIL_HERE">
		
Hello there, #form.forename#!
		
Thank you for your interest in the #LeagueName# and football.mitoo.
		
If you want to be on a mailing list for other leagues on football.mitoo then you'll need to register again from each league's own News page.
		
If you have any questions about the mailing list please address them to INSERT_EMAIL_HERE.
		
Yours in Sport
		
Andrew



P.S. This is what you told me about yourself:

Forename: #Trim(form.Forename)# .... Surname: #Trim(form.Surname)#
team(s) with which you are involved: #Trim(form.TeamsInvolved)#
role(s): <cfif ListFind(form.RoleList, 1 ) >player</cfif> <cfif ListFind(form.RoleList, 2 ) >manager</cfif> <cfif ListFind(form.RoleList, 3 ) >secretary</cfif> <cfif ListFind(form.RoleList, 4 ) >supporter</cfif>  <cfif ListFind(form.RoleList, 5 ) >referee</cfif>  <cfif ListFind(form.RoleList, 6 ) >#Trim(form.other)#</cfif>
how you found out about football.mitoo: #Trim(form.HowFoundOut)#
how long you've been using football.mitoo: #Trim(form.HowLongUsing)#
AgeRange: [#form.AgeRange#] ... [1] 0 -  9 [2] 10 - 19 [3] 20 - 29 [4] 30 - 39 [5] 40 - 49 [6] 50 - 59 [7] 60 - 69 [8] 70  +   
OtherComments: #Trim(form.OtherComments)#

</cfmail>
<span class="pix24boldblue"><BR>Hello there, <cfoutput>#form.forename#</cfoutput>!<BR><BR><BR>Thank you for your interest in the <em><cfoutput>#LeagueName#</cfoutput></em> and <em>football.mitoo</em><BR><BR>An email has been sent to <em><cfoutput>#form.InputEmailAddr#</cfoutput></em><BR><BR><a href="News.cfm?LeagueCode=<cfoutput>#LeagueCode#</cfoutput>&NB=0">Please click here</a> to continue.....</span>
<cfabort>
