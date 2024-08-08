select EmployeeUNI.unique_id , Em.name from Employees as Em
left join EmployeeUNI on  EmployeeUNI.id= Em.id ;