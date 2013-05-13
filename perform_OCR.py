#!/usr/bin/env python

# it needs to install hocr2pdf and tesseract OCR packages to 
# the environment. This script calls those in sequence fo processing
# image data into OCRed pdf file

import os
import commands as co
import pdb



path = './'
files = os.listdir(path)

counter = 1
for infile in sorted(files):
  #pdb.set_trace()
	#print type(infile)
	print "File " + infile +" is OCRing "
	(status,output) = co.getstatusoutput("tesseract "+infile+" out hocr");
	print "Status -- "+str(status) + " \nOutput -- "+ str(output)

	print "File "+ infile +" is Converting into PDF "
	(status,output) = co.getstatusoutput("hocr2pdf -i "+ infile + " -o output/" + str(counter) + ".pdf  < out.html");
	print "Status -- "+str(status) + " \nOutput -- "+ str(output)
	counter = counter+1
