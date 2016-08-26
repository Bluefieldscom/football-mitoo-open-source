This tag  duplicates some functionality of the <CFFTP> ColdFusion tag.
It is working in Windows NT/2000 and doesn't depend on CFusion Server version. This is a C++ 
tag useful when you need to do single action during the FTP connection. Also it allows to 
create/remove directories.


Syntax:

<CFX_FTPP 
  ACTION=”Action type”
  SERVER="FTP server"
  USER="User name"
  PWD="User's password"
  DIRECTORY="Destination directory name"
  LOCALFILE="filename"
  REMOTEFILE="filename"
  TYPE="transfer mode"
  PORT=”Port number”
  OUTPUT="diagnostic string"


Note: Use only forwardslashes or double backslashes inside parameters.

ACTION
	Optional. Valid entries are 
	PUT – 	 to put file, 
	GET - 	 to get file, 
	REM – 	 to delete file, 
	REMDIR – to delete directory, 
	CRTDIR – to create directory. 
Defaults to PUT.

SERVER
	Required. The IP address of the FTP server.

USER
	Optional. Defaults to “anonymous”.

PWD
	Optional. Password to log the user if USER is not “anonymous”.

DIRECTORY
	Required when ACTION=”REMDIR” or “CRTDIR” , otherwise optional. 
	Specifies the directory name.   Defaults to FTP root folder.

LOCALFILE
	Required when ACTION=”PUT” or “GET”. 
	Specifies the file name on the local server.

REMOTEFILE
	Required when ACTION=”PUT”,”GET” or “REM”. 
	Specifies the name of the file on the FTP server.

TYPE
	Optional. The FTP transfer mode you want to use. 
	Valid entries are ASCII or BIN. Defaults to ASCII.

PORT
	Optional. Internet port number. Defaults to 21.

OUTPUT
	The value of output string is determinated by the result of the file transferring. 
	Success - Action succeeded
	Failure	- Short description of the failure reason




EXAMPLE:
<!--- Rid of backslashes 
	ACTION = "PUT"
---> 
<cfset locfile="#application.wwwrootDirectory#hrcom\weeklymag\WeeklyMag.cfm">
<CFX_FTP 
	USER="#Replace(application.un,"\","/","ALL")#"
	PWD="#application.pw#"
	SERVER="127.0.0.1"
	DIRECTORY="weeklymag"
	LOCALFILE="#Replace(locfile,"\","/","ALL")#"
	REMOTEFILE="WeeklyMag.cfm"
	TYPE="ASCII"
	OUTPUT="result"
	>
<cfoutput><b>#result#</b></cfoutput><br>




Any comments, reports a bug or special conditions, please do not hesitate contact me:

Nikolai Kouzoub
nkouzoub@hr.com
www.hr.com
