#!/usr/bin/python
from easysnmp import Session
import argparse
import time
parser = argparse.ArgumentParser(description ='probing script')
parser.add_argument('cred',help='enter credentials')
parser.add_argument('frequency',type=float,help='enter sample frequency')
parser.add_argument('sample',type=int,help='enter no of samples')
parser.add_argument('oid',nargs='+',help='enter oid')
args = parser.parse_args()
t=1/args.frequency
s=args.sample
cred1=args.cred
ip,port,comm = cred1.split(":")
count=0
session = Session(hostname=ip, remote_port = port, community=comm, version=2,timeout=2,retries=1)
args.oid.insert( 0, '1.3.6.1.2.1.1.3.0')
old=[]
out1=[]
t4=0
while (count != s):
  t1 = time.time()
  new = session.get(args.oid)
  t2 = time.time()
  if len(new)==len(old):
    newtime=float(new[0].value)/100
    oldtime=float(old[0].value)/100
    if args.frequency > 1:
     timediff = t1-t4
    if args.frequency <= 1:
     timediff1 = t1-t4
     if timediff1!=0:
      timediff = int(timediff1)
     else:
      timediff = int(t)
    for i in range(1,len(args.oid)):
      if new[i].value!="NOSUCHINSTANCE" and old[i].value!="NOSUCHINSTANCE": 
         a = int(new[i].value)
         b = int(old[i].value)
         if a>=b:
           out = (a-b)/timediff
           out1.append(out)
         if a<b :
          if new[i].snmp_type=="COUNTER64":
           out = ((2**64+a)-b)/timediff
           out1.append(out)
          if new[i].snmp_type=="COUNTER":
           out = ((2**32+a)-b)/timediff
           out1.append(out)
      else:
        print t1,"|"  
    count = count+1 
    if len(out1)!=0:
      sar = [str(get) for get in out1]
      print t1 ,'|', ("| " . join(sar))
  old = new[:]
  t4=t1
  del out1[:]
  t3=time.time()
  if t-t3+t1>0:
    time.sleep(t-t3+t1)
  else:
    time.sleep(0.0)
