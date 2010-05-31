class ConsoleController < ApplicationController

  def num
    0
  end

  layout 'hapyrus', :only => [:index, :jobs]
  def index
    # @initial = Hapyrus::Hudson.instance.computer_json.size
    @initial = num
  end

  def jobs
    @map_initial = 30
    @reduce_initial = 30
  end

  def master
    respond_to do |format|
      format.json { render :json => Hapyrus::Hudson.instance.master_json }
    end
  end

  def slaves
    respond_to do |format|
      # format.json { render :json => Hapyrus::Hudson.instance.computer_json }
      format.json { render :json => Array.new(num) }
    end
  end

  def hadoop
    respond_to do |format|
      format.json { render :json => Hapyrus::Hudson.instance.hadoop_json }
    end
  end

  def debug
    @master = Hapyrus::Hudson.instance.master_json
    @slaves = Hapyrus::Hudson.instance.slaves_json
    @hadoop = Hapyrus::Hudson.instance.hadoop_json
  end
end
