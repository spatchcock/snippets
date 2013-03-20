ActiveAdmin.register Post do  

  # menu false
  # menu :label    => "A label"  
  # menu :label    => proc{ I18n.t("A label") }
  # menu :parent   => "Country" # Add as child of another menu item
  # menu :priority => 1 # order
  # menu :if       => proc{ current_admin_user.can_edit_posts? }

  # scope_to :current_user
  # scope_to :current_user, :association_method => :relation_or_scope

  ### Customize the Index view

  # config.batch_actions = false

  # batch_action :flag do |selection|
  #   Post.find(selection).each do |post|
  #     post.flag! :hot
  #   end
  # end

  # Requires selectable_column in index block
  # batch_action :destroy, :if => proc { can?( :destroy, Post ) } do |selection|
  #   redirect_to collection_path, :alert => "Didn't really delete these!"
  # end

  # scope :all, :default => true

  # scope :these do |selection|
  #   selection.where("these IS TRUE")
  # end

  index do  

    selectable_column

    column :name do |post|
      link_to post.name, admin_post_path(post)
    end

    column "Other", :the_other       
    column "That",  :that           

    default_actions                   
  end   

  ### Customize the Show view

  show :title => :name do

    panel "Map" do
      render 'map' # partial app/views/admin/
    end

    panel "Attributes" do
      attributes_table_for post do
        # row("Status") { status_tag (task.is_done ? "Done" : "Pending"), (task.is_done ? :ok : :error) }
        # row("Title") { task.title }
        # row("Project") { link_to task.project.title, admin_project_path(task.project) }
        # row("Assigned To") { link_to task.admin_user.email, admin_admin_user_path(task.admin_user) }
        # row("Due Date") { task.due_date? ? l(task.due_date, :format => :long) : '-' } 
      end
    end
  
    # active_admin_comments
  end         

  sidebar "Actions", :only => :show do
    table
  end             

  filter :name
  filter :date

  # Defining a custom action and page
  # See app/views/admin/posts/by_author.html.arb
  collection_action :by_author, :method => :get do
    @posts = Post.select("distinct author")
  end

  controller do

    # If using CanCan
    authorize_resource

    # Override scoped collection
    def scoped_collection
      # if...

      Post.where(...)
    end
    
  end

  # Html uses Arbre - Arbre is the DOM implemented in Ruby    
  # https://github.com/gregbell/arbre

  # Forms use Formtastic   
  # https://github.com/justinfrench/formtastic         

  # form do |f|                         
  #   f.inputs "User credentials" do       
  #     f.input :email                  
  #     f.input :password               
  #     f.input :password_confirmation  
  #   end                               
  #   f.actions                         
  # end 

  # form :partial => "form"

  # show :title => :title do
  #   panel "Tasks" do
  #     table_for project.tasks do |t|
  #       t.column("Status")      { |task| status_tag (task.is_done ? "Done" : "Pending"), (task.is_done ? :ok : :error) }
  #       t.column("Title")       { |task| link_to task.title, admin_task_path(task) }
  #       t.column("Assigned To") { |task| task.admin_user.email }
  #       t.column("Due Date")    { |task| task.due_date? ? l(task.due_date, :format => :long) : '-' }
  #     end
  #   end
  # end

  # show do
  #   panel "Task Details" do
  #     attributes_table_for task do
  #       row("Status") { status_tag (task.is_done ? "Done" : "Pending"), (task.is_done ? :ok : :error) }
  #       row("Title") { task.title }
  #       row("Project") { link_to task.project.title, admin_project_path(task.project) }
  #       row("Assigned To") { link_to task.admin_user.email, admin_admin_user_path(task.admin_user) }
  #       row("Due Date") { task.due_date? ? l(task.due_date, :format => :long) : '-' } 
  #     end
  #   end
   
  #   active_admin_comments
  # end

  # show :title => :name do
  #   # renders app/views/admin/posts/_some_partial.html.erb
  #   render "some_partial"
  # end

  # sidebar "Other Tasks For This User", :only => :show do
  #   table_for current_admin_user.tasks.where(:project_id => task.project) do |t|
  #     t.column("Status") { |task| status_tag (task.is_done ? "Done" : "Pending"), (task.is_done ? :ok : :error) }
  #     t.column("Title") { |task| link_to task.title, admin_task_path(task) }
  #   end
  # end

  # csv :separator => ';' do
  #   column :title
  #   column("Author") { |post| post.author.full_name }
  # end

  # sidebar :help, :only => :index do
  #   "Need help? Email us at help@example.com"
  # end

  # sidebar :help do
  #   ul do
  #     li "Second List First Item"
  #     li "Second List Second Item"
  #   end
  # end

  # sidebar :help, :if => proc{ current_admin_user.super_admin? }
  #   "Only for super admins!"
  # end

  # Will render app/views/admin/posts/_help_sidebar.html.erb
  # sidebar :help

  # sidebar :help, :partial => "custom_help_partial"

                               
end     
