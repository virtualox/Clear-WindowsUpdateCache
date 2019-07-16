## Contents
 - [Description](#description)
 - [Usage](#usage)
 - [FAQ](#faq)
 - [Tested on following Windows Versions](#tested-on-following-windows-versions)

## Description

This is a PowerShell script to the Clear the Windows Update Cache. The Windows Update Cache is a special folder that stores the update installation files. It is located at the root of your system drive in *C:\Windows\SoftwareDistribution\Download*.

## Usage

You can run the script directly from Windows Powershell, there are no extra command line options or parameters needed.

## FAQ

**Q:** Can I run the script safely?  
**A:** Definitely not. You have to understand what the functions do and what will be the implications for you if you run them. **If you're not sure what the script does, do not attempt to run it!**

**Q:** What Windows Versions are compatible with this script?  
**A:** See [Tested on following Windows Versions](#tested-on-following-windows-versions).

**Q:** Are elevated rights needed to run this script?  
**A:** Yes, you'll need administrator rights to delete files and folders under systemdirectories.

**Q:** Did you test the script?  
**A:** See [Tested on following Windows Versions](#tested-on-following-windows-versions).

**Q:** I really like the script. Can I send a donation?  
**A:** Feel free to send donations via [PayPal](https://paypal.me/VirtualOx). Any amount is appreciated, but keep in mind that donations are completely voluntary and I'm not obliged to make any script adjustments in your favor regardless of the donated amount.

## Tested on following Windows Versions

Verified on the following platforms:

|Windows Version         |Yes/No?|
|:-----------------------|:-----:|
| Windows Server 2019    | No    |
| Windows Server 2016    | Yes   |
| Windows Server 2012 R2 | Yes   |
| Windows Server 2012    | Yes   |
| Windows Server 2008 R2 | Yes   |
| Windows Server 2008    | Yes   |
| Windows Server 2003    | No    |
| Windows 10             | Yes   |
| Windows 8              | No    |
| Windows 7              | Yes   |
| Windows Vista          | No    |
| Windows XP             | No    |
| Windows 2000           | No    |

It is likely to work on other platforms as well. If you try it and find that it works on another platform, please let me know.
