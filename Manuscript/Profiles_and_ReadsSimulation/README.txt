1."Wgsim" and "Genome_ref" are required in the same folder for simulation_adb_v1.2.R.

2. Please download all required genomes using "genomes_download.sh" first before running simulation_adb_v1.2.R:

cd Genome_ref
chmod +x genomes_download.sh
./genomes_download.sh
cd ..

3. Examples for simulation_abd_v1.2.R
Parameters explianation:
Rscript simulation_abd.R type[gut/oral/skin/buliding/ocean/vaginal/building_M_K_m ...] [sample#] [min_species#] [max_species#] [distribution_type] [enable_sequencing_reads_generation][T/F] [reads#]
L: lognormal distribution, R: random distribution, N: one-side normal distribution, E:even distribution.

3.1 Simulation of profiles (without reads):

Rscript simulation_abd.R gut 100 100 200 L F 100000

This command can generate an abundance table from zero-inflated log-normal distribution with 100 samples, species number is randomly selected range from 100 to 200 in each sample.

3.2 Simulation of sequenced reads:

Rscript simulation_abd.R gut 100 100 200 L F 100000

This command can generate an abundance table and sequencing data from zero-inflated log-normal distribution with 100 samples, species number is randomly selected range from 100 to 200 in each sample.

