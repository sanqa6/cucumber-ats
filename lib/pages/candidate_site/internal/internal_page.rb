module InternalPage

  #override load to config the client in path by default
  def load
    super(client: CONFIG['CLIENT'])
  end

end