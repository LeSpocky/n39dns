#!/usr/bin/env ruby

if ARGV.count < 1 or ARGV[0].match(/\A((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.|$)){4}\z/).nil?
  puts "Usage: ./n39dns.rb [IP]\n"
  exit
end

require 'dnsimple'

CONFIG = YAML.load_file(File.expand_path('../config.yml', __FILE__))

DNSimple::Client.username = CONFIG['username']
DNSimple::Client.api_token = CONFIG['api_token']

domain = DNSimple::Domain.find(CONFIG['domain'])
records = DNSimple::Record.all(domain)

records.each do |record|
  if record.record_type.eql? 'A'
    record.content = ARGV[0]
    record.save
  end
end
