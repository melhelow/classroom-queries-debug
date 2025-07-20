class CoursesController < ApplicationController
  def index
    @courses = Course.all.order({ :created_at => :desc })

    render({ :template => "courses/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @course = Course.where({:id => the_id }).at(0)

    render({ :template => "courses/show" })
  end

  
  def create
  @course = Course.new
  @course.title = params.fetch("query_title")
  @course.term_offered = params.fetch("query_term_offered")  # Changed from query_term_
  @course.department_id = params.fetch("query_department_id")

  if @course.valid?
    @course.save
    redirect_to("/courses", { :notice => "Course created successfully." })
  else
    redirect_to("/courses", { :alert => "Course failed to create successfully." }) # Changed to alert
  end
end


def update
  the_id = params.fetch("path_id")
  @course = Course.find(the_id)  # More efficient lookup

  # Use consistent parameter names
  @course.title = params.fetch("query_title")
  @course.term_offered = params.fetch("query_term_offered")
  @course.department_id = params.fetch("query_department_id")

  if @course.save  # Combines validation and save
    redirect_to("/courses/#{@course.id}", notice: "Course updated successfully.")
  else
    redirect_to("/courses/#{@course.id}", alert: "Course failed to update: #{@course.errors.full_messages.join(', ')}")
  end
end

  def destroy
    the_id = params.fetch("path_id")  
  @course = Course.where({ :id => the_id }).at(0)

    @course.destroy

    redirect_to("/courses", { :notice => "Course deleted successfully."} )
  end
end
