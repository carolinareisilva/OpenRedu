class Enrollment < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

   def self.create_enrollment subject_id, current_user

    if current_user.enrollments.detect{|e| e.subject_id == subject_id.to_i}.nil?
      current_user.enrollments.create(:subject_id => subject_id)
    end
    
  end
  
end
