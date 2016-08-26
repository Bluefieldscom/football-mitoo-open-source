<?php
$wsdl = "http://".$_SERVER['HTTP_HOST']."/phpservice/service.php?class=contactManager&wsdl";
echo $wsdl."<br>\n";

phpinfo();die;

mysql_connect("localhost","test","test") or die(mysql_error());

$options = Array('actor' =>'http://football.mitoo.com/phpservice/service.php?class=teamservice&wsdl',
				 'login' => 'USERNAME',
				 'password' => 'PASSWORD',
				 'trace' => true);
$client = new SoapClient($wsdl,$options);
$res = $client->getContacts();
print_r($res);

print $client->__getRequestHeaders() . "\n";
print $client->__getRequest() . "\n";

echo $client->__getLastResponse();
$client->getContact(1);
?>
