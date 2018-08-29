<?php
include('config.php');

   $query = "SELECT * FROM manager";
   $ret = $database->query($query);
while($row = $ret->fetchArray(SQLITE3_ASSOC) ) {
      		$community = $row['community'];
		      $ip = $row['ip'];
		      $port = $row['port'];
     }

if($ret->fetchArray(SQLITE3_ASSOC)==0){
      echo "no data of the remote host";
   }

else{
   

	echo   $community."@".$ip .":". $port;
}

   $database->close();
?>
