class Wall < Point
  def sprite
    @sprite ||= "0x259#{1 + rand(2)}".hex.chr("UTF-8") * 2
  end

  def is_wall?
    true
  end
end
