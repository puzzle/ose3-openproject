#!/usr/bin/env ruby

ENV['RAILS_ENV'] ||= 'production'

require 'fileutils'
require '/opt/app-root/src/config/environment.rb'

def update(repo)
  puts "Update #{repo.url}"
  Dir.chdir(repo.url) do
    puts %x[git remote update]
  end
end

def init(repo)
  puts "Init #{repo.url}"

  # Try to extract the actual repository URL from the database entry
  url_path = repo.url[/^.*\/git\/(.*)$/, 1]
  domain   = repo.url[/^.*\/git\/([\w\-\.]+)\/(.*)$/, 1]
  if url_path.nil?
    STDERR.puts("Unable to determine url from repo path: #{repo.url}")
    return
  end

  # Evaluate git credentials
  credentials = ENV['GIT_CREDENTIALS_' + url_path.gsub(/\W/, '_')] ||
                ENV['GIT_CREDENTIALS_' + domain.gsub(/\W/, '_')]   ||
                nil

  url_credentials = credentials ? credentials + '@' : ""

  url = 'https://' + url_credentials + url_path
  parent_dir = File.dirname(repo.url)

  FileUtils.mkdir_p(parent_dir)
  puts %x[git clone --quiet --mirror #{url} #{repo.url}]
end

Repository.all.each do |repo|
  # non-managed git repo. non-managed svn repos have a scm_type of existing
  next unless repo.scm_type == 'local'
  puts "repo: #{repo.url} project: #{repo.project}"

  # change git.puzzle.ch to gitlab.puzzle.ch
  if repo.url =~ /git\.puzzle\.ch/
      repo.url = repo.url.sub('git.puzzle.ch','gitlab.puzzle.ch')
      repo.root_url = repo.root_url.sub('git.puzzle.ch','gitlab.puzzle.ch')
      puts "repo updated: #{repo.url}"
      repo.save!
  end
  # remove trailing .git
  if repo.url =~ /\/\.git\/?$/
      repo.url = repo.url.gsub(/\/\.git\/?$/,'')
      repo.root_url = repo.root_url.gsub(/\/\.git$/,'')
      puts "repo updated: #{repo.url}"
      repo.save!
  end
  # migrate old paths
  unless repo.url =~ /^\/opt\/app-root\/data\/git/
      repo.url = repo.url.gsub(/^.*\/repositories/,'/opt/app-root/data/git')
      repo.root_url = repo.root_url.gsub(/^.*\/repositories/,'/opt/app-root/data/git')
      puts "repo updated: #{repo.url}"
      repo.save!
  end

  if File.directory?(repo.url)
    update(repo)
  else
    init(repo)
  end
  #repo.fetch_changesets
  puts "repo finished: #{repo.url}"
end

puts "Fetch changesets"
#Repository.fetch_changesets
