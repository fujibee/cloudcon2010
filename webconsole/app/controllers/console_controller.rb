class ConsoleController < ApplicationController

  layout 'hapyrus', :only => :index
  def index
    @master = Hapyrus::Hudson.instance.master_json
    @slaves = Hapyrus::Hudson.instance.slaves_json
    @hadoop = Hapyrus::Hudson.instance.hadoop_json
  end

  def master
    respond_to do |format|
      format.json { render :json => Hapyrus::Hudson.instance.master_json }
    end
  end

  def slaves
    respond_to do |format|
      format.json { render :json => Hapyrus::Hudson.instance.slaves_json }
      # format.json { render :json => Array.new(1) }
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
