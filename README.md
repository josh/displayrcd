# displayrcd

Run a script when your Mac changes displays.

## Installation

Install with Hombrew.

```
$ brew install josh/tap/displayrcd
$ brew services start josh/tap/displayrcd
```

## Configuration

Create a `~/.displayrc` file. This script will be ran whenever your Mac changes displays.

This example configuration hides the dock when using the MacBook display and shows it when connecting to a larger external display.

```shell
case "$DISPLAY_NAME" in
"Built-in Retina Display")
  osascript -e 'tell application "System Events" to tell dock preferences to set autohide to true'
  ;;
"Pro Display XDR")
  osascript -e 'tell application "System Events" to tell dock preferences to set autohide to false'
  ;;
esac
```

Environment Variables:

- `DISPLAY_NAME`: The display name. For MacBooks, the built-in display should be something like `"Built-in Retina Display"`.
