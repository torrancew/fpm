require "fpm/dependency"

class FPM::Dependency::Deb < FPM::Dependency
  def constraint
    case @constraint
    when :gt
      '>>'
    when :lt
      '<<'
    else
      super
    end # case @constraint
  end # def constraint
end # class FPM::Dependency::Deb

