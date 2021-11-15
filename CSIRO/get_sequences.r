library(rentrez)
setwd("~/GitHub/bioinf-masters/CSIRO")

#library(XML)

# entrez_db_searchable(db = "nucleotide")

### Australian Dataset
res.aus <- entrez_search(db = "nucleotide", term = "'Influenza A virus'
[porgn:__txid11320] AND hemagglutinin NOT partial AND H7N* AND Australia",
                         retmax = 9999)

#esums.aus <- entrez_summary(db = "nucleotide", id = res.aus$ids)

fasta.aus <- entrez_fetch(db = "nucleotide", id = res.aus$ids, rettype = "fasta")
fasta.aus <- strsplit(fasta.aus, ">")

summ.aus <- entrez_summary(db="nucleotide", id=res.aus$ids)

n.aus <- length(res.aus$ids)
seq.aus <- list()
for (i in 1:n.aus) {
  seq.aus[i] <- fasta.aus[[1]][i+1]
}

seq.aus <- paste0(">",seq.aus[][])

for (i in 1:length(summ.aus)) {
  new.date.aus <- strptime(gsub("/","-",summ.aus[[i]][["createdate"]]),"%Y-%m-%d")
  seq.aus[i] <- gsub(" ","_",seq.aus[i])
  seq.aus[i] <- sub("\n",paste0("/",format(new.date.aus,"%d-%m-%Y"),"\n"),seq.aus[i])
}

write.table(seq.aus,file="australian_H7.fasta",quote=FALSE,sep = "",row.names = FALSE,col.names = FALSE)


### Global Dataset excluding Australia
ret.max <- 300
res.global <- entrez_search(db = "nucleotide", term = "'Influenza A virus'
[porgn:__txid11320] AND hemagglutinin NOT partial AND H7N* NOT Australia",
                            retmax = ret.max)

fasta.global <- entrez_fetch(db = "nucleotide", id = res.global$ids[1:ret.max], rettype = "fasta")
fasta.global <- strsplit(fasta.global, ">")

summ.global <- entrez_summary(db="nucleotide", id=res.global$ids)

n.global <- length(res.global$ids)
seq.global <- list()
for (i in 1:n.global) {
  seq.global[i] <- fasta.global[[1]][i+1]
}

seq.global <- paste0(">",seq.global[][])

for (i in 1:length(summ.global)) {
  new.date.global <- strptime(gsub("/","-",summ.global[[i]][["createdate"]]),"%Y-%m-%d")
  seq.global[i] <- gsub(" ","_",seq.global[i])
  seq.global[i] <- sub("\n",paste0("/",format(new.date.global,"%d-%m-%Y"),"\n"),seq.global[i])
}

write.table(seq.global,file="global_H7.fasta",quote=FALSE,sep = "",row.names = FALSE,col.names = FALSE)

