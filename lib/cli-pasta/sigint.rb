# frozen_string_literal: true

# avoid ugly stack-traces on SIGINT
Signal.trap('INT', 'SYSTEM_DEFAULT') if Signal.list.include?('INT')
