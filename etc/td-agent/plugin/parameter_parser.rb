#!/opt/td-agent/embedded/bin/ruby
# -*- encoding: utf-8 -*-

require 'json'
require 'msgpack'
require 'uri'
require 'date'

str = "{\"path\":\"http://example.com/abc?param1=xxx\"}"

while str = STDIN.gets
    str.chomp!
    begin
        s = JSON.parse(str)
        unless s["path"].nil?
            uri = URI(s["path"])
            query = uri.query
            unless query.empty?
                q = query.split("&")
                q.each do |param|
                    p = param.split("=")
                    if p.length > 1 then
                      s["path." + p[0].to_s] = p[1]
                    else
                      s["path." + p[0].to_s] = ""
                    end
                end
            end
        end
    rescue => ex
        s = str 
    end
    print MessagePack.pack(s)
    STDOUT.flush
end

