#!/opt/td-agent/embedded/bin/ruby
# -*- encoding: utf-8 -*-

require 'json'
require 'msgpack'
require 'date'

fdate = '%Y/%m/%d %H:%M:%S'

while str = STDIN.gets
    str.chomp!
    begin
        s = JSON.parse(str)
        s.store("FlunetdTime", DateTime.now.strftime(fdate))
    rescue
        s = str 
    end
    print MessagePack.pack(s)
    STDOUT.flush
end

