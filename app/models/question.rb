
class Question

  attr_accessor :question, :answer

  def slug
    "#{question.parametize}"
  end

end
