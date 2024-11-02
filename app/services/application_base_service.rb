# frozen_string_literal: true

##
# inherit all services here
class ApplicationBaseService
  def self.call(*args, **kwargs)
    new(**kwargs).call
  end
end
