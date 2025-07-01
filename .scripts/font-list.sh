 #!/opt/homebrew/bin/bash

# This script retrieves a list of all installed font families on macOS
# and saves them to a file, with each font name on a new line.

osascript <<'SCPT' > /Users/ce/.font-list
	use framework "AppKit"
	
	-- Get the list of font family names from the system
	set fontFamilyNames to (current application's NSFontManager's sharedFontManager's availableFontFamilies) as list
	
	-- Save the current text delimiter
	set oldDelimiters to AppleScript's text item delimiters
	
	-- Set the delimiter to a newline character
	set AppleScript's text item delimiters to {linefeed}
	
	-- Coerce the list of fonts into a single string, with each item separated by the new delimiter
	set fontListString to fontFamilyNames as text
	
	-- Restore the original delimiter (this is good practice)
	set AppleScript's text item delimiters to oldDelimiters
	
	-- Return the final, newline-separated string
	return fontListString
SCPT
