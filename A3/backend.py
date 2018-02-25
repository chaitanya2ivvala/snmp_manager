#!/usr/bin/python
import subprocess
import sys
import argparse
import os
parser = argparse.ArgumentParser(description ='wrapping script')
parser.add_argument('cred',help='enter credentials')
parser.add_argument('frequency',type=float,help='enter sample frequency')
parser.add_argument('oid',nargs='+',help='enter oid')
args = parser.parse_args()
cred1 = args.cred
f=args.frequency
oid = args.oid
so = " ".join(oid)
time1 = []
cmd = "/home/chaitanya/Desktop/A3/A2/prober " + str(cred1) +" " +str(f) + " -1 " + str(so)
process = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE,shell = True)
while True:
 for line in iter(process.stdout.readline, ''):
   values = line.split("|")
   values = [int(i) for i in values]
   time1.append(values[0])
   del values[0] 
   for a1,b1 in zip(oid,values):
    c1 = str(time1[0])+'000000000'
    
    print a1,b1,c1
    cmd = "curl -i -XPOST 'http://localhost:8086/write?db=A3' -u ats:atslabb00 --data-binary 'rate,oid=%s vlaue=%s %s' > /dev/null"%(a1,b1,c1)
    os.system(cmd)
   del time1[:]

