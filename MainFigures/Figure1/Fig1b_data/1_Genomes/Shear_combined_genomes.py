# -*- coding:utf-8 -*-
import os
import sys
import string

if len(sys.argv) < 4:
	print ("Please input original file name, output file name, cutting length successively")
	exit(0)

file_name = sys.argv[1]
out_file = sys.argv[2]
cut_len = int(sys.argv[3])
top = []
lines = []
with open (file_name,"r") as f:
	line1 = f.readlines()
	for e in line1:
		if e.startswith('>'):
			r = e.strip()
			top.append(r)	
		else:
			s = e.strip()
			lines.append(s)
	str1 = ''.join(lines)
#print(lines)
with open (out_file,'w+') as f_2:
	num = len(str1)//cut_len
	for i in range(num):
		f_2.write(">" + str(i+1) + "\n")
		f_2.write(str1[i*cut_len:(i+1)*cut_len] + "\n")