<?php
include('config.php');

   $result = $database->exec($trapdata);
   if(!$result){
       $database->lastErrorMsg();
   } 
 
   $query = "SELECT * FROM trapdata";
   $ret = $database->query($query);


while($row = $ret->fetchArray(SQLITE3_ASSOC) ) {
      		echo   $row['domainame']." | ".$row['status']." | ".$row['ntime']." | ".$row['oldstatus']." | ".$row['oldtime']."\n";
     }

if($ret->fetchArray(SQLITE3_ASSOC) == 0){
      echo "FALSE";
   }


   $database->close();
?>



