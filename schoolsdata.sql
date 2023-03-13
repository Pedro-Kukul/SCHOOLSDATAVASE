-- DROP TABLES
DROP TABLE IF EXISTS ethnicity CASCADE;
DROP TABLE IF EXISTS districts CASCADE;
DROP TABLE IF EXISTS feederschools CASCADE;
DROP TABLE IF EXISTS status CASCADE;
DROP TABLE IF EXISTS students CASCADE;
DROP TABLE IF EXISTS grades CASCADE;
DROP TABLE IF EXISTS courses CASCADE;
DROP TABLE IF EXISTS enrolledsemester CASCADE;
DROP TABLE IF EXISTS students_courses;

-- ethnicity table
CREATE TABLE ethnicity(
    ethnicity_id int PRIMARY KEY,
    ethnicity text NOT NULL,
    created_at timestamp(0) with time zone DEFAULT NOW()
);
\COPY ethnicity(ethnicity_id, ethnicity) FROM 'ethnicity.csv' DELIMITER ',' CSV HEADER;

-- feederschools
CREATE TABLE feederschools(
    feederschool_id int PRIMARY KEY,
    feederschool text NOT NULL,
    district text NOT NULL,
    created_at timestamp(0) with time zone DEFAULT NOW()
);
\COPY feederschools(feederschool_id, feederschool, district) FROM 'feederschools.csv' DELIMITER ',' CSV HEADER;

-- district
CREATE TABLE districts(
    district_id int PRIMARY KEY,
    district text NOT NULL,
    created_at timestamp(0) with time zone DEFAULT NOW()
);
\COPY districts(district_id, district) FROM 'districts.csv' DELIMITER ',' CSV HEADER;

-- status
CREATE TABLE status(
    status_id serial PRIMARY KEY,
    status text NOT NULL,
    created_at timestamp(0) with time zone DEFAULT NOW()
);
\COPY status(status) FROM 'status.csv' DELIMITER ',' CSV HEADER;

-- students
CREATE TABLE students(
    student_id int PRIMARY KEY,
    gender char NOT NULL,
    ethnicity_id int REFERENCES ethnicity(ethnicity_id),
    district_id int REFERENCES districts(district_id),
    feederschool_id int REFERENCES feederschools(feederschool_id),
    status_id int REFERENCES status(status_id),
    programstart date NOT NULL,
    programend date NULL,
    graduationdate date NULL,
    created_at timestamp(0) with time zone DEFAULT NOW()
);
\COPY students(student_id, gender, ethnicity_id, district_id, feederschool_id, programstart, status_id, graduationdate, programend) FROM 'students.csv' DELIMITER ',' CSV HEADER;

-- grades
CREATE TABLE grades(
    grade_id serial PRIMARY KEY,
    grade text NOT NULL,
    created_at timestamp(0) with time zone DEFAULT NOW()
);
\COPY grades(grade) FROM 'grades.csv' DELIMITER ',' CSV HEADER;

-- courses
CREATE TABLE courses(
    course_id serial PRIMARY KEY,
    course_code text NOT NULL,
    course_name text NOT NULL,
    credits int NOT NULL,
    created_at timestamp(0) with time zone DEFAULT NOW()
);
\COPY courses(course_code, course_name, credits) FROM 'courses.csv' DELIMITER ',' CSV HEADER;

-- enrolledsemester
CREATE TABLE enrolledsemester(
    enrolledsemester_id serial PRIMARY KEY,
    enrolledsemester text NOT NULL,
    created_at timestamp(0) with time zone DEFAULT NOW()
);
\copy enrolledsemester(enrolledsemester) FROM 'enrolledsemester.csv' DELIMITER ',' CSV HEADER;

-- students_courses
CREATE TABLE students_courses(
    students_courses_id serial PRIMARY KEY,
    student_id int REFERENCES students(student_id),
    course_id int REFERENCES courses(course_id),
    grade_id int REFERENCES grades(grade_id),
    enrolledsemester_id int REFERENCES enrolledsemester(enrolledsemester_id),
    created_at timestamp(0) with time zone DEFAULT NOW()
);
\copy students_courses(student_id, course_id, grade_id, enrolledsemester_id) FROM 'students_courses.csv' DELIMITER ',' CSV HEADER;

