"""
Wright-Fisher forward-time population genetic simulation
Uses realistic U and N for humans (~2 and 20,000, respectively)
Efficient computation accomplished by representing genomes as linkage blocks
"""
import os
import fwdpy11
import numpy as np
import sys
import concurrent.futures
import FixedCrossoverInterval
import msprime
import tskit.trees

#This function runs a simulation with the given parameters.
#Current constants: relative fitness, diploidy, multiplicative effects
#It  either returns the slope of average population fitness after a burn-in phase,
#or just runs a single simulation.
def runsim(generations, popsize, seed, numberofchromosomes, chromosomesize, Ub, Sb, Ud, Ubname, Sbname, popsizename, generationsname, chromsizename, Udname, seedname):
	
	rawdatafilename = "rawdataforUb" + Ubname + "Sb" + Sbname + "popsize" + popsizename + "generations" + generationsname + "chromosomesize" + chromsizename + "Ud" + Udname + "seed" + seedname + ".txt"
	rawdatafile = open(rawdatafilename, "w")
	summarydatafilename = "summarydataforUb" + Ubname + "Sb" + Sbname + ".txt"
	summarydatafile = open(summarydatafilename, "w")
	
	rng = fwdpy11.GSLrng(seed)
	
	fitnesstype = fwdpy11.Multiplicative(2.)
	
	genomesize = numberofchromosomes * chromosomesize
	
	#This should produce a list of recombination intervals to put into recregions later.
	chromosomelist = []	
	for i in range(0, numberofchromosomes-1):
		chromosomelist.append(FixedCrossoverInterval.FixedCrossoverInterval(i*chromosomesize, i*chromosomesize + chromosomesize, 2))
	
	class Recorder(object):
		def __init__(self):
			self.wbar = []
		
		#fwdpy requires that the call function of recorder objects include a sampler variable that would allow for preservation of samples from the tree sequence,
		#even though I don't actually need that functionality here.
		def __call__(self, popsize, sampler): 
			if pop.generation >= pop.N:
				metadata = np.array(pop.diploid_metadata, copy=False)
				self.wbar.append((pop.generation, metadata["w"].mean()))
	
	#The rates goes neutral mutation rate, selected mutation rate, recombination rate in that order.
	#Note that the selected mutation rate is the mutation rate per haploid genome, not diploid genome.
	pdict = {'gvalue': fitnesstype,
             'rates': (0., Ud/2, None),  
             'nregions': [],
             'sregions': [fwdpy11.GammaS(0, genomesize, 1, -0.009487, 0.169)],
             'recregions': chromosomelist,
             'demography': np.array([popsize]*generations, dtype=np.uint32)
             }
	params = fwdpy11.ModelParams(**pdict)
	
	pop = fwdpy11.DiploidPopulation(popsize, genomesize)
	
	recorder = Recorder()
	
	fwdpy11.evolvets(rng, pop, params, 100, recorder, suppress_table_indexing=True)
	
	treesequence = pop.dump_tables_to_tskit()
	
	#Print out raw data of interest.
	print("Generations,Mean_fitness", file = rawdatafile)
	for i in range(popsize, generations):
		print("{},{}".format(i, recorder.wbar[i-popsize][1]), file = rawdatafile)
	
	ts = msprime.mutate(treesequence, rate=0.0001, keep=False)
	
	meandiversity = ts.diversity(sample_sets=None, windows=None, mode='site', span_normalise=True)
	
	print("Mean pairwise genetic diversity at end of simulation: {:.10f}".format(meandiversity), file = summarydatafile)
	

