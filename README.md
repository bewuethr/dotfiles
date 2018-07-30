# Dotfiles

These are my configuration files with settings applicable to all machines I'm
using. Where possible, a conf file sources another, machine specific file, for
example: `.profile` sources `.profile_local`. The machine specific dotfiles
live in a private GitLab repo.

Much of the structure is inspired by [this great article by Anish
Athalye](http://www.anishathalye.com/2014/08/03/managing-your-dotfiles/). Anish
also created [Dotbot](https://github.com/anishathalye/dotbot/) to manage
dotfile installation, but I of course want to roll my own solution.
