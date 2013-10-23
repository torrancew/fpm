require 'fpm'
require 'fpm/dependency/deb'

pkg = FPM::Package::Gem.new
pkg.input('fpm-0.4.42.gem')

dep = FPM::Dependency::Deb.new(pkg, 0, :ge)
puts dep.to_s

