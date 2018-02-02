#比较两个文本中的内容，将相同行输出

#method 1
cat a.txt | while read linea
    do
      cat b.txt | while read lineb
      do
         if [[ $linea == $lineb ]]
         then
            echo $linea
         fi
      done
  done

#method 2
for a in $(cat a.txt); do
    for b in $(cat b.txt); do
        if [[ $a == $b ]]
        then
          echo $a
        fi
    done
done

#method 3
for i in $(cat b.txt); do
  grep "$i" a.txt
done

#method 4
comm -12 <(sort a.txt|uniq) <(sort b.txt|uniq)
