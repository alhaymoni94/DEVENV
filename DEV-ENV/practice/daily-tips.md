1. Use `Ctrl+R` to search command history instead of typing the same command again.
2. `cd -` takes you back to the previous directory — no need to type the full path.
3. `!!` repeats your last command. `sudo !!` reruns it with sudo.
4. `Ctrl+W` deletes the last word in the terminal. `Ctrl+U` deletes the entire line.
5. `mkdir -p a/b/c/d` creates nested directories in one command.
6. `grep -r "pattern" .` searches recursively through all files.
7. `find . -name "*.py" -type f` finds all Python files.
8. `tar -czf archive.tar.gz dir/` creates a compressed archive.
9. `diff <(sort file1) <(sort file2)` compares two files ignoring line order.
10. `Ctrl+L` clears the terminal screen (same as `clear`).
11. `tmux new -s name` creates a named session. `Ctrl+B, D` detaches without killing it.
12. `git add -p` lets you stage changes interactively, hunk by hunk.
13. `git log --oneline --graph --all` shows a visual branch history.
14. `cheat <tool>` is faster than searching the web for basic commands.
15. `qr <tool>` gives you a one-page summary — perfect for quick lookup.
16. `cheat --undo <tool>` saves you when you make a mistake.
17. `tip` gives you a random pro tip every time you run it.
18. `doctor.sh` checks your entire stack health in seconds.
19. `lg` (lazygit) is faster than memorizing git commands.
20. `y` (yazi) lets you navigate files visually without leaving the terminal.
21. `ai "your question"` gets you answers without opening a browser.
22. `cat file.py | ai "explain this"` lets AI analyze any file.
23. `e .` opens the directory browser in micro — great for exploring.
24. `Ctrl+/` in micro toggles comments on selected lines.
25. `Ctrl+D` in micro duplicates the current line.
26. `btop` shows CPU, RAM, disk, and network in one beautiful view.
27. `lzd` (lazydocker) makes container management visual and easy.
28. `vd file.csv` opens spreadsheets in the terminal with visidata.
29. `glow README.md` renders markdown beautifully in the terminal.
30. `cheat --start` takes you on a 2-minute interactive tour of the entire stack.
31. `camp progress` shows exactly where you are in the curriculum.
32. `camp next` tells you what lesson to work on next.
33. `camp submit <phase>` submits your work for supervisor review.
36. `docker run -d --name web -p 8080:80 nginx` runs a web server in one command.
37. `docker compose up -d` starts an entire multi-service app from one file.
38. `docker system prune` cleans up unused containers, images, and networks.
39. `docker logs container-name` shows what a container printed to stdout.
40. `docker exec -it container-name bash` opens a shell inside a running container.
34. Always run `doctor.sh` after setup.sh to verify everything installed correctly.
35. Use `chezmoi apply` to sync your dotfiles after making changes.
