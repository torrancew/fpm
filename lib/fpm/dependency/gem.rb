require 'fpm/dependency'

class FPM::Dependency::Gem < FPM::Dependency
  def self.constraints
    super << :sv
  end # def self.constraints

  def operator
    case @constraint
    when :sv
      '~>'
    else
      super
    end
  end
end

