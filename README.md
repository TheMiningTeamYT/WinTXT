# WinTXT
WinTXT -- A Command Line Text Editor For Windows
# 1: Introduction
WinTXT is a command-line utility for writing/editing text documents written in batch script. It's fairly bare-bones, but it gets the job done if you need/want a command line text editor for windoes.
WinTXT began when I was inspired by a video of a Batch OS text editor and thought (I can make that!) And so I did.
Because it's so basic, it's pretty easy to use.
# 2: How to use.
With WinTXT, to edit a text file, simply go to the command line, navigate to where you have Wintext.bat stored, then type "wintext" followed by the path to the text document you want to edit, for just open WinTXT in explorer and use the built in menu.
When you get in, to use commands you type these at the "Type" Prompt:
/exit : Exit the program
/undo : Undo the last thing you typed in
/help : View the help page.
/redo : Redo the last thing you un-did
/del : Delete the document you're working on (You can undo this with /undo)
/linebreak : Insert a linebreak
# 3: Limitations
This text editor has no creature comforts. Fancy formatting? Nope. Search and replace? Forget about it. Even just searching? Nada. 
You just type in text line by line. However, as people more talented then me join and contribute to WinTXT, hopefully some of these things will be added in.
# 4: Conclusion
This text editor is great if you have 10KB left on your disk. Otherwise, as of now it's a bottlenecked to the point of near uselessness text editor made in 1 day by someone who isn't great at batch scripts.


#5 : Undocumented Features
With the latest v2.3 update, there are new commands.
WARNING: THESE AREN'T MEANT FOR USERS, THESE ARE MEANT FOR PROGRAMS USING WINTXT!
/h - The -? command with the ability to modify the program name
Syntax: /h [name in all lowercase]
/n - Set the name of the program displayed in all screens
Syntax: /n [Your name in normal case]
WARNING:
The /h flag if used should only ever be the only flag, and the /n flag should only ever be the final flag.
So I think this is 1 feature (mostly) unique to WinTXT (I can't think of anyother text editor off the top of my head where you can chage the displayed program name with reskinning)
