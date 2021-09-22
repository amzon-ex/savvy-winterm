# savvy-winterm

An AutoHotKey script to open Windows Terminal from anywhere (Inspired by [this](https://blog.danskingdom.com/Bring-up-the-Windows-Terminal-in-a-keystroke/) guide). It respects the current state of the application:
 - If not running, runs it.
 - If running and in focus, minimizes.
 - If running and not in focus, brings it to focus.
Additionally, if Windows Explorer is open, you can use the hotkey (by default, `Win+C`) to open the terminal at the current folder. Otherwise, it opens in the default user folder `%USERPROFILE%`.
