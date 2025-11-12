// For each classroom, list all subjects taught there,
// along with the teacher and the timeSlot + hoursPerWeek info
MATCH (c:Classroom)<-[tp:TAKES_PLACE]-(sub:Subject)<-[tch:TEACHES]-(t:Teacher)
WITH c, COLLECT(
    sub.name_en + " (" + t.firstName + " " + t.lastName + ", time=" + tp.timeSlot + ", " + tch.hoursPerWeek + "h/week)" ) AS schedule
RETURN c.classroomName_en AS Classroom, c.capacity AS Capacity, schedule AS Sessions
ORDER BY Capacity DESC, Classroom;
