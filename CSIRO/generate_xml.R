library(babette)
setwd("~/GitHub/bioinf-masters/CSIRO")

input_file <- "australian_H7_aligned.fasta"

out <- create_beast2_input(input_file,
                           tree_prior = create_tree_prior_cep(),
                           clock_model = create_clock_model_rln())

write(out,paste0(input_file,".xml"))
