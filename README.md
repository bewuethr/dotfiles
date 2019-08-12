# Dotfiles

These are my configuration files with settings applicable to all machines I'm
using. Where possible, a file sources another, machine specific file, for
example: `.profile` sources `.profile_local`. The machine specific dotfiles
live in a private GitLab repo.

This repo is best cloned as a bare repository straight into `$HOME`. [This
Gist][1] contains a script that clones the repository, configures it to ignore
untracked files and do sparse checkout (so `README.md` and `LICENSE` don't show
up), and initializes all the submodules. It can be run like this, preferably in
`$HOME`:

```sh
bash <(curl https://gist.githubusercontent.com/bewuethr/4d044f84989cb430a8b9c46dc4ea75c9/raw)
```

Notice that this *overwrites* existing dotfiles.

From now on, dotfiles can be manipulated with `git df`; for example, after a
change to `.bashrc`, you'd use

```sh
git df add .bashrc
git df commit -m "Update .bashrc"
git df push
```

## Credits

The structure of using two repositories with generally applicable dotfiles in
the first sourcing machine specific ones from the second was inspired by [this
great article by Anish Athalye][2].

I've seen the idea of using a bare repository for dotfiles first in [this
comment by StreakyCobra on Hacker News][3]. People then expanded on the idea
and wrote about it, specifically Nicola Paolucci in his [tutorial][4] (adding
the idea of using something like a Gist for initialization and pointing out
problems if the files exist already) and Harfang in a [blog post][5].

[1]: https://gist.github.com/bewuethr/4d044f84989cb430a8b9c46dc4ea75c9
[2]: http://www.anishathalye.com/2014/08/03/managing-your-dotfiles
[3]: https://news.ycombinator.com/item?id=11071754
[4]: https://www.atlassian.com/git/tutorials/dotfiles
[5]: https://harfangk.github.io/2016/09/18/manage-dotfiles-with-a-git-bare-repository.html
