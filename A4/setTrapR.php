<?php
include 'config.php';

$ip =$_GET['ip'];
$port = $_GET['port'];
$community = $_GET['community'];

if (empty($port) || empty($community) || empty($ip)){
$message = "FALSE";
echo $message;
}

else{
$message = "OK";
$check =<<<EOF
select count(*) as RowCount from snmptrapmanager;
EOF;
$check2 = $db->query($check);
$c = $check2->fetchArray(SQLITE3_ASSOC);
#echo "row count is ".$c["RowCount"]."\n";
if ($c["RowCount"] > 0){
		$sql = "update snmptrapmanager set ip='$ip', port='$port', community='$community'";
		$result1 = $db->query($sql);
	}
	else{
		$sql = "insert into snmptrapmanager (ip, port, community) values ('$ip','$port', '$community')";
		$result1 = $db->query($sql);
	}
	echo $message;
}


?>
