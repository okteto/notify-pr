#!/usr/bin/env ruby
require "octokit"
require "json"

if !ENV["GITHUB_TOKEN"]
    puts "Missing GITHUB_TOKEN"
    exit(1)
end

if ENV["GITHUB_EVENT_NAME"] != "pull_request"
    puts "This action only supports pull_request events."
    exit(1)
end

message = ARGV[0]
repo = ENV["GITHUB_REPOSITORY"]

json = File.read(ENV.fetch("GITHUB_EVENT_PATH"))
event = JSON.parse(json)
pr = event["number"]

github = Octokit::Client.new(access_token: ENV["GITHUB_TOKEN"])
comments = github.issue_comments(repo, pr)
exists = comments.find { |c| c["body"] == message }

if exists
    puts "Message already exists in the PR"
    exit(0)
end

github.add_comment(repo, pr, message)