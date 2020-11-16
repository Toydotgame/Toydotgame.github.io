# Projects

## Personal Projects
### Lock Screen Changer
#### [GitHub Repository](https://github.com/Toydotgame/LockScreenChanger)
This is a simple Java GUI app I made beacuse my school put ina lock screen restriction. Of course; the school's IT system is botched, and it just uses and image in `C:\Program Files\images\`, usually `1.jpg`. All the application does is it creates a Batch file which gets itself UAC permissions, then overwrites the image with one you specify in the JARfile's current directory. Very simple - yet very overcomplicated with Java. I like it.
##### Post-Script: It just overwites any file in `C:\Program Files\images\` due to what name you give it. Therefore it'll be cross-compatible with other organisations if they, too, store the default lock images in `C:\Program Files\images\`.
##### Post-Post-Script: This only has been tested with Windows 10. Windows 8 and 8.1 should work as they have basically the same lock screen system. Windows 7's lock screen background is a lot more complicated, and isn't normally changed by people. (I don't think you can force the Windows 7 lock screen image to be un-changeable either) I don't know about Windows Server; props to you if that's what you're using to work on, but I don't know how their lock systems work. I presume Windows Server 2012, 2016, and 2019 would have the same lock screen look as we've had since Windows 8; and if so, this should work too.
###### Post-Post-Post-Script: Basically, if your lock screen image can be set to a file in a certain directory that it fetches each time the lock screen is shown, it should work.

### Elevator
#### [GitHub Repository](https://github.com/Toydotgame/Elevator)
This plugin is a simple elevator for Spigot 1.6.4, as no other plugin for 1.6.4 exists with this funtionality. Still in development.
Works with the command `/up <height>`, and teleports you up that many blocks on top of a glass block.

### Batch File Generator
#### [GitHub Repository](https://github.com/Toydotgame/batFileGenerator)
This is a simple one-line `.bat` file creator (which also adds a `pause` statement at the end). I made it because a friend's Command Prompt wouldn't work but batch files _did_; so I made this quick creator for her.

## Tutorials
* [How to Make an Instant-launching Shortcut to Minecraft](howToMakeInstantMinecraft.md)
