<?php
require_once "config.php";
require_once "functions.php";

$item_path = realpath('./myflashlab.jpg');
$url = 'https://my.metaio.com/REST/VisualSearch/addItem.php';
$data = array(
    'email' => $email,
    'password' => md5($password),
    'dbName' => $dbname,
    'identifier' => "testId",
    'metadata' => json_encode('testMetaData'),
    'item' => '@'.$item_path
);

$result = send_post_request_via_curl($url, $data);
var_dump( $result );
