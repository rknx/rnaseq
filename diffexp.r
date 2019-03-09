# Import packages
library(cummeRbund)
library(cowplot)

# Set separate folder for R output
setwd("R")

# Read Cuffdiff output
cuff_data = readCufflinks('../cuffdiff')
cuff_data

# Create plots for genes
a1=csDensity(genes(cuff_data))
a2=csScatter(genes(cuff_data), 'C1', 'C2',alpha=0.05, showSignificant=T)
a3=csVolcano(genes(cuff_data), 'C1', 'C2', alpha=0.05, showSignificant=T)

# Create plots for isoforms
a4=csDensity(isoforms(cuff_data))
a5=csScatter(isoforms(cuff_data), 'C1', 'C2',alpha=0.05, showSignificant=T)
a6=csVolcano(isoforms(cuff_data), 'C1', 'C2', alpha=0.05, showSignificant=T)

# Plotting volcano plot
plot_grid(plot_grid(a3+scale_x_continuous(limits=c(-4,4))+ggtitle("Genes: C1 vs C2")+
                      theme(legend.position = 'none',plot.title=element_text(hjust=0.5)),
                    a6+scale_x_continuous(limits=c(-15,15))+ggtitle("Isoforms: C1 vs C2")+
                      theme(legend.position = 'none',plot.title=element_text(hjust=0.5)),ncol=2),
          get_legend(aa[[3]]+theme(legend.position='bottom',legend.justification='center')),
          ncol=1, rel_heights=c(1,.1))

# Plotting scatter plot
a5

# Plotting density plot
plot_grid(plot_grid(a1+ggtitle("Genes")+
                      theme(legend.position = 'none',plot.title=element_text(hjust=0.5)),
                    aj4+ggtitle("Isoforms")+
                      theme(legend.position = 'none',plot.title=element_text(hjust=0.5)),ncol=2),
          get_legend(aa[[3]]+theme(legend.position='bottom',legend.justification='center')),
          ncol=1, rel_heights=c(1,.1))

# PLotting expression of target genes
mygenelist=c("Nacalpha","regucalcin","homer","Nep2")
mygene = getGenes(cuff_data,mygenelist)
a16=expressionBarplot(mygene)
a17=expressionBarplot(isoforms(mygene))
a18=plot_grid(expressionBarplot(isoforms(mygenelist[3])),
              expressionBarplot(isoforms(mygenelist[1])),
              expressionBarplot(isoforms(mygenelist[4])),
              expressionBarplot(isoforms(mygenelist[2])),
              ncol=4)

# Set significance metrics
gene_diff = diffData(genes(cuff_data))
sig_gene = subset(gene_diff, (significant == 'yes'))

isoform_diff = diffData(isoforms(cuff_data), 'C1', 'C2')
sig_isoform = subset(isoform_diff, (significant == 'yes'))

tss_diff = diffData(TSS(cuff_data), 'C1', 'C2')
sig_tss = subset(tss_diff, (significant == 'yes'))

cds_diff = diffData(CDS(cuff_data), 'C1', 'C2')
sig_cds = subset(cds_diff, (significant == 'yes'))

promoter_diff = distValues(promoters(cuff_data))
sig_promoter = subset(promoter_diff, (significant == 'yes'))

splicing_diff = distValues(splicing(cuff_data))
sig_splicing = subset(splicing_diff, (significant == 'yes'))

relCDS_diff = distValues(relCDS(cuff_data))
sig_relCDS = subset(relCDS_diff, (significant == 'yes'))

rbind(Total=data.frame(Genes=gene_diff,Isoforms=isoform_diff,TSS=tss_diff,CDS=cds_diff,Promoter=promoter_diff,Splicing=splicing_diff,Regulated=relCDS_diff),
      Significant=data.frame(Genes=sig_gene,Isoforms=sig_isoform,TSS=sig_tss,CDS=sig_cds,Promoter=sig_promoter,Splicing=sig_splicing,Regulated=sig_relCDS))

# Output significant genes
gene_name=featureNames(getGenes(cuff_data,getSig(cuff,level="genes",alpha=0.05)))
colnames(gene_name)[1]="gene_id"
diff_genes=merge(sig_gene,gene_name) 
write.csv(diff_genes,file="diff_genes.txt",sep='\t',row.names=F,col.names=T,quote=F)

quit()
