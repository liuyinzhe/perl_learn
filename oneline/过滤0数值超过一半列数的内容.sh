# -F"\t" 指定分隔符为\t,否则 默认是[\t\s]
# -e 执行command 就是单行
# -a:使用空白作为缺省分隔符
# -n:在脚本中加入while循环 while(<>){    }
# -p:在脚本中加入while循环和print $_;命令  while(<>){print;  }; 由于这里自己控制输出，所以没带-p参数

# #开头内容输出，
perl  -F"\t" -ane 
    ' if(/^#/){ 
                print ;
            }else{ 
                my $count=0; 
                foreach $value (@F){
                        if($value==0){ 
                            $count++ ;
                        }
                };
                my $nf=@F;  # 强制转换
                my $x=($nf-1)/2; # (length(@F)-1)/2
                print $nf."\t".$x."\t".$count."\n";
                if ($count < (length(@F)-1)/2){print $_;}
                 
            }'  inputfile |les
# 查看结果
perl  -F"\t" -ane ' if(/^#/){print ;next}else{ my $count=0; foreach $value (@F){if($value==0){ $count++ ;}};my $nf=@F;if ($count < ($nf-1)/2){print $_;} }'  inputfile |less

# 查看数字
perl  -F"\t" -ane ' if(/^#/){print ;next}else{ my $count=0; foreach $value (@F){if($value==0){ $count++ ;}};my $nf=@F;my $x=($nf-1)/2;print $nf."\t".$x."\t".$count."\n";if ($count < ($nf-1)/2){print $_;} }'  inputfile |less
