# Added to .irbrc
require 'rubygems'
require 'hirb'
Hirb::View.enable
require 'irb/completion'
require 'map_by_method'
require 'what_methods'
require 'ap'
IRB.conf[:AUTO_INDENT]=true