# qlab script tools

Chris Greenhalgh, The University of Nottingham, 2018

Some explorations about scripts for plays, captioning and linking to qlab.

There are:

- [nodeapp](nodeapp/README.md), a simple tool to read a Word file formatted in a certain way and produce other intermediate files for use with other tools

- [applescript](applescript/README.md) utilities, in particular a script to read a file from the above and generate corresponding QLab cues

Known Issues:

- qlab cues are created every time the script is run (should only create/update existing cues where present)
- cues currently only for OSC link to Joe's tool, hardcoded to OSC patch 1
- script format is rather unforgiving at present
