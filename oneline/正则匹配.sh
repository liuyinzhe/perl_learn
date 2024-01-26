# test.fa
# >xxxx iTrascriptID=yyyy
# ATGC

# 替换结果
>yyyy
ATGC
perl  -ane 'if(/^>.+iTrascriptID=(\w+)/){print ">".$1."\n";}else{print $_;}' test.fa


# awk 版本
awk '{if(/^>/){match($0,/iTrascriptID=(\w+)/,a);print ">"a[1];}else{ print $_;}}'  test.fa 
