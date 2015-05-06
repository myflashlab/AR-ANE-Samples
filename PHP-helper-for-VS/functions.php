<?php

function send_post_request($url, $data)
{
	$options = array(
		'http' => array(
			'header'  => "Content-type: application/x-www-form-urlencoded\r\n",
			'method'  => 'POST',
			'content' => http_build_query($data),
		),
	);
	$context  = stream_context_create($options);
	$result = file_get_contents($url, false, $context);

	return $result;
}

function send_post_request_via_curl($url, $data)
{
	$ch = curl_init();
	$curlConfig = array(
		CURLOPT_URL				=> $url,
		CURLOPT_POST			=> true,
		CURLOPT_HEADER			=> true,
		CURLOPT_SSL_VERIFYPEER	=> false,
		CURLOPT_RETURNTRANSFER	=> true,
		CURLOPT_POSTFIELDS		=> $data
	);
	curl_setopt_array($ch, $curlConfig);
	$result = curl_exec($ch);
	curl_close($ch);
	return $result;
}