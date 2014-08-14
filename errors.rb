class InvalidMoveError < StandardError
  def message
    "You tried to perform an invalid move."
  end
end

class InvalidCoordinates < StandardError
  def message
    "At least one of your coordinates is invalid.\n
    ex: c4 d5"
  end
end

class InvalidPiece < StandardError
  def message
    "That's not your piece."
  end
end
