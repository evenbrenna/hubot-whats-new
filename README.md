# hubot-whats-new

A hubot script to quickly see what's going on in your Github repo(s). Lists all commits to master (or your chosen branch) since the latest (or given) version/tag.


```
You   : hubot what's new in AwesomeProject

Hubot : There have been 2 commits to AwesomeProject's master branch since v1.0.0:
        - Complete awesome bugix (Murdock)
        - Start awesome bugix (Baracus)

        Diff on Github:
        https://github.com/org/repo/compare/v1.0.0...master
```

```
You   : hubot what's new in AwesomeProject since v0.9.3

Hubot : There have been 4 commits to AwesomeProject's master branch since v0.9.3:
        - Complete awesome bugix (Murdock)
        - Start awesome bugix (Baracus)
        - Complete v1 (Hannibal)
        - Start awesomeness (Face)

        Diff on Github:
        https://github.com/org/repo/compare/v0.9.3...master
```

## Installation

1. In hubot project repo, run: `npm install hubot-whats-new --save`  
2. Add **hubot-whats-new** to your `external-scripts.json`:

```json
[
  "hubot-whats-new"
]
```

## Configuration

You'll need to set some environment variables:

- `GITHUB_USERNAME` : The username to authenticate to Github with
- `GITHUB_APIKEY` : API key that grants repo access for the above user. Create one [here](https://github.com/settings/tokens/new).
- `GITHUB_USER` : The name of the user or organisation that owns the repo(s). Like in https://github.com/**this-part**/myrepo
- `GITHUB_REPOS` : Comma seperated list of the repos you want hubot to know about. All lowercase. Like this: `repo-one,repo2,etc`
- `GITHUB_BRANCH` : The branch that should be used for comparing. Defaults to master. Optional.


## Commands:

`hubot what's new in <repoName>` - List all commits since latest tag.

`hubot what's new in <repoName> since <tagName>` - Same as above but for given tag
