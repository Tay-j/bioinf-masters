with open("D:\\Documents\\John\\University\\Master\\Project\\Data\\COVID\\nextstrain\\mmsa_2021-02-15.fa") as myfile:
    head = [next(myfile) for x in range(1000)]
print(head)