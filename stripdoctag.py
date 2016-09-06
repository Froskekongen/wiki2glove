import sys

infile=sys.argv[1]
outfile=sys.argv[2]
print("Infile: {0}. Outfile: {1}".format(infile,outfile))
with open(infile,'r') as ff,open(outfile,'w') as ff2:
    for line in ff:
        if line.startswith('<doc') or line.startswith('</doc'):
            continue
        ff2.write(line.replace('\n',' ')+' ')
