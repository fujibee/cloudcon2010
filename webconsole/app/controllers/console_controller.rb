class ConsoleController < ApplicationController
  def index
    @master = Hapyrus::Hudson.instance.master_json
    @slaves = Hapyrus::Hudson.instance.slaves_json
  end
end
