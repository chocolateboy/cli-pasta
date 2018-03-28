# frozen_string_literal: true

# by default, ruby blurts out a bunch of noise on Ctrl-C:
#
#   ^CTraceback (most recent call last):
#           1: from -e:1:in `<main>'
#   -e:1:in `sleep': Interrupt
#
# in contrast, core utilities like grep, sed &c. just exit
# without further ceremony
if Signal.list.include?('INT')
  Signal.trap('INT') { exit 1 }
end
