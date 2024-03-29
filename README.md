# savvy-winterm

An AutoHotKey script to open Windows Terminal from anywhere (Inspired by [this](https://blog.danskingdom.com/Bring-up-the-Windows-Terminal-in-a-keystroke/) guide). It respects the current state of the application:
 - If not running, runs it.
 - If running and in focus, minimizes.
 - If running and not in focus, brings it to focus.

Additionally, if Windows Explorer is open (and in focus), you can use the hotkey (by default, `Win+Alt+C`) to open the terminal at the current folder. Otherwise, it opens in the default user folder `%USERPROFILE%` or whatever your terminal was set to.

`auto-term-anywhere.ahk` is a v1 script. `auto-term-anywhere-v2.ahk` is a v2 script, converted conveniently using this [v1-to-v2 converter](https://github.com/mmikeww/AHK-v2-script-converter).

#### TO-DO:
1. Network locations create an issue
#### Remarks:
1. If the terminal loses focus on launch and your default shell is in WSL, it might be related to <https://github.com/microsoft/wslg/issues/443>