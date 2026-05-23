#!/usr/bin/env ruby
#
# mrbgems test runner
#

if __FILE__ == $0
  this_file = File.expand_path __FILE__
  repository, dir = 'https://github.com/mruby/mruby.git', 'tmp/mruby'
  build_args = ARGV

  Dir.mkdir 'tmp'  unless File.exist?('tmp')
  unless File.exist?(dir)
    system "git clone #{repository} #{dir}"
  end
  Dir.chdir dir
  system "git checkout 4.0.0"

  exit system(%Q[MRUBY_CONFIG=#{this_file} ruby minirake #{build_args.join(' ')}])
end

MRuby::Build.new do |conf|
  toolchain :gcc
  conf.gembox 'default'

  conf.gem core: "mruby-socket"
  conf.gem core: "mruby-io"
  conf.gem core: "mruby-pack"
  conf.gem :git => 'git@github.com:iij/mruby-mtest.git'

  conf.gem File.expand_path(File.dirname(__FILE__))
  conf.enable_test
end
