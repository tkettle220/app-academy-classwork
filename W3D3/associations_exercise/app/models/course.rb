# == Schema Information
#
# Table name: courses
#
#  id            :integer          not null, primary key
#  name          :string
#  prereq_id     :integer
#  instructor_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Course < ApplicationRecord

  has_many :enrollments,
  primary_key: :id,
  foreign_key: :course_id,
  class_name: 'Enrollment'

  has_many :students,
    through: :enrollments,
    source: :user

  belongs_to :prerequisite,
    primary_key: :id,
    foreign_key: :prereq_id,
    class_name: 'Course'

  has_many :postrequisites,
    primary_key: :id,
    foreign_key: :prereq_id,
    class_name: 'Course'

  belongs_to :teacher,
  primary_key: :id,
  foreign_key: :instructor_id,
  class_name: 'User'
end
