class String
  def to_uri
    URI(self)
  end
end

module Hapyrus

  module Net
    def open_via_socks5(url)
      require 'socksify'
      require 'net/http'
      TCPSocket::socks_server = "127.0.0.1"
      TCPSocket::socks_port = 1081
      ::Net::HTTP.start(url.host, url.port) do |http|
        http.get(url.path).body
      end
    end
  end

  class Hudson
    include Hapyrus::Net

    HUDSON_URI   = "http://h121.star-bed.net:8080"
    GENERAL_URI  = "#{HUDSON_URI}/api/json"
    COMPUTER_URI = "#{HUDSON_URI}/computer/api/json"
    MASTER_URI   = "#{HUDSON_URI}/computer/(master)/api/json"
    HADOOP_URI   = "#{HUDSON_URI}/hadoop/api/json"

    include Singleton

    def general_json
      @general_json ||= JSON.parse(open_via_socks5(GENERAL_URI.to_uri)) rescue {}
    end

    def computer_json
      @computer_json ||= JSON.parse(open_via_socks5(COMPUTER_URI.to_uri)) rescue {}
    end

    def master_json
      @master_json ||= JSON.parse(open_via_socks5(MASTER_URI.to_uri)) rescue {}
    end

    def slaves_json
      return [] if computer_json['computer'].nil? or computer_json['computer'].size == 1
      computer_json['computer'][1..-1] # remove [0] (master)
    end

    def hadoop_json
      @hadoop_json ||= JSON.parse(open_via_socks5(HADOOP_URI.to_uri)) rescue {}
    end
  end
end
