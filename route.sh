#!/bin/bash
echo 'Entrez le nom de fichier de sorti :'
read fichier
mttl=1
protocole(-I -T)
commande=$(traceroute -n -A $protocole -m $mttl )
for i in $protocole
do
	for $mttl in $(seq 1 10)
	do
		$($commande)>>"$1.rte"
	done
done
