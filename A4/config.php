<?php
  class MyDB extends SQLite3 {
      function __construct() {
         $this->open('trap.db');
      }
   }
   $db = new MyDB();
   if(!$db) {
      echo $db->lastErrorMsg();
   }
#else{echo "database opened \n";}



$table2 =<<<EOF
CREATE TABLE IF NOT EXISTS snmptrapmanager(id INTEGER PRIMARY KEY AUTOINCREMENT,ip VARCHAR(50),port INT(10), community VARCHAR(50));
EOF;
$exs2 = $db->exec($table2);
   if(!$exs2){
      echo $db->lastErrorMsg();
   }
#else {echo "table 2 created \n";}
   
$table1 = "CREATE TABLE IF NOT EXISTS handler (ID INTEGER PRIMARY KEY AUTOINCREMENT,device VARCHAR NOT NULL UNIQUE,status INT NOT NULL, oldstatus INT, ntime INT NOT NULL, oldtime INT)"; 
$exs1 = $db->exec($table1);
   if(!$exs1){
      echo $db->lastErrorMsg();
   }
#else {echo "table 1 created \n";}

?>
