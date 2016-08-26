<!--- caled by InclLookUp.cfm, RegistListForm.cfm and SecretWordList.cfm, RSecretWordList.cfm --->
<cfset SecretSuffix = Right(ToString(SecretID),1) >
<cfset SecretWord = Replace(SecretWord, "F", "", "ALL")>
<cfset SecretWord = Replace(SecretWord, "C", "", "ALL")>
<cfset SecretWord = Replace(SecretWord, " ", "", "ALL")>
<cfset SecretWord = Replace(SecretWord, ".", "", "ALL")>
<cfset SecretWord = Replace(SecretWord, "-", "", "ALL")>
<cfset SecretWord = Replace(SecretWord, "'", "", "ALL")>
<cfset SecretWord = Replace(SecretWord, "*", "", "ALL")>
<cfset SecretWord = Replace(SecretWord, "(", "", "ALL")>
<cfset SecretWord = Replace(SecretWord, ")", "", "ALL")>
<cfset SecretWord =  "#UCase(Right(RTrim(SecretWord), 1))##Round(Evaluate((((SecretID) * 13) + 55511) / 7 ))##UCase(Reverse(Mid(SecretWord, 2, 2)))##SecretSuffix#" >
<cfset SecretWord = Replace(SecretWord, "0", "X", "ALL")>
<cfset SecretWord = Replace(SecretWord, "O", "Y", "ALL")>
<cfset SecretWord = Replace(SecretWord, "1", "L", "ALL")>
<cfset SecretWord = Replace(SecretWord, "I", "M", "ALL")>
<cfset SecretWord = Replace(SecretWord, "S", "A", "ALL")>