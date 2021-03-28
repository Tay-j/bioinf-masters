library(ape)
library(phylotools)

tr <- read.tree("D:/Documents/John/University/Master/Project/Data/COVID/nextstrain/nextstrain_ncov_global_timetree.nwk")
tr_metadata <- read.delim2("D:/Documents/John/University/Master/Project/Data/COVID/nextstrain/nextstrain_ncov_global_metadata-3.tsv")

# drop.tip
# tr$edge
# tr$tip.label

par(mfrow = c(1, 1))
plot(tr,cex = 0.01)

#tr_pruned <- drop.tip(tr,1:700)
#tr_pruned <- drop.tip(tr,sample(1:length(tr$tip.label),700,replace = FALSE))
### testing R tree
set.seed(1)

B.1.1.7 <- tr_metadata[tr_metadata$PANGO.Lineage=="B.1.1.7",]$Strain
B.1.1.7 <- sample(B.1.1.7,20,replace = FALSE)
P.1 <- tr_metadata[tr_metadata$PANGO.Lineage=="P.1",]$Strain
P.1 <- sample(P.1,20,replace = FALSE)
others <- tr_metadata[tr_metadata$PANGO.Lineage!="B.1.1.7",]
others <- others[others$PANGO.Lineage!="P.1",]$Strain
others <- sample(others,200,replace = FALSE)

tr_pruned <- keep.tip(tr,c(B.1.1.7,P.1,others))

par(mfrow = c(1, 2))
plot(tr,cex = 0.01)
plot(tr_pruned,cex = 0.01)


### for gisaid data
set.seed(1)

B.1.1.7 <- as.character(tr_metadata[tr_metadata$PANGO.Lineage=="B.1.1.7",]$gisaid_epi_isl)
#B.1.1.7 <- sample(B.1.1.7,20,replace = FALSE)
P.1 <- as.character(tr_metadata[tr_metadata$PANGO.Lineage=="P.1",]$gisaid_epi_isl)
#P.1 <- sample(P.1,20,replace = FALSE)
others <- tr_metadata[tr_metadata$PANGO.Lineage!="B.1.1.7",]
others <- as.character(others[others$PANGO.Lineage!="P.1",]$gisaid_epi_isl)
#others <- sample(others,200,replace = FALSE)

write(c(B.1.1.7,P.1,others),"get_all_sequences.txt")


### get new data
sequence_names <- get.fasta.name("D:/Documents/GitHub/bioinf-masters/COVID/nextstrain/all_sequences.fasta")

set.seed(1)

get_B.1.1.7 <- B.1.1.7[B.1.1.7 %in% sequence_names]
get_B.1.1.7 <- sample(get_B.1.1.7,20,replace = FALSE)
get_P.1 <- P.1[P.1 %in% sequence_names]
get_P.1 <- sample(get_P.1,20,replace = FALSE)
get_others <- others[others %in% sequence_names]
get_others <- sample(get_others,200,replace = FALSE)

write(c(get_B.1.1.7,get_P.1,get_others),"get_sequences.txt")


### add collection time to sequence names
sequence_names <- read.delim2("get_sequences.txt",header = FALSE,stringsAsFactors = FALSE)
for (x in 1:length(sequence_names[,1])) {
  sequence_names[x,2] <- paste0(tr_metadata[tr_metadata$gisaid_epi_isl == sequence_names[x,1],]$PANGO.Lineage,"_",sequence_names[x,1],"_",tr_metadata[tr_metadata$gisaid_epi_isl == sequence_names[x,1],]$Collection.Data)
}


sequences <- rename.fasta("aligned_COVID.fasta", sequence_names,"renamed_aligned_COVID.fasta")


### test if new sequences are in old fasta
old_sequences <-  get.fasta.name("D:/Documents/John/University/Master/Project/Data/COVID/nextstrain/aligned_COVID.fasta")
new_sequences <- get.fasta.name("D:/Documents/John/University/Master/Project/Data/COVID/nextstrain/added/baseline_sequences.fasta")
test_vector <- vector() 
for (i in 1:length(new_sequences)) {
  test_vector[i] <- new_sequences[i]%in%old_sequences
  print(new_sequences[i]%in%old_sequences)
}
### add new sequences to old fasta
tr_metadata <- read.csv("D:/Documents/John/University/Master/Project/Data/COVID/nextstrain/added/metadata_1003.csv")
new_sequences <- data.frame(new_sequences)
for (x in 1:length(new_sequences[,1])) {
  new_sequences[x,2] <- tr_metadata[tr_metadata$gisaid_epi_isl == new_sequences[x,1],]$new_names
}
sequences <- rename.fasta("renamed_aligned_COVID.fasta", sequence_names,"V2_renamed_aligned_COVID.fasta")