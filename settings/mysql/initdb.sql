-- Create Databases
CREATE DATABASE IF NOT EXISTS site1_db;
CREATE DATABASE IF NOT EXISTS site2_db;

-- Create Users and Assign Passwords
CREATE USER IF NOT EXISTS 'site1_user'@'%' IDENTIFIED BY 'bDOo0Emmbtc=';
CREATE USER IF NOT EXISTS 'site2_user'@'%' IDENTIFIED BY 'ZrYWMFOhtvk=';

-- Grant Privileges to Users
GRANT ALL PRIVILEGES ON site1_db.* TO 'site1_user'@'%';
GRANT ALL PRIVILEGES ON site2_db.* TO 'site2_user'@'%';

-- Apply Changes
FLUSH PRIVILEGES;
