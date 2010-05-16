module Hapyrus

  require "open-uri"

  class Hudson
    HUDSON_URI   = "http://localhost:18080"
    GENERAL_URI  = "#{HUDSON_URI}/api/json"
    COMPUTER_URI = "#{HUDSON_URI}/computer/api/json"
    MASTER_URI   = "#{HUDSON_URI}/computer/(master)/api/json"

    include Singleton

    def general_json
      @general_json ||= JSON.parse(open(GENERAL_URI).read) rescue {}
    end

    def computer_json
      @computer_json ||= JSON.parse(open(COMPUTER_URI).read) rescue {}
    end

    def master_json
      @master_json ||= JSON.parse(open(MASTER_URI).read) rescue {}
    end

    def slaves_json
      return [] if computer_json['computer'].nil? or computer_json['computer'].size == 1
      computer_json['computer'][1..-1] # remove [0] (master)
    end

  end
end
