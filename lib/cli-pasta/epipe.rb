# frozen_string_literal: true

# avoid ugly stack-traces on EPIPE
Signal.trap('PIPE', 'SYSTEM_DEFAULT') if Signal.list.include?('PIPE')
