class EnrollmentsController < ApplicationController
  def create
  @enrollment = Enrollment.new(
    course_id: params["query_course_id"],
    student_id: params["query_student_id"]
  )

  if @enrollment.save
    redirect_to "/students/#{params['query_student_id']}", notice: "Enrollment created successfully."
  else
    redirect_to "/students/#{params['query_student_id']}", alert: "Enrollment failed: #{@enrollment.errors.full_messages.join(', ')}"
  end
end
end
