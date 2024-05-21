# Installation using a git bare repository

Update .gitignore to avoid weird recursion problems:

```
echo ".dotfiles" >> .gitignore
```

Clone your dotfiles into a bare repository in a "dot" folder of your $HOME:

```
git clone --bare <git-repo-url> $HOME/.dotfiles
```

Define the alias in the current shell scope:

```
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

Checkout the actual content from the bare repository to your $HOME:

```
dotfiles checkout
```

Set the flag `showUntrackedFiles` to no on this specific (local) repository:

```
config config --local status.showUntrackedFiles no
```

You can now type config commands to add and update your dotfiles:

```
dotfiles status
dotfiles add .zshrc
dotfiles commit -m "Add zshrc"
dotfiles add .bashrc
dotfiles commit -m "Add bashrc"
dotfiles push
```
