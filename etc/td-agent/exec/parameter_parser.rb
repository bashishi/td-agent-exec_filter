#!/opt/td-agent/embedded/bin/ruby
# -*- encoding: utf-8 -*-

require 'json'
require 'msgpack'
require 'uri'

keys = ["path", "referer", "url"]

while str = STDIN.gets
    str.chomp!
    begin
        s = JSON.parse(str)
        keys.each do |key|
            unless s[key].nil?
                uri = URI(s[key])
                query = uri.query
                unless query.empty?
                    q = query.split("&")
                    q.each do |param|
                        p = param.split("=")
                        k = key + "." + p[0].to_s
                        if p.length > 1 then
                          s[k] = p[1]
                        else
                          s[k] = ""
                        end
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

