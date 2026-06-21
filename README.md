# Setting up Java on Notepad++
## Install Notepad++
This seems to be the right URL, but please confirm beforehand: https://notepad-plus-plus.org/downloads/

I'm using Windows, debug info says "Build time : Jun 23 2020 - 23:59:56". I'm not doing anything version or OS specific to my understanding, however, but be aware that's what I'm testing this on.

I suggest using https://virustotal.com to check the installer/portable executable, as a general convention just in case something is exploited by a third-party. I can't guarantee that it won't return either a false positive or false negative.

## Install Java JDK
I just went here: https://www.oracle.com/java/technologies/downloads/

And chose the latest JDK (26) for Windows, and got the x64 Compressed Archive, and then extracted it in my user home folder. You'll need the absolute path later

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

## Specification of what I'm doing
The project tree convention being used here is this:
```
proj_folder
|_ src   // contains the source files. only directory needed initially
|___ packagename
|______ something.java
|___ Main.java
|_ bin   // contains binaries. automatically generated
|_ changed.txt  // used by the compilation script at runtime, no need to edit
|_ hashes.txt   // used by the compilation script to compile only changed files
```
The compilation tool that I'm using is a PowerShell script, simply because I'm just learning about Java and want to see how far this will take me, before I need a dedicated compilation tool like Maven, Gradle, or Ant from what I've seen on the Internet. I don't know how to set those up yet.

## Configuring the plugins/setup
### NppExec
1. Download the PowerShell script, and replace the placeholder text at the top, in quotes, to the Java JDK absolute directory (right above \bin)
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
- Navigate to the java file, like via the Explorer plugin, or just open it with 

, but some tips that will make the plugin more helpful:
- 
