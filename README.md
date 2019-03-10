# Transcriptomic project for GMS6231
Scripts used:</br>
> SLURM:&nbsp;https://github.com/rknx/rnaseq/blob/master/batch  
> R script: https://github.com/rknx/rnaseq/blob/master/diffexp.r


Steps to run:</br>
> Download both SLURM script and R code to local machine in work folder.</br>
> Edit email and project folder in SLURM header.</br>
> For non-hipergator use, edit path for reference, fasta and annotation files in SLURM script.</br>
> Make sure following programs are installed: <span style="font-variant:small-caps;">Samtools, TopHat, Bowtie, R, Cufflinks, Boost.</span></br>
> Make sure following R packages are installed: cummeRbund, cowplot and dependencies.</br>
> Run slurm script. ```sbatch batch```
