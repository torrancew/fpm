require 'fpm/dependency'

class FPM::Dependency::Gem < FPM::Dependency
  def self.constraints
    super.merge(:sv => '~>')
  end # def self.constraints
end

