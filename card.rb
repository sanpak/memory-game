
class Card
  attr_accessor :face_value, :face_down, :display
  def initialize(face_value,face_down=true,display=:X)
    @face_value = face_value
    @face_down = face_down
    @display = display
    @display = :O if face_down == false
  end

  def hide
    face_down = true
    display = :X
  end

  def reveal
    face_down = false
    face_value
  end


end
