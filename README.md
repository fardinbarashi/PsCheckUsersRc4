# PsCheckUsersRc4
This is a PowerShell script that checks if users in a specified organizational unit (OU) have RC4 encryption enabled or not or a ADGroup. The script generates an HTML report that includes user details such as their username, password last set date, description, department, whether or not RC4 encryption is enabled for the user, and whether their password has been changed since the year XXXX.

The script starts with defining some settings such as transcript and error settings. It then proceeds with the main section of the script, which connects to the specified OU and gets all enabled users. The users are then sorted based on their password last set date, and the script checks if RC4 encryption is enabled for each user.

For each user, the script generates a row in the HTML report and populates it with the user's details. The report is then saved in an HTML file in a specified directory.

The script uses a Try-Catch block to handle any errors that may occur during its execution. If an error occurs, the script writes a warning message to the console, stops the transcript, and exits the script.