#This function takes in two Sb values and modifies them
#until the first produces a slope of fitness smaller than some root value
#and the second produces a slope larger than the same root value
#It returns an array with the two Sb values (smaller value first)
def BracketRootforSb(generations, popsize, seed, numberofchromosomes, chromosomesize, desiredslope, Ub, Sb1, Sb2, Ud, Ubname, Sb1name, Sb2name, popsizename, generationsname, chromsizename, Udname, seedname, miscfile):
	
	numberoftries = 10
	factor = 0.01
	
	currentSb1 = Sb1
	currentSb2 = Sb2
	
	currentSb1name = Sb1name
	currentSb2name = Sb2name
	
	resultingslope1 = runsim(generations, popsize, seed, numberofchromosomes, chromosomesize, Ub, currentSb1, Ud, Ubname, currentSb1name, popsizename, generationsname, chromsizename, Udname, seedname)
	resultingslope2 = runsim(generations, popsize, seed, numberofchromosomes, chromosomesize, Ub, currentSb2, Ud, Ubname, currentSb2name, popsizename, generationsname, chromsizename, Udname, seedname)
	
	if resultingslope1 == resultingslope2:
		print("Slopes after first try are the same, equaling {} and {}\n".format(resultingslope1, resultingslope2), file = miscfile)
		return 0
	if resultingslope1 > 0.0:
		print("Slope with sb 0.0 is positive, slope = {}\n".format(resultingslope1), file = miscfile)
		return 0
	
	for i in range(0, numberoftries):
		if resultingslope1 < desiredslope and resultingslope2 > desiredslope:
			return [currentSb1, currentSb2]
		elif resultingslope2 <= desiredslope:
			currentSb2 += factor
			currentSb2name = str(currentSb2)
			resultingslope2 = runsim(generations, popsize, seed, numberofchromosomes, chromosomesize, Ub, currentSb2, Ud, Ubname, currentSb2name, popsizename, generationsname, chromsizename, Udname, seedname)
		elif resultingslope1 >= desiredslope:
			currentSb1 -= factor
			currentSb1name = str(currentSb1)
			resultingslope1 = runsim(generations, popsize, seed, numberofchromosomes, chromosomesize, Ub, currentSb1, Ud, Ubname, currentSb1name, popsizename, generationsname, chromsizename, Udname, seedname)
	print("Failed to bracket slope of {} in 10 tries.\n".format(desiredslope), file = miscfile)
	return 0

def FindingSbValueWithGivenSlope(generations, popsize, seed, numberofchromosomes, chromosomesize, desiredslope, Ub, Sb1, Sb2, Ud, Ubname, Sb1name, Sb2name, popsizename, generationsname, chromsizename, Udname, seedname, miscfile):
	
	accuracy = 0.00005
	maxtries = 30
	
	currentSb1 = Sb1
	currentSb2 = Sb2
	currentSb1name = Sb1name
	currentSb2name = Sb2name
	
	currentfactor = Sb2 - Sb1
	currentroot = Sb1
	
	if currentfactor < 0:
		print("Sb2 smaller than Sb1: Sb1 = {}, Sb2 = {}.\n".format(currentSb1, currentSb2), file = miscfile)
		return 0
	
	currentslope1 = runsim(generations, popsize, seed, numberofchromosomes, chromosomesize, Ub, currentSb1, Ud, Ubname, currentSb1name, popsizename, generationsname, chromsizename, Udname, seedname)
	currentslopemid = runsim(generations, popsize, seed, numberofchromosomes, chromosomesize, Ub, currentSb2, Ud, Ubname, currentSb2name, popsizename, generationsname, chromsizename, Udname, seedname)
	
	#Checks to make sure that the desired slope is properly bracketed.
	#The only way I'm really worried about this happening is with significant stochasticity between simulations,
	#which so far has not been observed.
	#These also specifically check that slope1 is less than the desired slope and slopemid is larger than the desired slope.
	#This makes the root-finding algorithm less general but lets me skip some steps I don't want to do.
	if ((currentslope1 - desiredslope)*(currentslopemid - desiredslope)) >= 0.0:
		print("Slope root not bracketed properly, with starting slopes {} and {}\n".format(currentslope1, currentslopemid), file = miscfile)
		return 0
	if currentslope1 > desiredslope:
		print("Slope 1 larger than desired slope. Slope 1 = {}, desired slope = {}\n".format(currentslope1, desiredslope), file = miscfile)
		return 0
	if currentslopemid < desiredslope:
		print("Slope 2 smaller than desired slope. Slope 2 = {}, desired slope = {}\n".format(currentslope2, desiredslope), file = miscfile)
		return 0
	
	for i in range(0, maxtries):
		currentfactor *= 0.5
		currentSbmid = currentroot + currentfactor
		currentSbmidname = str(currentSbmid)
		
		currentslopemid = runsim(generations, popsize, seed, numberofchromosomes, chromosomesize, Ub, currentSbmid, Ud, Ubname, currentSbmidname, popsizename, generationsname, chromsizename, Udname, seedname)
		if currentslopemid <= desiredslope:
			currentroot = currentSbmid
		if currentfactor < accuracy or currentSbmid == 0.0:
			return currentroot
	
	print("Root not found. Root after 30 tries was: {}\n".format(currentroot), file = miscfile)





#The actual main body starts below!




