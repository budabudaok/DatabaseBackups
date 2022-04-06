#!/usr/bin/env bash
#.:Databases Backups from /var/lib/mysql | ICINGA2 by .:BUDABUDAOK:.
IFS="$"

printf "\n"
printf "\n" 
printf "\n"  
echo "We are going to dump the databases of icinga2 to /backups-globales directory.."
printf "\n"
sleep 4;
printf "\n"
cd /var/lib/mysql ;
printf "\n"
echo "Dumping Database: icinga2"
printf "\n"
mysqldump icinga2 > "icinga2_bkp_$(date +"%d_%m_%Y").sql" ;
printf "\n"
echo "Dumping Database: director"
printf "\n"
mysqldump director > "director_bkp_$(date +"%d_%m_%Y").sql" ;
printf "\n"
echo "Dumping Database: icinga2web"
printf "\n"
mysqldump icinga2web > "icinga2web_bkp_$(date +"%d_%m_%Y").sql" ;
printf "\n"
echo "Dumping Database: live_event_hbomax"
printf "\n"
mysqldump live_event_hbomax > "live_event_hbomax_bkp_$(date +"%d_%m_%Y").sql" ;
printf "\n"
echo "Dumping Database: elemental"
printf "\n"
mysqldump elemental > "elemental_bkp_$(date +"%d_%m_%Y").sql" ;
printf "\n"
echo "Dumping Database: ottowiki"
printf "\n"
mysqldump ottowiki > "ottowiki_bkp_$(date +"%d_%m_%Y").sql" ;
printf "\n"
printf "\n"
printf "\n"
sleep 2;
echo "Moving database backups to /backups-globales directory..."
mv /var/lib/mysql/*.sql /backups-globales
printf "\n"
printf "\n" 
printf "\n"  
echo "¡All backups were generated and relocated successfully!"
printf "\n"
printf "\n"
sleep 4;

rm /backups-globales/void

find /backups-globales -daystart -maxdepth 1 -mtime +0,25 -type f -name "*.sql" > /backups-globales/void
if [ -s /backups-globales/void ]
	then
		printf "\n"
		echo "We find the following old backups:"
		printf "\n"
		printf "\n"
		find /backups-globales -daystart -maxdepth 1 -mtime +0,25 -type f -name "*.sql";
		sleep 3;
		rm /backups-globales/void ; touch /backups-globales/void
		printf "\n"
		printf "\n"
		read -r -p "¿Do you want to delete it at all? [y/n] " inputmyselection

					  case $inputmyselection in
					        s|si|S|SI|y|Y|Yes|YES)
							printf "\n"
							printf "\n"
							echo "Okay, deleting the old backup files..."
							find /backups-globales -daystart -maxdepth 1 -mtime +0,25 -type f -name "*.sql" -delete 
							printf "\n"
							sleep 2;
							printf "\n"
							echo "¡Done! these are the last backups on the server:"
							printf "\n"
							find /backups-globales -name "*.sql" -type f
							printf "\n"
							echo "End of the script... Good Bye!"
							printf "\n"
							printf "\n"
					      ;;
					       n|no|N|NO)
							printf "\n"
							printf "\n"
					      	echo "Okay, we won't do anything with the old backups. "
					      	printf "\n"
					      	sleep 2;
					      	printf "\n"
					      	echo "These are the last backups on the server:"
							printf "\n"
					      	find /backups-globales -name "*.sql" -type f
							sleep 2;
							printf "\n"
							echo "End of the script... Good Bye!"
							printf "\n"
							printf "\n"
					      ;;
					      *)
							printf "\n"
							printf "\n"
					    echo "Please.. drink a cup of coffee, you chooseen a wrong option."
					    	sleep 2;
					    	printf "\n"
							printf "\n"
							echo "End of the script... Good Bye!"
							printf "\n"
							printf "\n"
					      ;;
					  esac
	else
		printf "\n"
		echo "We don't find any old backup."
		printf "\n"	
		printf "\n"
      	echo "These are the last backups on the server:"
		printf "\n"
      	find /backups-globales -name "*.sql" -type f
		sleep 2;
		printf "\n"
		echo "End of the script... Good Bye!"
		printf "\n"
		printf "\n"
fi


exit 0;
