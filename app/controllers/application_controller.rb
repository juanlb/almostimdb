class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    protected
    
    def set_fullpage
        @fullpage = true
    end
end
