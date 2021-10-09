# How to Create an Instant-Launch Shortcut for Minecraft
\* Internet connection required<br>
\* Tutorial made for Windows XP and higher



## Step 1: Preperation
### 1A: Download ProcessExplorer
Download [Process Explorer](https://live.sysinternals.com/procexp.exe) from SysInternals, it's a Microsoft-approved application which has a feature that shows the command-line command used to launch any running application on your PC.
### 1B: Open your Minecraft Launcher
Open Minecraft's Launcher on your desktop, make sure you have selected the profile for your client.
### 1C: Open ProcessExplorer
Make sure that you have Process Explorer open, and that you are on a screen that looks a bit like this:
![](https://docs.microsoft.com/en-us/media/landing/sysinternals/processexplorer.jpg)



## Step 2: Finding the Command-Line Arguments
### 2A: Launch Minecraft
Launch your selected Minecraft client from the launcher. Do not close it until you reach the step telling you to do so.
### 2B: Get the Arguments
* Switch back to Process Explorer (Do not close your Minecraft client)
* Look [and scroll if necessary] for the process `javaw.exe` in the task list.
  * Right click on it
  * Select _Properties_.
* Highlight the contents of the _Command line_ box in the newly opened window: (In your case there will be text there, this example image does not have it)<br>
![](https://www.filecroco.com/wp-content/uploads/2016/11/process-explorer-6.jpg)
* Copy the contents of the _Command line_ box. (`Ctrl`+`C`)

#### If ProcessExplorer Doesn't Run:
* Open either Command Prompt or PowerShell. (`Win`+`R`; then type either `cmd` or `powershell`, press _OK_)
* Type `tasklist`.
 * Find `javaw.exe` on the left of the list.
 * Look at the number to the immediate right of `javaw.exe` (This is the _PID_)
* Type the following command: `wmic.exe path Win32_Process where handle='x' get Commandline /format:list`. Replace `x` with the PID you just got.
* Copy the output of that command.

### 2C: Creating the Batch File
* Open _Notepad_. (`Win`+`R`, type in `notepad`, press _OK_; or search for "`Notepad`" in the Start menu)
* Paste the text. (`Ctrl`+`V`)
* Save the file _as_. (`Ctrl`+`S`)
  * Click the address bar at the top of the window.
  * Type in the following: `%AppData%\.minecraft\`
  * Go to the _Name:_ box. Type in `runmc.bat`.
    * Make sure that is all that is in the box, `.txt` might be there - make sure it is not.
  * Click the dropdown next to _Save as type:_.
  * Select _All files (\*.\*)_.
  * Press _Save_.



## Step 3: File Management
### 3A: The _natives_ files.
#### For older launchers:
Whilst your Minecraft client is open, open File Explorer, go to the address bar, and type `%AppData%\.minecraft\`.
* Double-click the `versions` folder.
* Double-click the folder in `versions` which your client is using; it's usually `1.x.x` (OptiFine installations are usually `1.x.x_OptiFine_HD_xx`)
* There will be a folder in it which ends with `-natives`. If not, move to the "For newer versions" section below.
* Copy that folder. (Click on it and press `Ctrl`+`C`)

* Go back to `%AppData%\.minecraft\`
* Create a new folder and call it something like `quickLaunch`
* Go into that folder and paste. (`Ctrl`+`V`)

* Go back to `%AppData%\.minecraft\`
* Find `runmc.bat`.
* Right click it.
  * Select _Edit_.
* Once Notepad opens, press `Ctrl`+`F`; then type in `-Djava.library.path=`. Press _Find_.

* Go back to File Explorer. (You should be in `%AppData%\.minecraft\` still)
* Open the new `quickLaunch` folder.
* Open the folder inside. (The one ending in `-natives`)
* Click the address bar, copy the text inside it. (`Ctrl`+`C`)

* Go back to Notepad.
* After `-Djava.library.path=`, delete the text. Stop deleting once you reach a space (` `) \[or a quotation mark (`"`) (Only if right after `-Djava.library.path=`, there was a `"`)\] (Basically once you reach the start of the next argument. I believe it starts with `-Dminecraft.~.*` or something. (Not 100% sure though, so be careful!))
* Paste in the new folder location. (`Ctrl`+`V`)
* Press `Ctrl`+`S` to save.
#### For newer launchers:
Whilst your Minecraft client is open, open File Explorer, go to the address bar, and type `%AppData%\.minecraft\`.
* Double-click the `bin` folder.
* Open a new File Explorer window and go to `%AppData%\.minecraft\`.
* Right-click `runmc.bat`.
* When Notepad opens, press `Ctrl`+`F`.
  * Type `-Djava.library.path=`.
  * Press _Find_.
* Look to the end of the file path, before the next argument. (The next argument starts with a `-`)
* Take note of the folder. It will look something like `C:\Users\`_User_`\AppData\Roaming\.minecraft\bin\xxxx-xxxx-xxxx-xxxx`.
  * Note the `xxxx-xxxx-xxxx-xxxx` at the end.

* Go back to the File Explorer window which is in `%AppData%\.minecraft\bin\`.
* Copy the folder which has the same name as the one from Notepad (After `-Djava.library.path=`). (`Ctrl`+`C`)

* Go back to `%AppData%\.minecraft\`
* Create a new folder and call it something like `quickLaunch`
* Go into that folder and paste. (`Ctrl`+`V`)

* Go back to `%AppData%\.minecraft\`
* Find `runmc.bat`.
* Right click it.
  * Select _Edit_.
* Once Notepad opens, press `Ctrl`+`F`; then type in `-Djava.library.path=`. Press _Find_.

* Go back to File Explorer. (You should be in `%AppData%\.minecraft\` still)
* Open the new `quickLaunch` folder.
* Open the folder inside. (The one formatted like `xxxx-xxxx-xxxx-xxxx`)
* Click the address bar, copy the text inside it. (`Ctrl`+`C`)

* Go back to Notepad.
* After `-Djava.library.path=`, delete the text. Stop deleting once you reach a space (` `) \[or a quotation mark (`"`) (Only if right after `-Djava.library.path=`, there was a `"`)\] (Basically once you reach the start of the next argument. I believe it starts with `-Dminecraft.~.*` or something. (Not 100% sure though, so be careful!))
* Paste in the new folder location. (`Ctrl`+`V`)
* Press `Ctrl`+`S` to save.
### 3B: Desktop Shortcut
* Go to your desktop. (`Win`+`D`)
* Right-click.
  * Click _New_.
  * Click _Shortcut_.
    * It will ask for the location of the file.
    * Type `%AppData%\.minecraft\runmc.bat`.
    * Press _Next_.
    * Fill the box with a name for you shortcut, something like _`Minecraft`_.
    
## Congratulations! You've just made a shortcut direct to Minecraft, no launcher needed.
### You are able to close the Notepad, Minecraft and File Explorer windows now.
### `ProcessExplorer.exe` can safely be deleted from your _Downloads_ folder, nothing else though!
    
