#!/usr/bin/env ruby

require 'socket'
require_relative '../lib/memcached/server/static/Commands.rb'

host = ARGV[0]
port = ARGV[1]
server = TCPSocket.new(host, port)

listener = Thread.new {
    while response = server.gets()
        puts("Server: " + response)
    end
}

speaker = Thread.new {
    while true
        print("> ")
        server.puts(STDIN.gets())
        break if $_ =~ Commands::END_REGEX
        sleep(0.1)
    end
}

listener.join()
speaker.join()

server.close()