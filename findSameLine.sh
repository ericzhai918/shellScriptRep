#方法一
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
#方法二
for a in $(cat a.txt); do
    for b in $(cat b.txt); do
        if [[ $a == $b ]]
        then
          echo $a
        fi
    done
done
