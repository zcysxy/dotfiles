# tell application "iTerm"
#     create window with default profile
#     activate
# end tell

# set appName to "WezTerm"
#
# if application appName is running then
#   Do Shell Script "/Applications/WezTerm.app/Contents/MacOS/wezterm-gui"
# else
#   tell application appName to activate
# end if

set appName to "kitty"

if application appName is running then
  Do Shell Script "/Applications/kitty.app/Contents/MacOS/kitty"
else
  tell application appName to activate
end if
