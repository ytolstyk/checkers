class InvalidMoveError < StandardError
  def message
    "You tried to perform an invalid move.\n
    Start with your piece followed by a sequence of moves.\n
    ex: a0 c2 e4"
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