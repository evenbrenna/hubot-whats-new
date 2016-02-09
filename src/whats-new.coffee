# Description
#   A hubot script that lists all commits since the latest (or given) version/tag
#
# Configuration:
#   The scripts needs access to the Github API and uses the following env vars:
#   GITHUB_USERNAME -> The username to authenticate to Github with
#   GITHUB_APIKEY   -> An API key that grants repo access for the above user
#   GITHUB_USER     -> The name of the user or organisation that owns the repo(s)
#   GITHUB_REPOS    -> Comma seperated list of the repos you want included. All Lowercase!
#   GITHUB_BRANCH   -> Optional. The branch that should be used for comparing. Defaults to master.
#
# Commands:
#   hubot what's new in <repoName> - Lists all commits to master since latest tag
#   hubot what's new in <repoName> since <tagName> - Same as above but for given tag
#
# Author:
#   Even Brenna <evenbrenna@gmail.com>

module.exports = (robot) ->
  robot.respond /(what.?s new in) (.+)/i, (msg) ->
    userName = process.env.GITHUB_USERNAME
    APIKey   = process.env.GITHUB_APIKEY
    user     = process.env.GITHUB_USER
    repos    = process.env.GITHUB_REPOS

    if !userName || !APIKey || !user || !repos
      return msg.send "You must set the following environment variables: GITHUB_USERNAME, GITHUB_APIKEY, GITHUB_USER, GITHUB_REPOS"

    # Authenticated root URL of Github API
    rootUrl = "https://#{userName}:#{APIKey}@api.github.com"

    # Parse message
    version = ""
    words = msg.match[2].split(/\s+/i)
    repo = words[0].toLowerCase()

    if repo not in repos.split ","
      return msg.send "Don't know, don't care about #{words[0]}.. (Have you set GITHUB_REPOS to a lowercase, comma separated (no spaces) list of repo names?)"

    # Set version to latest or given tag
    robot.http("#{rootUrl}/repos/#{user}/#{repo}/tags")
      .get() (err, res, body) ->

        if err
          return msg.send "Ran into some trouble: #{err}"

        tagsResponse = JSON.parse body

        if words[1] && words[1].toLowerCase() == "since" && words[2]
          version = words[2]
        else
          version = tagsResponse[0].name

        # Get commits since given tag
        branch = process.env.GITHUB_BRANCH || "master"
        robot.http("#{rootUrl}/repos/soundioas/#{repo}/compare/#{version}...#{branch}")
          .get() (err, res, body) ->
            if err
              return msg.send "Ran into some trouble: #{err}"

            response = JSON.parse body
            numCommits = response.ahead_by

            if numCommits == undefined
              return msg.send "There is no version named \"#{version}\""

            if numCommits > 0
              lineEnd = ":"
            else
              lineEnd = " :("

            answer = "There have been *#{numCommits} commits* to *#{repo}*'s #{branch} branch since *#{version}*#{lineEnd}"

            if numCommits > 0
              for commit in response.commits
                message = commit.commit.message.split("\n\n").join(": ")
                commitString = "\n> #{message} (#{commit.commit.author.name})"
                answer += commitString
              answer += "\n\nSee diff on GitHub here: #{response.html_url}"
            msg.send answer
