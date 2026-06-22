# Useful editing improvements
* In my version of Notepad++, each panel can be moved, so the file tree could be put on the right for example, or the console could be moved out to make more editing space. Grab by each "titlebar"
* You may need to go to Settings > Style Configurator... and in the Global Styles setting disable "Enable global foreground colour" to ensure that the default Java syntax highlighting comes through. Otherwise all text might be black, for example.

## QuickText
For automatic keyword replacement (e.g. "sout" for "System.out.println") you can install the QuickText plugin from Plugins Admin.[^1] (the plugin's GitHub repo has some incongruous information with the version i'm using, but here it is: https://github.com/vinsworldcom/nppQuickText)
  * Then go to Plugins > QuickText > Options...
  * Make sure language in top left says "Java"
  * Add a new Tag, "sout", and fill the below box with "System.out.println", for example.
  * Press Add/Modify
  * You'll need to make a shortcut for replacement, this can be the same as your autocompletion shortcut (like <kbd>Tab</kbd>):
    * Go to Macro > Modify Shortcut/Delete Macro...
    * Go to Plugin Commands
    * Filter for "Replace Tag"
    * Assign a shortcut, I recommend <kbd>Tab</kbd>, don't worry about the conflict message
    * After pressing Ok, you can try out typing "sout" in the editor and it will replace after <kbd>Tab</kbd>

[^1]: I have tried editing the java.xml AutoComplete settings document, but not found a relevant provision for replacement. You could try finding it at https://npp-user-manual.org/docs/auto-completion/.


