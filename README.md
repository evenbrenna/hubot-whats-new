# hubot-whats-new

A hubot script that lists all commits since the latest (or given) version/tag

See [`src/whats-new.coffee`](src/whats-new.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-whats-new --save`

Then add **hubot-whats-new** to your `external-scripts.json`:

```json
[
  "hubot-whats-new"
]
```

## Sample Interaction

```
user1>> hubot what's new in myRepo
hubot>> There have been ​*4 commits*​ to ​*myRepos*​'s master branch since ​*v1.0.0*​:
        > Fix the things (Bob Builder)
        > Break the things (Douche Bag)
        > Fix the broken things (Super Man)
        See diff on GitHub here: https://github.com/<user/org>/<repo>/compare/v1.0.0...branch
```

or

```
user1>> hubot what's new in myRepo since v0.1.0
hubot>> There have been ​*114 commits*​ to ​*myRepos*​'s master branch since ​*v0.1.0*​:
        > Fix the things (Bob Builder)
        > Break the things (Douche Bag)
        > Fix the broken things (Super Man)
        > ...
        > ...
        > Initial commit
        See diff on GitHub here: https://github.com/<user/org>/<repo>/compare/v1.0.0...branch
```
