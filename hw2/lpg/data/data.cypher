// -----------------------------------------------------
// BUILDINGS
// -----------------------------------------------------
MERGE (b1:Building {
  id: "building1",
  buildingName_cs: "Malostranské náměstí",
  buildingName_en: "Malostranske Square",
  address: "Malostranské náměstí 25, 118 00 Praha 1"
});

MERGE (b2:Building {
  id: "building2",
  buildingName_cs: "Matematicko-fyzikální fakulta",
  buildingName_en: "Faculty of Mathematics and Physics",
  address: "Ke Karlovu 3, 121 16 Praha 2"
});

MERGE (b3:Building {
  id: "building3",
  buildingName_cs: "Studentská kolej",
  buildingName_en: "Student Dormitory",
  address: "Kolejní 1, 160 00 Praha 6"
});


// -----------------------------------------------------
// CLASSROOMS
// -----------------------------------------------------
MERGE (c1:Classroom {
  id: "classroom1",
  classroomName_en: "S1",
  classroomName_cs: "Posluchárna S1",
  capacity: 150
});

MERGE (c2:Classroom {
  id: "classroom2",
  classroomName_en: "S5",
  classroomName_cs: "Posluchárna S5",
  capacity: 80
});

MERGE (c3:Classroom {
  id: "classroom3",
  classroomName_en: "K11",
  classroomName_cs: "Učebna K11",
  capacity: 40
});

//  ===================== CLASSROOM -> BUILDING =====================
MATCH (c1:Classroom {id:"classroom1"}), (b1:Building {id:"building1"})
MERGE (c1)-[:IS_PART_OF]->(b1);

MATCH (c2:Classroom {id:"classroom2"}), (b1:Building {id:"building1"})
MERGE (c2)-[:IS_PART_OF]->(b1);

MATCH (c3:Classroom {id:"classroom3"}), (b2:Building {id:"building2"})
MERGE (c3)-[:IS_PART_OF]->(b2);


// -----------------------------------------------------
// SUBJECTS
// -----------------------------------------------------
MERGE (sub1:Subject {
  id: "subject1",
  name_cs: "Programování I",
  name_en: "Programming I",
  code: "NPRG030"
});

MERGE (sub2:Subject {
  id: "subject2",
  name_cs: "Databázové systémy",
  name_en: "Database Systems",
  code: "NDBI025"
});

MERGE (sub3:Subject {
  id: "subject3",
  name_cs: "Webové technologie",
  name_en: "Web Technologies",
  code: "NPRG036"
});

MERGE (sub4:Subject {
  id: "subject4",
  name_cs: "Lineární algebra",
  name_en: "Linear Algebra",
  code: "NMAI059"
});

// ===================== SUBJECT -> CLASSROOM =====================
// přidáváme edge property timeSlot jako ukázku, v RDF nebylo, ale LPG to umí

MATCH (s1:Subject {id:"subject1"}), (c1:Classroom {id:"classroom1"})
MERGE (s1)-[:TAKES_PLACE {timeSlot: "Mon 10:00"}]->(c1);

MATCH (s2:Subject {id:"subject2"}), (c2:Classroom {id:"classroom2"})
MERGE (s2)-[:TAKES_PLACE {timeSlot: "Tue 14:00"}]->(c2);

MATCH (s3:Subject {id:"subject3"}), (c1:Classroom {id:"classroom1"})
MERGE (s3)-[:TAKES_PLACE {timeSlot: "Wed 09:00"}]->(c1);

MATCH (s4:Subject {id:"subject4"}), (c3:Classroom {id:"classroom3"})
MERGE (s4)-[:TAKES_PLACE {timeSlot: "Thu 13:00"}]->(c3);


// -----------------------------------------------------
// TEACHERS
// -----------------------------------------------------
MERGE (t1:Teacher {
  id: "teacher1",
  firstName: "Pavel",
  lastName: "Veselý",
  mobileNumber: "tel:+420-123-456-789",
  salary: 45000
});

MERGE (t2:Teacher {
  id: "teacher2",
  firstName: "Marta",
  lastName: "Vomlelová",
  mobileNumber: ["tel:+420-234-567-890" , "tel:+420-333-444-555"],
  salary: 52000
});

MERGE (t3:Teacher {
  id: "teacher3",
  firstName: "Petr",
  lastName: "Dvořák",
  mobileNumber: "tel:+420-345-678-901",
  salary: 48000
});

// ===================== TEACHER -> BUILDING =====================
MATCH (t1:Teacher {id:"teacher1"}), (b2:Building {id:"building2"})
MERGE (t1)-[:RESIDES_IN]->(b2);

MATCH (t2:Teacher {id:"teacher2"}), (b1:Building {id:"building1"})
MERGE (t2)-[:RESIDES_IN]->(b1);

MATCH (t3:Teacher {id:"teacher3"}), (b2:Building {id:"building2"})
MERGE (t3)-[:RESIDES_IN]->(b2);

// ===================== TEACHER -> SUBJECT =====================
// přidáváme edge property hoursPerWeek jako ukázku, v RDF nebylo, ale LPG to umí

MATCH (t1:Teacher {id:"teacher1"}), (s1:Subject {id:"subject1"})
MERGE (t1)-[:TEACHES {hoursPerWeek: 4}]->(s1);

MATCH (t1:Teacher {id:"teacher1"}), (s3:Subject {id:"subject3"})
MERGE (t1)-[:TEACHES {hoursPerWeek: 3}]->(s3);

