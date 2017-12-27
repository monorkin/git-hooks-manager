# git-hooks-manager

## About

`git-hooks-manager` is a __simple__ script for managing your
[git-hooks](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks).

It allows for the definition of local and global hooks. Local hooks live in
a project's `.git/hooks/hook-name-hooks/` directory, while global hooks live in
`~/.git-templates/.global-hooks/hook-name-hooks`.

Multiple hooks can be run off the same event, e.g. if you have

```Bash
ls .git/hooks/commit-msg-hooks
# foo.sh bar.rb baz.py

ls ~/.git-templates/.global-hooks/commit-msg-hooks
# cux.rb
```

All scripts (`foo.sh`, `bar.rb`, `baz.py` and `cux.rb`) would get run in
alphabetical order, and global hooks would take precedence.
Execution order: `cux.rb` (since it's global), `bar.rb`, `baz.py` and finally
`foo.sh`.

It's automatically setup whenever you clone or initialize a repo.

## Motivation

This project was developed as part of another project and was published here.

There are two other projects with similar functionalities:

* [icefox/git-hooks](https://github.com/icefox/git-hooks)
  - Requires manual setup for each project (for security reasons)
  - Non-standard hook configuration

* [git-hooks/git-hooks](https://github.com/git-hooks/git-hooks)
  - Requires manual setup for each project
  - Dependant on Go (for building)

The idea was to create a simple, yet understandable script that would offer most
of the features that the two, previously mentioned, projects provide.

The goal was for it to be as-close-as-possible to a standard Git experience and
utilize as many UNIX features as possible, for it to be compatible between
Linux, BSD, and MacOS.

## Installation

Run:

```Bash
curl https://raw.githubusercontent.com/stankec/git-hooks-manager/master/.install.sh | bash
```

__Please note__ that executing any script with `curl | bash` is a security
risk. Therefore download and carefully review the code before executing it.

## Examples

### Spell checking

Executing the following will enforce spell-checks on all (globally) the commit
messages you write, if an error is found your commit will be rejected.

```Bash
curl https://raw.githubusercontent.com/icefox/git-hooks/master/contrib/commit-msg/spellcheck > ~/.git-templates/.global-hooks/commit-msg-hooks/spellcheck.sh
chmod +x ~/.git-templates/.global-hooks/commit-msg-hooks/spellcheck.sh
```

### Up-to-date copyright year

Execute the following in the root of a Git-enabled project to enforce up-to-date
copyright notice checks on only that project.

```Bash
curl https://raw.githubusercontent.com/icefox/git-hooks/master/contrib/pre-commit/copyright_year > .git/hooks/pre-commit-hooks/copyright_year.sh
chmod +x .git/hooks/pre-commit-hooks/copyright_year.sh
```

## License

This project is licensed under the GPLv3. Please refer to the comments in the
beginning of all the files, and the [license text](/LICENSE) included with
this project.

This software comes with no warranty.
