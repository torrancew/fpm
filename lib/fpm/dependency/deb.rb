require 'fpm/dependency'

class FPM::Dependency::Deb < FPM::Dependency
  def self.constraints
    return super.merge(:gt => '>>', :lt => '<<')
  end # def self.constraints

  def to_s
    return "#{name} (#{operator} #{version})"
  end # def to_s
end # class FPM::Dependency::Deb

