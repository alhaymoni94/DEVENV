# Tmux Undo Guide
> "I closed a pane/window/session by accident — how do I get it back?"

## I closed a pane by accident
Tmux doesn't have an "undo pane close" — but you can:
```
Ctrl+B, %                    # recreate vertical split
Ctrl+B, "                    # recreate horizontal split
```
**Prevention**: Use `Ctrl+B, x` (with confirmation prompt) instead of `Ctrl+D`.

## I closed a window by accident
```
Ctrl+B, c                    # create a new window
Ctrl+B, 0-9                  # switch back to the window you need
```
**Tip**: Name your windows so you can find them: `Ctrl+B, ,` then type a name.

## I detached from a session
Your session is still running! Reattach:
```bash
tmux attach                  # reattach to last session
tmux attach -t session-name  # reattach to specific session
tmux ls                      # list all sessions
```

## I killed a session by accident
If you ran `tmux kill-session`, the processes inside are gone.
However, if you had scrollback you need:
```bash
# If you enabled logging (recommended):
ls ~/tmux-logs/              # check saved logs
```
**Prevention**: Add this to `~/.tmux.conf`:
```
bind K confirm-before -p "Kill session #S? (y/n)" kill-session
```

## I lost my scrollback buffer
```
Ctrl+B, [                    # enter copy mode
# Use arrow keys or vim keys to scroll
# Press q to exit copy mode
```
**Increase buffer size** in `~/.tmux.conf`:
```
set -g history-limit 50000
```

## I messed up my tmux config
```bash
# Reload the default config
tmux source-file ~/.tmux.conf

# If tmux is broken entirely:
# Kill all sessions and start fresh
tmux kill-server
tmux                         # start new session with defaults
```

## I accidentally sent a key to the wrong pane
```
Ctrl+B, :                    # open tmux command prompt
send-keys -t pane-index C-c  # send Ctrl+C to specific pane
```

## Recovery checklist
1. `tmux ls` — find your sessions
2. `tmux attach -t <name>` — reattach
3. Recreate panes/windows as needed
4. Check logs if you had them enabled
