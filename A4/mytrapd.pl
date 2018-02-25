#!/usr/bin/perl

use Net::SNMP;
use DBI;

my $fqdn;
my $t;
my @oid=();
my $value;
my $driver   = "SQLite"; 
my $database = "trap.db";
my $dsn = "DBI:$driver:$database";
my $userid = "";
my $password = "";
my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1 }) 
   or die $DBI::errstr;
print "Opened database successfully\n";
my $stmt = qq(CREATE TABLE IF NOT EXISTS handler
   (ID INTEGER PRIMARY KEY    AUTOINCREMENT  NOT NULL ,
      device           VARCHAR NOT NULL UNIQUE,
      status            INT NOT NULL,
      ntime             INT NOT NULL,
      oldstatus         INT,
      oldtime           INT););
my $rv = $dbh->do($stmt);
if($rv < 0) {
   print $DBI::errstr;
} else {
   print "Table created successfully\n";
}
    $TRAP_FILE = "traps.all.log";
    $out0 = `cat $TRAP_FILE | grep 10.2`;
    @out0 = split ('=',$out0);
    $value = $out0[-1];
    chomp($value);

    $out1 = `cat $TRAP_FILE | grep 10.1`;
    @out1 = split ('=',$out1);
    $fqdn0 = $out1[-1];
    @fqdn1 = split ('"',$fqdn0);
    $fqdn = $fqdn1[1];
    chomp($fqdn);
    $time = time;
    $t = time;
    print "$fqdn\n";
    print "$t\n";
    print "$value\n";
    my $stmt = qq(SELECT id from handler where device='$fqdn';);
    my $sth = $dbh->prepare( $stmt );
    my $rv = $sth->execute() or die $DBI::errstr;
     while($id = $sth->fetchrow_array()){
        $get=$id;
     }
    if($get) {
       my $stmt1 = qq(SELECT status,ntime from handler where device='$fqdn';);
       my $sth1 = $dbh->prepare($stmt1);
       my $rv1 = $sth1->execute() or die $DBI::errstr;
      while(($oldstat,$oldtime)  = $sth1->fetchrow_array()){
      
      my $stmt1 = qq(update handler set status = '$value',ntime='$t',oldstatus = '$oldstat',oldtime='$oldtime' WHERE device='$fqdn';);
       my $sth1 = $dbh->prepare($stmt1);
       my $rv1 = $sth1->execute() or die $DBI::errstr;
       
}
if ($value == 3){

 my $stmt2 = qq(SELECT ip,port,community from snmptrapmanager;);
       my $sth2 = $dbh->prepare($stmt2);
       my $rv1 = $sth2->execute() or die $DBI::errstr;
      while((my $ip,my $port,my $community)  = $sth2->fetchrow_array()){
($session, $error) = Net::SNMP->session(-hostname=> $ip,-port => $port,,-version => 1);
if (!defined $session) {
    print "Error connecting to target ". $ip . ": ". $err;
    next;}
else{
print "connected";
}
push(@oid,"1.3.6.1.4.1.41717.20.1", OCTET_STRING, $fqdn, "1.3.6.1.4.1.41717.20.2", UNSIGNED32, $t, "1.3.6.1.4.1.41717.20.3", INTEGER, $oldstatus, "1.3.6.1.4.1.41717.20.4", UNSIGNED32, $oldtime);
my $result = $session->trap(
		-varbindlist => \@oid
		);
}}}
else{
 my $stmt1 = qq(INSERT INTO handler (device,ntime,status) VALUES ('$fqdn','$t','$value'););
       my $sth1 = $dbh->prepare($stmt1);
       my $rv1 = $sth1->execute() or die $DBI::errstr;
}

