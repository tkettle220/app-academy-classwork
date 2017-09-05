require 'json'

class Flash
  attr_reader :flash, :flashnow

  def initialize(req)

    if req.cookies["_rails_lite_app_flash"]
      @flashnow = JSON.parse(req.cookies["_rails_lite_app_flash"])
    else
      @flashnow = {}
    end
    @flash = {}
  end

  def [](key)
    @flashnow[key.to_s] || @flash[key.to_s]
  end

  def []=(key, val)
    @flash[key.to_s] = val
    @flashnow[key.to_s] = val
  end

  def store_flash(res)
    res.set_cookie('_rails_lite_app_flash', {path: '/', value: @flash.to_json} )
  end

  def now
    @flashnow
  end


end
