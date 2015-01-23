
class Question

  attr_accessor :question, :answer, :slug

  def sluggin
    return "#{question.parameterize}"
  end

end
