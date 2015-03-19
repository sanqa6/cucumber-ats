# Context between cucumber steps
module Ats
  class Context
    attr_accessor :site  # Which site is this sceanrio running on? recruit site? external candidate site? internal candidate site?
    attr_accessor :current_user  # Current user who is logged in current site

    def internal?
      site == :internal
    end

    def external?
      site == :external
    end

    def recruiter?
      site == :recruiter
    end

  end
end