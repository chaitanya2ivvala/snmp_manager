

<?php
   include('config.php');
   
   
	
$result = $database->exec($manager);
   if(!$result){
       $database->lastErrorMsg();
   } 
 
  
$sql =<<<EOF
	INSERT INTO manager (ip,port,community) VALUES ("$_GET[ip]",$_GET[port],"$_GET[community]");
EOF;
   $answer = $database->exec($sql);
   if(!$answer){
      echo "FALSE";
   }else{
	echo "OK";
}
	
   $database->close();
?>
