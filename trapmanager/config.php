<?php
   class MyDB extends SQLite3 {
      function __construct() {
         $this->open('usha.db');
      }
   }
   $database = new MyDB();
   $trapdata =<<<EOF
      CREATE TABLE IF NOT EXISTS trapdata(domainame TEXT NOT NULL,status INT NOT NULL,ntime INT NOT NULL,oldstatus INT,oldtime INT);
EOF;
$manager =<<<EOF
      CREATE TABLE IF NOT EXISTS manager(ip VARCHAR NOT NULL,port INT NOT NULL,community STRING NOT NULL);

EOF;

   ?>
