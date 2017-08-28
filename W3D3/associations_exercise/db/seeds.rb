ActiveRecord::Base.transaction do
  User.destroy_all
  user1 = User.create(name: 'Tk', )
  user2 = User.create(name: 'Foppylau')
  user3 = User.create(name: 'Nyxon')
  user4 = User.create(name: 'RebekahLiu')
  user5 = User.create(name: 'Ikickyoass')

  Artwork.destroy_all
  artwork1 = Artwork.create(name: 'Ruby 101', instructor_id: user5.id)
  artwork2 = Course.create(name: 'Ruby 102', instructor_id: user5.id, prereq_id: course1.id)

  ArtworkShares.destroy_all
  Enrollment.create(student_id: user3.id, course_id: course1.id)
  Enrollment.create(student_id: user4.id, course_id: course1.id)
  Enrollment.create(student_id: user1.id, course_id: course2.id)
  Enrollment.create(student_id: user2.id, course_id: course2.id)
end
