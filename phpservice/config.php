<?php

/**
 * Initialisation
 */

//error_reporting(E_ALL | E_STRICT);

define("WEBSERVICEUSER", "USERNAME");				//the required login name
define("WEBSERVICEPASSWORD", "PASSWORD");			//the required password
define("WSURI", "http://schema.example.com");	//schema URI
define("AUTHENTICATE", true); 					// enable or disable user authentication

//cache directory (with trailing slash)
$cache_dir = dirname(__FILE__)."/wsdl_cache/";
$compression = true;

/* All the allowed webservice classes */
$WSClasses = array(
	"teamservice",
	"divisionservice",
	"playerservice"
);

/* The classmap associative array. When you want to allow objects as a parameter for
 * your webservice method. ie. saveObject($object). By default $object will now be
 * a stdClass, but when you add a classname defined in the type description in the @param
 * documentation tag and add your class to the classmap below, the object will be of the
 * given type. Requires PHP 5.0.3+
 */
$WSStructures = array(
	"fixture" => "fixture",
	"fixturedate" => "fixturedate",
	"team" => "team",
	"table" => "table",
	"form" => "form",
	"player" => "player"
);

//start session
session_start();

?>
