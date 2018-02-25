<?php
include 'config.php';
$check =<<<EOF
select count(*) as RowCount from handler;
EOF;
$check2 = $db->query($check);
$c = $check2->fetchArray(SQLITE3_ASSOC);
#echo "row count is ".$c["RowCount"]." \n";
if ($c["RowCount"] > 0){

$check =<<<EOF
select * from handler;
EOF;
$ret = $db->query($check);
   while($row2 = $ret->fetchArray(SQLITE3_ASSOC) ) {			
	   if ($row2["ptime"] != ""){
	     echo $row2["device"]." | ".$row2["status"]." | ".$row2["ntime"]." | ".$row2["oldstatus"]." | ".$row2["oldtime"]."\n";
	   }
	   else{
			echo $row2["device"]." | ".$row2["status"]." | ".$row2["ntime"]."\n";
		}
	}
}
	else {
	echo "FALSE";	
	}
?>
