# PsCheckUsersRc4
This is a PowerShell script tool for 
[Windows Kerberos authentication breaks after November updates](https://www.bleepingcomputer.com/news/microsoft/windows-kerberos-authentication-breaks-after-november-updates/)

This script is an easy and efficient way to check the RC4 encryption status for users in a specified OU or AD-group. It generates a detailed HTML report that includes all the necessary information, such as their username, passwordlastset, description, department, making it easier to manage and secure your Active Directory environment.
For each user, the script generates a row in the HTML report and populates it with the user's details 

![Example Report](https://github.com/fardinbarashi/PsCheckUsersRc4/raw/main/example.png)


```
The Column Only RC4 Enabled
No : Default : 0x0
Yes : Only RC4 : 0x4
```

If you want to change Password year go to line 
57, 82,83

The script uses a Try-Catch block to handle any errors that may occur during its execution. If an error occurs, the script writes a warning message to the console, stops the transcript, and exits the script.

How to Use
```
To use this script, follow these steps:
Open PowerShell as an administrator.
Navigate to the directory where the script is saved.
Run the script using the following command:

The variabels that can be edited are:
- $OU : Line 43 The distinguished name of the organizational unit to check.
- $AdGroupName : Line 43 The name of the AD group to check.

```
