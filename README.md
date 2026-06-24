# Setting up Java on Notepad++
## Install Notepad++
This seems to be the right URL, but please confirm beforehand: https://notepad-plus-plus.org/downloads/

I'm using Windows, debug info says "Build time : Jun 23 2020 - 23:59:56". I'm not doing anything version or OS specific to my understanding, however, but be aware that's what I'm testing this on.

I suggest using https://virustotal.com to check the installer/portable executable, as a general convention just in case something is exploited by a third-party. I can't guarantee that it won't return either a false positive or false negative.

## Get Java JDK
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

## Compile/Run Programs
All the techniques here use NppExec custom scripts, to run code within the console on button or key press.

The first way that I did this was through a manual script, that compiled all .java files in the project source directory before running a specific Main class.

That was rigid, so I added some more sophistication such that the currently open file in the editor will run, and only changed files are compiled. You can find out about using that method in [manual_compilation/compiling_with_powershell.md](manual_compilation/compiling_with_powershell.md)

## Shortcut, Editing, and Formatting Tips
For that information (such as binding the run script to a shortcut) refer to [editing_tips.md](editing_tips.md)
