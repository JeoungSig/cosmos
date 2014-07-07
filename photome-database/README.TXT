Database backup and restore

1   Backup
Firstly, for control database, we need to login with “mysql” account.
On the shell prompt, by using following command we can generate backup file that include database schemas and data to designated file.

shell> mysqldump -u root -p photome > photome_20131221.sql

To explain above command, login with root account (not OS account)  access to photome database  generate backup file named by photome_20131221.sql.

After giving this command to shell prompt, mysqldump require password of root user. If you key in right password for root user, it will start to generate backup file.

2   Restore
If you already made backup file, for restore with new backup file, firstly drop old database and then just create empty database with same name. 
And then just giving following command on the shell prompt.

shell> mysql -u root -p photome < photome_20131221.sql

To explain above command, login with root account (not OS account) 

     access to photome database 
     restore from backup file named by photome_20131221.sql.

After giving this command to shell prompt, mysql require password of root user. If you key in right password for root user, it will start to generate backup file.

It is recommended to generate backup file and save to separate location from PMS server. Then you can restore simply like above way if you meet some trouble safely to the point of backup time.
