# Useful improvements
* In my version of Notepad++, each panel can be moved, so the file tree could be put on the right for example, or the console could be moved out to make more editing space. Grab by each "titlebar"
* You may need to go to Settings > Style Configurator... and in the Global Styles setting disable "Enable global foreground colour" to ensure that the default Java syntax highlighting comes through. Otherwise all text might be black, for example.
* For convenience you can set .java files to always open with Notepad++, from File Explorer.

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

\*(on a side note, I prefer to use Run > Run..., the Notepad++ default outside NppExec, for running Python, it works better with the `pygame` module)

[^1]: https://d0vgan.github.io/nppexec/NppExec_Manual/NppExec_Guide.html

## QuickText
For automatic keyword replacement (e.g. "sout" for "System.out.println") you can install the QuickText plugin from Plugins Admin.[^2] (the plugin's GitHub repo has some incongruous information with the version i'm using, but here it is: https://github.com/vinsworldcom/nppQuickText)
  * Then go to Plugins > QuickText > Options...
  * Make sure language in top left says "Java"
  * Add a new Tag, "sout", and fill the below box with "System.out.println($);", for example. (`$` representing where the cursor should jump to)
  * Press Add/Modify
  * You'll need to make a shortcut for replacement, this can be <kbd>Alt</kbd>+<kbd>Enter</kbd>:
    * Go to Macro > Modify Shortcut/Delete Macro...
    * Go to Plugin Commands
    * Filter for "Replace Tag"
    * Assign a shortcut, I recommend <kbd>Alt</kbd>+<kbd>Enter</kbd>. <kbd>Tab</kbd> conflicts with indentation
    * After pressing Ok, you can try out typing "sout" in the editor and it will replace after <kbd>Alt</kbd>+<kbd>Enter</kbd>.

[^2]: I have tried editing the java.xml AutoComplete settings document, but not found a relevant provision for replacement. You could try finding it at https://npp-user-manual.org/docs/auto-completion/.


