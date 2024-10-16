set appName to "Arc"

if application appName is running then
	tell application "System Events"
		tell application process appName
			set frontmost to true
		end tell
	end tell
else
  tell application appName to activate
end if
