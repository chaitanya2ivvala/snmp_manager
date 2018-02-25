
<?php
include 'config.php';
$check =<<<EOF
select count(*) as RowCount from snmptrapmanager;
EOF;
$check2 = $db->query($check);
$c = $check2->fetchArray(SQLITE3_ASSOC);
if ($c["RowCount"] > 0){
$sqlc = "select ip,port,community from snmptrapmanager";
$ret = $db->query($sqlc);
   while($row = $ret->fetchArray(SQLITE3_ASSOC) ) {
		echo $row["community"]."@".$row["ip"].":".$row["port"];
	}
}

else{
echo "FALSE";
}



?>
