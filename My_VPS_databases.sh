#!/usr/bin/env bash
#.:Databases Backups from /var/lib/mysql | VPS by .:BUDABUDAOK:.
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
echo "Dumping Database: espaciodeados_wp_site"
printf "\n"
mysqldump espaciodeados_wp_site > "espaciodeados_wp_site_bkp_$(date +"%d_%m_%Y").sql" ;
printf "\n"
echo "Dumping Database: proyectocanino_red_social"
printf "\n"
mysqldump proyectocanino_red_social > "proyectocanino_red_social_bkp_$(date +"%d_%m_%Y").sql" ;
printf "\n"
printf "\n"
printf "\n"
sleep 2;
echo "Moving database backups to /backups-globales directory..."
mv /var/lib/mysql/*.sql /backup/mysql
printf "\n"
printf "\n" 
printf "\n"  
echo "¡All backups were generated and relocated successfully!"
printf "\n"
printf "\n"
sleep 4;

rm /backup/mysql/void

find /backup/mysql -daystart -maxdepth 1 -mtime +0,25 -type f -name "*.sql" > /backup/mysql/void
if [ -s /backup/mysql/void ]
	then
		printf "\n"
		echo "We find the following old backups:"
		printf "\n"
		printf "\n"
		find /backup/mysql -daystart -maxdepth 1 -mtime +0,25 -type f -name "*.sql";
		sleep 3;
		rm /backup/mysql/void ; touch /backup/mysql/void
		printf "\n"
		printf "\n"
		read -r -p "¿Do you want to delete it at all? [y/n] " inputmyselection

					  case $inputmyselection in
					        s|si|S|SI|y|Y|Yes|YES)
							printf "\n"
							printf "\n"
							echo "Okay, deleting the old backup files..."
							find /backup/mysql -daystart -maxdepth 1 -mtime +0,25 -type f -name "*.sql" -delete 
							printf "\n"
							sleep 2;
							printf "\n"
							echo "¡Done! these are the last backups on the server:"
							printf "\n"
							find /backup/mysql -name "*.sql" -type f
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
					      	find /backup/mysql -name "*.sql" -type f
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
      	find /backup/mysql -name "*.sql" -type f
		sleep 2;
		printf "\n"
		echo "End of the script... Good Bye!"
		printf "\n"
		printf "\n"
fi


exit 0;
