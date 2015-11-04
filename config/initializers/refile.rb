# config/initializers/refile.rb
require "refile/s3"
require 'refile/simple_form'

aws = {
  access_key_id: ENV['AWS_PUBLIC'],
  secret_access_key: ENV['AWS_SECRET'],
  region: ENV['S3_REGION'],
  bucket: ENV['S3_BUCKET'],
}

Refile.cache = Refile::S3.new(max_size: 20.megabytes, prefix: "cache", **aws)
Refile.store = Refile::S3.new(max_size: 20.megabytes, prefix: "store", **aws)