require "fpm/namespace"
require "cabin"

class FPM::Dependency
  include Cabin::Inspectable

  class UnknownConstraint < StandardError; end

  attr_accessor :package, :constraint
  
  class << self
    # This method is invoked when subclass occurs.
    # 
    # Lets us track all known FPM::Package subclasses
    def inherited(klass)
      @subclasses ||= {}
      @subclasses[klass.name.gsub(/.*:/, '').downcase] = klass
    end # def inherited

    # Get a list of all known package subclasses
    def types
      return @subclasses
    end # def types

    # Get the type of this package class.
    #
    # For "Foo::Bar::BAZ" this will return "baz"
    def type
      self.name.split(':').last.downcase
    end # def type

    # List supported constraints
    def constraints
      [:gt, :ge, :lt, :le, :eq, :ne]
    end
  end # class << self

  # Get the Dependency Name
  def name
    return @package.name if @package
    return nil
  end # def name

  # Get the Dependency Version
  def version
    return @package.version if @package
    return nil
  end # def version

  # Get the Dependency Constraint as a String
  def operator
    case @constraint
    when :gt
      '>'
    when :ge
      '>='
    when :lt
      '<'
    when :le
      '<='
    when :eq
      '='
    when :ne
      '!='
    else
      raise UnknownConstraint, "Unknown constraint: #{@constraint.inspect}"
    end
  end # def constraint

  def to_s
    return "#{name} #{operator} #{version}"
  end # def to_s

  private

  def initialize(pkg, version=0, constraint=:ge)
    unless self.class.constraints.include?(constraint)
      raise UnknownConstraint, "Unknown constraint: #{@constraint.inspect}"
    end

    @logger          = Cabin::Channel.get
    @constraint      = constraint
    @package         = pkg
    @package.version = version.to_s if version
  end # def initialize
end # class FPM::Dependency
