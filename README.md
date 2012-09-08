Dotup is a tool for managing the various dotfiles under my home directory,
along with the dotfiles themselves. It was designed with 3 main aims:

1. It has to be easy to install (especially from chef recipes)
2. It needs to be easy to change files on any machine and share those changes everywhere
3. There needs to be a way to override some files on some machines

Quickstart
==========

*Back up your home directory before starting. I have made every effort to
be non-destructive, but there is no guarantee that this script won't break
things. It runs some scripts to update a number of important files under
your home directory, so there is the potential for something going wrong.*

The best way to get started is to clone this repo, change `REPO` at the
top of `bin/dotup`, replace the contents of `dotfiles` with your own
setup and then run the dotup file. The project is designed to be self-
installing, so you can do something like this:

    curl -Ls 'https://raw.github.com/jcinnamond/dotup/master/bin/dotup' | bash 

but obviously replace the url with your cloned repo.


How it works
============

The project works in a pretty standard way. All the dotfiles are
stored in a git repo and are then symlinked into place under your home
directory. The `dotup` bash script is designed to make it easy to set
this up.

When run for the first time it will check out the repo to $HOME/.dotup
and them symlink all of the files under `dotfiles` to the corresponding
place under your home directory. For example, placing a file under
`dotfiles/.ssh/rc` will result in it being symlinked to $HOME/.ssh/rc. If
a file already exists at the symlink destination then it is copied to
$HOME/.dotup/restore before being replaced by a symlink.

I've tried to follow a principle of being non-destructive so as well
as copying existing files to the `restore` directory the script will
occasionally refuse to do things. If this happens it will try to tell
you what happened and why. In spite of this approach, there is still a
risk that things will go wrong, so make sure you know what you're doing
and be careful to back files up before using this tool.

Updating dotfiles
=================

On any machine with dotup installed you should be able to modify, add
or remove files under `$HOME/.dotup/dotfiles` and then use git add/rm
and commit as normal. Once you have pushed those changes you simply
need to run `dotup` on other machines to pull in the changes and create
the symlinks.

You can see if there are any pending changes by running:

    dotup status

This will show you 2 things. First, it shows you any files that you
have modified or added to your dotfiles directory but haven't committed
yet. Second, it shows any new commits that have been pushed to github
that you haven't applied yet, or any commits that you have made locally
that haven't been pushed to github yet.

Machine specific overrides
==========================

There are 2 approaches to overriding the behaviour of config files on a
per-machine basis. The first (and best way) is to use conditional logic
in the config file where this is available. For example, in my .zshrc
I can add:

    local_config="$HOME/.zshrc.local"
    if [ -r local_config ]; then
      source local_config
    fi

However, if the config file doesn't support conditional includes or if
you simply don't want a file to be installed at all then you can tell
dotup to ignore that file. To this this, create a file in your home
directory called `.suppress-dotup`. In there, put the path to the each
file you want suppressed on a line on its own. For example, if I want
to suppress .ssh/rc and .zshrc then I would create `.suppress-dotup`
with the following content:

    .ssh/rc
    .zshrc

*There is currently no support for wildcards or suppressing whole directories.*

Uninstalling
============

The uninstall should be as simple as running

    dotup remove

If all goes well, this will put your home directory back to the way it
was before dotup was installed, including restoring any files that were
in the way when dotup first ran.

Licence
=======

Copyright (c) 2012, John Cinnamond
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the <organization> nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL JOHN CINNAMOND BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
