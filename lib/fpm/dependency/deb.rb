require 'fpm/dependency'

class FPM::Dependency::Deb < FPM::Dependency
  def operator
    case @constraint
    when :gt
      '>>'
    when :lt
      '<<'
    else
      super
    end # case @constraint
  end # def constraint

  def to_s
    "#{name} (#{operator} #{version})"
  end # def to_s
end # class FPM::Dependency::Deb

