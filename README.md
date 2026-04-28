# README

## How to Run the Project

### 1. Download the project from GitHub

Go to the GitHub web page and download the project as a ZIP file.

After that, extract the ZIP file and open the project folder in VS Code.

### 2. Download the SQL file

Download the SQL file from the folder image > sql > katoonmodels_db.sql

Then place it into your local SQL on your computer.

### 3. Run the SQL file

Open MySQL or MySQL Workbench.

Run the SQL file in your local SQL.

### 4. Run another SQL file

Create another SQL file and paste this code:

CREATE USER IF NOT EXISTS 'root123'@'localhost' IDENTIFIED BY 'root12345678';

GRANT ALL PRIVILEGES ON katoonmodels_db.* TO 'root123'@'localhost';

FLUSH PRIVILEGES;

Then run this SQL file too.

### 5. Start the server

Open the terminal in the project folder.

Run this command:

node server.js

### 6. Open with Live Server

Open the HTML file in VS Code.

Then click **Open with Live Server**.

The project is now ready to use.
