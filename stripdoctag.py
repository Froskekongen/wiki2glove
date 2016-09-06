import sys

infile=sys.argv[1]
outfile=sys.argv[2]

replacesigns=[',','.','?','!',':',';','\n','(',')']
def repsigns(txt):
    for rs in replacesigns:
        txt=txt.replace(rs,' '+rs+' ')
    return ' '.join(txt.split())
print("Infile: {0}. Outfile: {1}".format(infile,outfile))
with open(infile,'r') as ff,open(outfile,'w') as ff2:
    for line in ff:
        if line.startswith('<doc') or line.startswith('</doc'):
            continue
        ff2.write(repsigns(line)+' ')
