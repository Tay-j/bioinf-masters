rule BEAUTI:
	input:
		"data/"
	output:
		"data/"
	shell:
		

rule BEAST:
	input:
		"data/australian_H7_aligned_SC.xml"
	output:
		"results/"
	shell:
		beast -overwrite -beagle_GPU {input} > {output}
