# Tmux Undo Guide
> "I messed up, how do I fix it?"

## I killed the wrong pane
Pane content is gone, but the session is still alive:
```bash
Prefix d                   # detach
tmux attach -t session-name  # reattach
```
The other panes in the window are still there.

## I can't find my session
```bash
tmux ls                    # list all sessions
tmux attach -t <name>      # attach to one
```

## I messed up my layout
```bash
Prefix r                   # reload config (panes persist)
# Or manually rearrange:
Prefix |                   # split horizontal
Prefix -                   # split vertical
Prefix x                   # kill unwanted pane
```

## I accidentally detached
```bash
tmux attach                # reattach to most recent session
tmux attach -t <name>      # reattach to specific session
```

## I can't tell if I pressed the prefix
Look at the right side of the status bar — the `PREFIX` indicator lights up in purple when you've pressed `Ctrl+a`.

## My pane is frozen
```bash
Ctrl+Q                     # unfreeze (accidental Ctrl+S locks terminal)
```
