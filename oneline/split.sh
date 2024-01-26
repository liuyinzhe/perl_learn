# input.fasta
# >xxxx iTrascriptID=yyyy
# ATGC

# 转变结果
# >xxxx
# ATGC

perl  -ane 'if(/^>/){my @arr=split(" ",$_);print $arr[0]."\n";}else{print $_;}'  input.fasta 

# awk 版本
awk '{if(/^>/){ split($_,a," ");print a[1];}else{ print $_;}}'  input.fasta 

