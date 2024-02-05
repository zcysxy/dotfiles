#!/opt/homebrew/bin/bash

osascript << SCPT > /Users/ce/.font-list
    use framework "AppKit"
    set fontFamilyNames to (current application's NSFontManager's sharedFontManager's availableFontFamilies) as list
    return fontFamilyNames
SCPT
