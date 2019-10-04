#!/bin/bash
echo 'Entrez le nom de fichier de sorti :'
read fichier
echo 'Entrez une IP ou un nom de domaine :'
read ip
mttl=1
protocole('-I' '-T')
commande=$(traceroute -n -A $protocole -m $mttl $ip)
for i in $protocole
do
	for $mttl in $(seq 1 10)
	do
		$($commande)>>"$1.rte"
	done
done
