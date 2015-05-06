<?php
require_once "config.php";
require_once "functions.php";

$url = 'https://my.metaio.com/REST/VisualSearch/addDatabase.php';
$data = array(
	'email' => $email,
	'password' => md5($password),
	'dbName' => $dbname
	);

$result = send_post_request_via_curl($url, $data);
var_dump( $result );