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
