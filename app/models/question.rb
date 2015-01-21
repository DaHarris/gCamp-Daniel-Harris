
class Question

  attr_accessor :question, :answer, :slug

  def sluggin (questions)
    return "#{questions.parameterize}"
  end

end
