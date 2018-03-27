# clipasta

<!-- [![Gem Version](https://badge.fury.io/rb/clipasta.svg)](https://badge.fury.io/rb/clipasta) -->
[![Build Status](https://travis-ci.org/chocolateboy/clipasta.svg)](https://travis-ci.org/chocolateboy/clipasta)

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [NAME](#name)
- [INSTALL](#install)
- [SYNOPSIS](#synopsis)
- [DESCRIPTION](#description)
  - [BACKGROUND](#background)
- [CLASSES](#classes)
- [AUTHOR](#author)
- [COPYRIGHT AND LICENSE](#copyright-and-license)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# NAME

clipasta - handle Ctrl-C and broken-pipe errors gracefully in command-line tools

# INSTALL

    gem "clipasta", github: "chocolateboy/clipasta"

# SYNOPSIS

```ruby
#!/usr/bin/ruby

require "clipasta"
require "optparse"

def process(line)
  # ...
end

OptionParser.new do |opts|
  # ...
end.parse!

ARGF.each do |line|
  puts process(line)
end
```

# DESCRIPTION

`clipasta` packages boilerplate code which is commonly copied 'n' pasted into Ruby CLI scripts to perform the following tasks:

* set up an `EPIPE` handler to handle broken pipes in the same way as other CLI tools
* set up a `SIGINT` handler to handle <kbd>Ctrl-C</kbd> in the same way as other CLI tools

These tasks are executed by loading the corresponding files, either separately e.g.:

```ruby
require "clipasta/epipe"
require "clipasta/sigint"
```

Or as a group e.g.:

```ruby
require "clipasta"
```

## BACKGROUND

By default, Ruby produces an ugly error message when scripts are interrupted by <kbd>Ctrl-C</kbd> (`SIGINT`) e.g.:

    $ timeout --signal INT 1 ruby -e sleep

Output:

    ^CTraceback (most recent call last):
            1: from -e:1:in `<main>'
    -e:1:in `sleep': Interrupt

The same is true if a process encounters an error when trying to write to a broken pipe (`EPIPE`) e.g.:

    $ ruby -e 'loop { puts "." }' | head -n0

Output:

    Traceback (most recent call last):
            5: from -e:1:in `<main>'
            4: from -e:1:in `loop'
            3: from -e:1:in `block in <main>'
            2: from -e:1:in `puts'
            1: from -e:1:in `puts'
    -e:1:in `write': Broken pipe @ io_writev - <STDOUT> (Errno::EPIPE)

The snippets provided by this gem install signal handlers which handle these errors in the same way as other CLI tools e.g.:

    $ timeout --signal INT 1 ruby -r clipasta -e sleep
    # No output

    $ ruby -r clipasta -e 'loop { puts "." }' | head -n0
    # No output

# CLASSES

None.

# AUTHOR

[chocolateboy](mailto:chocolate@cpan.org)

# COPYRIGHT AND LICENSE

Copyright chocolateboy, 2018.

This gem is free software. It is available under the terms of the Artistic License 2.0](http://www.opensource.org/licenses/artistic-license-2.0.php).
