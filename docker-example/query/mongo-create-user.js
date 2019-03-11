db = db.getSiblingDB("admin");
db.auth("dbAdmin","dbAdmin");

db = db.getSiblingDB("test");
db.createUser(
   {
     user: "dbAdmin",
     pwd: "dbAdmin",
     roles: [ "readWrite", "dbAdmin" ]
   }
)
db.createCollection("game_events", { capped : true, size : 5242880, max : 5000 } );
