#!/bin/bash
echo 'Entrez le nom de fichier de sortie :'
read fichier
echo 'Entrez une IP ou un nom de domaine :'
read ip
ttl=0
mttl=30
scenario=("-I" "-U -p 80" "-U -p 443" "-U -p 53" "-U -p 123" "-U -p 22" "-T -p 80" "-T -p 443" "-T -p 53" "-T -p 123" "-T -p 22")
while [ $ttl != $mttl ]
do
        ((++ttl))
        for scen in "${scenario[@]}"
        do
                commande="traceroute -n -A $scen -f $ttl -m $ttl -N 1 -q 1 $ip -w 30"
                if [ $ttl -ge 10 ]
                        then
                                testcible=$($commande|cut -d " " -f 3|tail -n 1)
                                if [ "$testcible" != '*' ]
                                        then
                                                $commande|cut -d " " -f 3,4|tail -n 1  >> $fichier.rte
						echo "Scenario utilisé pour trouver l'adresse : $scen"
                                                break
                                fi
                        else
                                testcible=$($commande|cut -d " " -f 4|tail -n 1)
                                if [ "$testcible" != '*' ]
                                        then
                                                $commande|cut -d " " -f 4,5|tail -n 1  >> $fichier.rte
						echo "Scenario utilisé pour trouver l'adresse : $scen"
                                                break
                                fi
                fi
                if [ "$scen" == '-T -p 22' ]
                then
                        if [ "$testcible" = '*' ]
                        then
				echo "Routeur de ttl=$ttl intouvé"
                                echo "* ttl=$ttl" >> $fichier.rte
                        fi
                fi
        done
        if [ "$testcible" == "$ip" ]
        then
                break
        fi
done