MATCH (t2:Teacher {id:"teacher2"}), (s2:Subject {id:"subject2"})
MERGE (t2)-[:TEACHES {hoursPerWeek: 4}]->(s2);

MATCH (t3:Teacher {id:"teacher3"}), (s4:Subject {id:"subject4"})
MERGE (t3)-[:TEACHES {hoursPerWeek: 2}]->(s4);


// -----------------------------------------------------
// STUDENTS
// -----------------------------------------------------
MERGE (s1:Student {
  id: "student1",
  firstName: "Anna",
  lastName: "Procházková",
  mobileNumber: "tel:+420-111-222-333"
});

MERGE (s2:Student {
  id: "student2",
  firstName: "Tomáš",
  lastName: "Král",
  mobileNumber: "tel:+420-222-333-444"
});

MERGE (s3:Student {
  id: "student3",
  firstName: "Lucie",
  lastName: "Malá"
});

MERGE (s4:Student {
  id: "student4",
  firstName: "Martin",
  lastName: "Černý",
  mobileNumber: "tel:+420-444-555-666"
});

MERGE (s5:Student {
  id: "student5",
  firstName: "Kateřina",
  lastName: "Horáková",
  mobileNumber: "tel:+420-555-666-777"
});

// ===================== STUDENT -> BUILDING =====================
MATCH (st1:Student {id:"student1"}), (b3:Building {id:"building3"})
MERGE (st1)-[:RESIDES_IN]->(b3);

MATCH (st2:Student {id:"student2"}), (b3:Building {id:"building3"})
MERGE (st2)-[:RESIDES_IN]->(b3);

MATCH (st3:Student {id:"student3"}), (b3:Building {id:"building3"})
MERGE (st3)-[:RESIDES_IN]->(b3);

MATCH (st4:Student {id:"student4"}), (b3:Building {id:"building3"})
MERGE (st4)-[:RESIDES_IN]->(b3);

MATCH (st5:Student {id:"student5"}), (b3:Building {id:"building3"})
MERGE (st5)-[:RESIDES_IN]->(b3);


// -----------------------------------------------------
// SPECIALIZATIONS
// -----------------------------------------------------
MERGE (sp1:Specialization {
  id: "spec1",
  title_cs: "Informatika",
  title_en: "Computer Science",
  numberOfStudents: 250
});

MERGE (sp2:Specialization {
  id: "spec2",
  title_cs: "Matematika",
  title_en: "Mathematics",
  numberOfStudents: 180
});

MERGE (sp3:Specialization {
  id: "spec3",
  title_cs: "Fyzika",
  title_en: "Physics",
  numberOfStudents: 120
});

// ===================== STUDENT -> SPECIALIZATION =====================
MATCH (st1:Student {id:"student1"}), (sp1:Specialization {id:"spec1"})
MERGE (st1)-[:STUDIES]->(sp1);

MATCH (st2:Student {id:"student2"}), (sp1:Specialization {id:"spec1"})
MERGE (st2)-[:STUDIES]->(sp1);

MATCH (st3:Student {id:"student3"}), (sp2:Specialization {id:"spec2"})
MERGE (st3)-[:STUDIES]->(sp2);

MATCH (st4:Student {id:"student4"}), (sp3:Specialization {id:"spec3"})
MERGE (st4)-[:STUDIES]->(sp3);

MATCH (st5:Student {id:"student5"}), (sp1:Specialization {id:"spec1"})
MERGE (st5)-[:STUDIES]->(sp1);

// ===================== STUDENT -> SUBJECT =====================
// přidáváme edge property grade jako ukázku, v RDF nebylo, ale LPG to umí

MATCH (st1:Student {id:"student1"}), (s1:Subject {id:"subject1"})
MERGE (st1)-[:ATTENDS {grade: "A"}]->(s1);

MATCH (st1:Student {id:"student1"}), (s2:Subject {id:"subject2"})
MERGE (st1)-[:ATTENDS {grade: "B"}]->(s2);

MATCH (st1:Student {id:"student1"}), (s3:Subject {id:"subject3"})
MERGE (st1)-[:ATTENDS {grade: "A"}]->(s3);

MATCH (st2:Student {id:"student2"}), (s1:Subject {id:"subject1"})
MERGE (st2)-[:ATTENDS {grade: "A"}]->(s1);

MATCH (st2:Student {id:"student2"}), (s3:Subject {id:"subject3"})
MERGE (st2)-[:ATTENDS {grade: "A"}]->(s3);

MATCH (st3:Student {id:"student3"}), (s4:Subject {id:"subject4"})
MERGE (st3)-[:ATTENDS {grade: "B"}]->(s4);

MATCH (st4:Student {id:"student4"}), (s1:Subject {id:"subject1"})
MERGE (st4)-[:ATTENDS {grade: "C"}]->(s1);

MATCH (st4:Student {id:"student4"}), (s4:Subject {id:"subject4"})
MERGE (st4)-[:ATTENDS {grade: "B"}]->(s4);

MATCH (st5:Student {id:"student5"}), (s2:Subject {id:"subject2"})
MERGE (st5)-[:ATTENDS {grade: "A"}]->(s2);

MATCH (st5:Student {id:"student5"}), (s3:Subject {id:"subject3"})
MERGE (st5)-[:ATTENDS {grade: "A"}]->(s3);
