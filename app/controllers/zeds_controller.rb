class ZedsController < ApplicationController

  def index
    @zeds = Zed.all
  end

  def some

    render layout:'layouts/some_zed'
  end

end
