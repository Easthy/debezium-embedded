use test; 

db.createUser( { user: "adm", pwd: "123", roles: [ { role: "userAdminAnyDatabase", db: "admin" } ] } ); 

db.createCollection("producers", { capped : true, size : 5242880, max : 5000 } ); 
