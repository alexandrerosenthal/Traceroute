#!/bin/bash
rm -rf route.xdot
rm -rf route.pdf
compteur=1
echo 'digraph G {' >> route.xdot
for i in *.rte
do
	echo $i
	taille=$(wc -l $i|cut -d " " -f 1)
	echo $taille
	while [ $compteur -lt $taille ]
	do
		compteura=$(($compteur + 1))
		a=$(cat $i|head -n $compteura|tail -n 1)
		b=$(cat $i|head -n $compteur|tail -n 1)
		((++compteur))
		echo "\"$b\"->\"$a\" [label=\"$i\"]" >> route.xdot	
	done
	compteur=1
done
echo } >> route.xdot
dot -Tpdf route.xdot -o route.pdf
xdot route.xdot
atril route.pdf
