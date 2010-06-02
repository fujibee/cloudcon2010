class ConsoleController < ApplicationController

  def num
    140
  end

  layout 'hapyrus', :only => [:index, :job, :more]
  def index
    computers = Hapyrus::Hudson.instance.computer_json['computer']
    @initial = computers ? computers.size : 0
    # @initial = num
  end

  def more
  end

  def jobs
  end

  def job
    respond_to do |format|
      format.html {
        @job = Hapyrus::Hudson.instance.latest_job
        render
      }
      format.json { render :json => Hapyrus::Hudson.instance.latest_job }
    end
  end

  def master
    respond_to do |format|
      format.json { render :json => Hapyrus::Hudson.instance.master_json }
    end
  end

  def slaves
    respond_to do |format|
      # format.json { render :json => Hapyrus::Hudson.instance.computer_json }
      format.json { render :json => {:computer => Array.new(num)} }
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
