# Find unique subjects taught by teachers with more than one mobile number and a salary of at least 50000
[.specializations | .[] | .students | .[] | .subjects | .[] | select(.teachers | any(.[]; (.mobileNumber | length) > 1 and .salary >= 50000)) | .name.en] | unique | .[]