if __name__ == "__main__":
	
	#Following lines load input parameters.
	generations = int(sys.argv[1])
	popsize = int(sys.argv[2])
	deleteriousmutationrate = float(sys.argv[3]) #this is the genome-wide rate, so not compatible with the c version
	chromosomesize = int(sys.argv[4])
	numberofchromosomes = int(sys.argv[5]) #this is number of chromosomes, not ploidy -- all individuals are diploid
	beneficialmutationrate = float(sys.argv[6]) #genome-wide again I guess
	Sb = float(sys.argv[7])
	typeofrun = sys.argv[8]
	slopeforcontourline = float(sys.argv[9])
	randomnumberseed = int(sys.argv[10])
	beneficialson = bool(sys.argv[11])
	
	#Following lines save some parameters as characters for naming data files later.
	generationsname = sys.argv[1]
	popsizename = sys.argv[2]
	Udname = sys.argv[3]
	chromosomesizename = sys.argv[4]
	Ubname = sys.argv[6]
	Sbname = sys.argv[7]
	seedname = sys.argv[10]
	
	#Following lines open some files to which to print debugging data.
	#There might be a better way to do debugging in python, like with exceptions and stuff, but I don't know how to do it yet.
	miscfile = open("miscellaneous", "w")
	verbosefile = open("verbose", "w")
	
	#Following lines make a new directory to store data from the simulations and changes directories into it. (I think)
	#The final directory has slightly different names depending on what type of run is called.
	if typeofrun == 'single':
		if beneficialson:
			directoryname = 'dataforUb' + sys.argv[6] + 'Sb' + sys.argv[7] + 'popsize' + sys.argv[2] + 'chromosomesize' + sys.argv[4] + 'Ud' + sys.argv[3] + 'seed' + sys.argv[10]
			os.mkdir(directoryname)
			os.chdir(directoryname)
		else:
			directoryname = 'datafornobeneficialspopsize' + sys.argv[2] + 'chromosomesize' + sys.argv[4] + 'Ud' + sys.argv[3] + 'seed' + sys.argv[10]
			os.mkdir(directoryname)
			os.chdir(directoryname)
		
		#Now that we're in the right directory, just run the simulation
		runsim(generations, popsize, randomnumberseed, numberofchromosomes, chromosomesize, beneficialmutationrate, Sb, deleteriousmutationrate, sys.argv[6], sys.argv[7], sys.argv[2], sys.argv[1], sys.argv[4], sys.argv[3], sys.argv[10])
		
	elif typeofrun == 'root':
		if beneficialson:
			directoryname = 'dataforUb' + sys.argv[6] + 'slope' + sys.argv[9] + 'popsize' + sys.argv[2] + 'chromosomesize' + sys.argv[4] + 'seed' + sys.argv[10]
			os.mkdir(directoryname)
			os.chdir(directoryname)
		else:
			directoryname = 'datafornobeneficialsslope' + sys.argv[9] + 'popsize' + sys.argv[2] + 'chromosomesize' + sys.argv[4] + 'seed' + sys.argv[10]
			os.mkdir(directoryname)
			os.chdir(directoryname)
		
		#Now that we're in the right directory, start the root-finding algorithm
		Sb1 = 0.0
		Sb2 = Sb
		Sb1name = "0.0"
		Sb2name = Sbname
		
		#Bracket Sb values on either side of the desired slope.
		bracketedSbs = BracketRootforSb(generations, popsize, randomnumberseed, numberofchromosomes, chromosomesize, slopeforcontourline, beneficialmutationrate, Sb1, Sb2, deleteriousmutationrate, sys.argv[6], Sb1name, Sb2name, sys.argv[2], sys.argv[1], sys.argv[4], sys.argv[3], sys.argv[10], miscfile)
		Sb1 = bracketedSbs[0]
		Sb2 = bracketedSbs[1]
		
		#Find an Sb value that produces desired slope.
		rootSb = FindingSbValueWithGivenSlope(generations, popsize, randomnumberseed, numberofchromosomes, chromosomesize, slopeforcontourline, beneficialmutationrate, Sb1, Sb2, deleteriousmutationrate, sys.argv[6], Sb1name, Sb2name, sys.argv[2], sys.argv[1], sys.argv[4], sys.argv[3], sys.argv[10], miscfile)
		
		finaldatafilename = 'final' + directoryname
		finaldatafile = open(finaldatafilename, "w")
		print("The value of Sb required to produce an average slope of log fitness of {} is {}.\n".format(slopeforcontourline, rootSb), file = finaldatafile)
		finaldatafile.close
		
	else:
		print("That type of run is not currently supported.", file = miscfile)
		#One day maybe I'll have more types of runs ...
		
	miscfile.close
	verbosefile.close

	



