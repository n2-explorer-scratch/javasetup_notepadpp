# Setting up Java on Notepad++
## Install Notepad++
This seems to be the right URL, but please confirm beforehand: https://notepad-plus-plus.org/downloads/

I'm using Windows, debug info says "Build time : Jun 23 2020 - 23:59:56". I'm not doing anything version or OS specific to my understanding, however, but be aware that's what I'm testing this on.

I suggest using https://virustotal.com to check the installer/portable executable, as a general convention just in case something is exploited by a third-party. I can't guarantee that it won't return either a false positive or false negative.

## Install Java JDK
I just went here: https://www.oracle.com/java/technologies/downloads/

And chose the latest JDK (26, but I don't have a specific suggestion) for Windows, and got the x64 Compressed Archive, and then extracted it in my user home folder. You'll need the absolute path later

TODO: add screenshot

Direct link (please just see the original webpage and get it from there): https://download.oracle.com/java/26/latest/jdk-26_windows-x64_bin.zip

Direct hash: https://download.oracle.com/java/26/latest/jdk-26_windows-x64_bin.zip.sha256

## Install plugins
You'll need to install the following plugins for the basic IDE look:
- NppExec (https://github.com/d0vgan/nppexec): The main plugin necessary, shows a console at the bottom that provides for running text-based apps like powershell, java, and javac. Also allows for running and adding to menu custom scripts.
  - TODO: add screenshot
- Explorer (https://github.com/oviradoi/npp-explorer-plugin): Lets you view files in a tree format. I don't believe any configuration is required.
  - TODO: add screenshot

If you installed Notepad++, you can install these straight from the Plugins Admin menu (Plugins > Plugins Admin...), without needing to get the DLLs manually.
TODO: add screenshot

There are a bunch of other useful plugins. I recommend "Markdown Panel" (https://github.com/mohzy83/NppMarkdownPanel).

There is also a default feature Folder As Workspace, it's helpful for a summary of the project tree (drag project folder in) but doesn't let you modify/delete/add files/folders. You'll need the Explorer plugin for that.

## Specification of what I'm doing
The project tree convention being used here is this:
```
proj_folder
|_ src   // contains the source files. only directory needed initially
|___ packagename
|______subdirectory
|__________somethingdeeper.java
|______ something.java
|___ Main.java
|_ bin   // contains binaries. automatically generated
|_ changed.txt  // used by the compilation script at runtime, no need to edit
|_ hashes.txt   // used by the compilation script to compile only changed files
```
The compilation tool that I'm using is a PowerShell script, simply because I'm just learning about Java and want to see how far this will take me, before I need a dedicated compilation tool like Maven, Gradle, or Ant from what I've seen on the Internet. I don't know how to set those up yet.

## Configuring the plugins/setup
### NppExec
1. Download the PowerShell script in this repository, and replace the placeholder text at the top, in quotes, to the Java JDK absolute directory (right above \bin)
2. In Notepad++:
    1. Go to Plugins > NppExec > Execute...
    2. Paste the following in there (and replace the filler text _in angle brackets_):
       ```
       echo $(FULL_CURRENT_PATH)
       powershell.exe -executionpolicy bypass -file "<absolute path to the ps1 file you downloaded>" $(FULL_CURRENT_PATH)
       ```
    3. Press "Save..."
    4. Title the custom script ".java"
    5. Save it. (It will try and run, just go a random directory beforehand like C:\ so the PowerShell script halts before doing anything)

Now it's functional. Make sure that your project structure has proj_folder (pick whatever actual name you like), src under, and a java file somewhere inside src. To run:
- Navigate to the java file, like via the Explorer plugin, or just open it with File Explorer in Windows.
  - For convenience you can set .java files to always open with Notepad++, from File Explorer.
- In Notepad++, navigate to Plugins > NppExec > Execute...
- Choose ".java" from the dropdown (or whatever you called it) and click OK

Details: This will generate a hashes.txt with the relative paths of all java files in the src folder, and their SHA256 hashes. If a java file is changed between script runs, the hashes.txt file is updated and the file path is appended to changed.txt for that run. The `javac` command is executed with the file list changed.txt, before `java -cp bin <current class path>` is executed, depending on the currently open file in the editor.

`<current class path>` would be package.Main if you are running a src\package\Main.java open in the editor.

# Making the setup more useful (ideas)
## NppExec
- Make a "Run" custom script in NppExec, as follows: [^1]
  ```
  npp_exec $(EXT_PART)
  ```
  So, for example, if you made two custom scripts, ".java" and ".py"*, each would run for respective files.
- You can assign the "Run", or ".java" commands to a shortcut.
  - Go to Plugins > NppExec > Advanced Options...
  - Choose the Run or .java scripts from the Associated Script dropdown
  - Make a desired Item name, it can be the same
  - Press Add/Modify
  - Then, in Notepad++, go to Run > Modify Shortcut/Delete Command...
  - choose Plugin commands from the top,
  - filter for your custom script, and assign a shortcut. It will tell you if there is a conflict, F9 didn't conflict and was convenient for me.
- Error highlighting can be done via Plugins > NppExec > Console Output Filters...  
  Use `%FILE%:%LINE%: *error*` in the top box (altered from the default gcc suggestion at the bottom), press the checkmark to the left, and the U checkmark. (to enable and underline respectively)
  - `#D54309` (rgb hex code) looks nice in my opinion if you want a custom color
  - (the PowerShell script uses relative paths although that can be changed relatively easily)
- Console font/size can be changed; go to Plugins > NppExec > Change Console Font...
  - Consolas, Normal, size 10, worked for my screen.
- You can change default console color, go to Plugins > NppExec > Advanced Options...

## other stuff
On my version each panel in the window can be moved around, so I could put the console at the top or Explorer on the right for example.

\*(on a side note, I prefer to use Run > Run..., the Notepad++ default outside NppExec, for running Python, it works better with the `pygame` module)

[^1]: https://d0vgan.github.io/nppexec/NppExec_Manual/NppExec_Guide.html
