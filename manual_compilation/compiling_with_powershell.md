# Using PowerShell to compile and run .java files
## Specification
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
I made this when I was just learning about Java and wanted to see how far it would take me, before I need a dedicated compilation tool like Maven, Gradle, or Ant. However, I'll try migrating to one of those to properly handle dependencies.

## Configuring the plugins/setup
### NppExec
1. Download the PowerShell script [run_java.ps1](run_java.ps1), and replace the placeholder text at the top, in quotes, to the Java JDK absolute directory (right above \bin)
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
- Open the java file, like via the Explorer plugin, or just open it with File Explorer in Windows.
- In Notepad++, navigate to Plugins > NppExec > Execute...
- Choose ".java" from the dropdown (or whatever you called it) and click OK

Details: This will generate a hashes.txt with the relative paths of all java files in the src folder, and their SHA256 hashes. If a java file is changed between script runs, the hashes.txt file is updated and the file path is appended to changed.txt for that run. The `javac` command is executed with the file list changed.txt, before `java -cp bin <current class path>` is executed, depending on the currently open file in the editor.

`<current class path>` would be package.Main if you are running a src\package\Main.java open in the editor.
