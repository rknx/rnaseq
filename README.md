# Transcriptomic project for GMS6231
Scripts used:</br>
> SLURM:&nbsp;https://github.com/rknx/rnaseq/blob/master/batch  
> R script: https://github.com/rknx/rnaseq/blob/master/diffexp.r
</br>
Steps to run:</br>
> Download both SLURM script and R code to local machine in work folder.
> Edit email and project folder in SLURM header.
> For non-hipergator use, edit path for reference, fasta and annotation files in SLURM script.
> For non-hipergator use, make sure following programs are installed:
>> Samtools, TopHat, Bowtie, R, Cufflinks, Boost.
>> R packages cummeRbund, cowplot and dependencies.
> Run slurm script. ```sbatch batch```
