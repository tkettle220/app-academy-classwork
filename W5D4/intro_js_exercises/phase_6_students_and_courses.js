function Student(firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName;
  this.courses = [];
}

Student.prototype.name = function () {
  return `${this.firstName} ${this.lastName}`;
};

Student.prototype.enroll = function (course) {
  if(!this.courses.includes(course) && !this.hasConflict(course)) {
    this.courses.push(course);
    course.students.push(this);
  }
};

Student.prototype.courseLoad = function () {
  let hash = {};

  this.courses.forEach((course) => {
    const dept = `${course.department}`;
    if(hash[dept]) {
      hash[dept] += course.credits;
    } else {
      hash[dept] = course.credits;
    }
  });
  return hash;
};

Student.prototype.hasConflict = function (course) {
  return this.courses.some( (thisCourse) => {return thisCourse.conflictsWith(course);} );
};

function Course(name, department, credits, timeBlock, daysOfWeek) {
  this.name = name;
  this.department = department;
  this.credits = credits;
  this.students = [];
  this.timeBlock = timeBlock;
  this.daysOfWeek = daysOfWeek;
}

Course.prototype.addStudent = function (student) {
  student.enroll(this);
};

Course.prototype.conflictsWith = function (course) {
  let intersects = false;
  if(this.timeBlock !== course.timeBlock){
    return false;
  }

  this.daysOfWeek.forEach(
    (day) => { if(course.daysOfWeek.includes(day))
      {intersects = true;}
     }
  );

  return intersects;
};

const katrina = new Student("Katrina", "Lui");
const tommy = new Student("Thomas", "Kilmer");
const english = new Course("English 101", "English", 4, 3, ['mon']);
const english2 = new Course("English 102", "English", 4, 2, ['tues','thurs']);
const math = new Course("Algebra", "Math", 4, 3, ['mon']);
katrina.enroll(english);
katrina.enroll(english2);
// katrina.enroll(math);
