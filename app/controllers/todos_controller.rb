class TodosController < ApplicationController
    before_action :require_user, only: [:show]
    before_action :require_admin, only: [:show_all]

    def create
        date = nil
        if params[ :dueDate ] != ""
            date = Date.strptime( params[ :dueDate ], "%m/%d/%Y" )
        else
            date = nil
        end
            

        @todo = Todo.new( {
            name: params[ :name ],
            course: params[ :course ],
            dueDate: date,
            estTime: params[ :estTime ],
            description: params[ :description ],
            priority: params[ :priority ],
            user_id_id: session[ :user_id_id ]
        })

        respond_to do |format|
            if @todo.save
                format.html {
                    render :partial => "todos/create", :locals => { :todo => @todo }, :layout => false
                }
                format.js {
                    render :partial => "todos/create", :locals => { :todo => @todo }, :layout => false
                }
            end
        end
    end

    def new
        @todo = Todo.new

        respond_to do |format|
            format.html { 
                render :partial => "todos/new", :locals => { :todo => @todo }, :layout => false 
            }
            format.js {
                render :partial => "todos/new", :locals => { :todo => @todo }, :layout => false 
            }
        end
    end

    def destroy

    end

    def index
        @todos = Todo.all
    end

    def show
        @todos = Todo.where( :user_id_id => session[ :user_id_id ] )
    end

    private

    def all_usr_todos
        @todos = Todo.where( :user_id_id => session[ :user_id_id ] )
    end
end
