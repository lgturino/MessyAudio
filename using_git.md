# Using Git with Godot

There's not really any difference between using git with Godot than using git in
general. The only thing to know is that you should exclude the .godot/ directory
of the project, but that is automatically excluded in the .gitignore file.

## Using git in the terminal / wsl

Pull from repo
```
git clone git@github.com:lgturino/MessyAudio.git 
```

Make changes you want to make. You can check what files you have edited by doing
`git status`

Once you want to record your edits to git,
1. do `git add <files>` to "stage" the files (you can do `git add -A` to stage
   all edited files)
2. then commit the staged files, `git commit -m "<message of what you changed>"`

Now, you'll be able to do `git log` to see your commit in the git history.

Then, make sure to share it to github by doing `git push` 
- The first time, you might need to do `git push -u origin main` to tell git you
  want to push your `main` branch (your local copy) to the `origin` (the repo in
  github.com)

After a while, someone might push their changes, at which time you'll need to
retrieve them from github by running `git pull`

If there are conflicts between repos, you will need to merge them -- let me know
if you need help with it.

## Using Godot via the editor plugin

There's an official git plugin that you can use directly from the editor, I
haven't tried it yet -- let me know if you want to use it and want help installing it.
(it seems it hasn't been added to the new asset store yet, so you have to donwload it manually)

https://docs.godotengine.org/en/stable/tutorials/best_practices/version_control_systems.html

## Using your own Git tool

You can e.g. open the project via VS Code and use the VS Code git plugin.
