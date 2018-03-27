# frozen_string_literal: true

# avoid ugly stack traces on EPIPE
if Signal.list.include?('PIPE')
  Signal.trap('PIPE', 'SYSTEM_DEFAULT')
end
