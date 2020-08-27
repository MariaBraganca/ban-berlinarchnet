class CommentPolicy < ApplicationPolicy
  #before_action :set_comment, only: [:show, :destroy]
  #skip_before_action :authenticate_user!, only: [ :index, :show]
  class Scope < Scope

    def resolve
      scope.all
    end
  end

    
    def create?
      return true
    end
    
    def new?
      create?
    end
    


  private

  def set_comment
    @comment = Coment.find(params[:id])
  end
end
