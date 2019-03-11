
var replStatus = rs.status();

if(replStatus && replStatus.ok === 1){
	print(" ### Replication OK");
	printjson(replStatus);
} else {
	print(" ### Starting replication...");
	printjson(rs.initiate(rs_cluster));
    print(" ### Waiting 20 seconds for primary election...");
	sleep(20000);
	print(" ");
	print(" ### Replica Set status");
	printjson(rs.status());
}

replStatus = rs.status();
print(" ### Waiting for 5 seconds before user creating...");
sleep(5000);

if(replStatus && replStatus.ok === 1){
	
	db = db.getSiblingDB("admin");

	if(!db.auth("dbAdmin","dbAdmin")){
		print(" ### Creating DB Admin user...");

		var adminUser = db.createUser({ user: "dbAdmin", pwd: "dbAdmin", roles: [ { role: "userAdminAnyDatabase", db: "admin" }, {role:"root", db: "admin"} ] });

		var dbAdimOk = db.auth("dbAdmin","dbAdmin");

		print("DB Admin authentication after create: "+dbAdimOk);
	} else {
		print(" ### Logged with DB Admin user");
	}
} else {
	print(" ### Replication is not running:");
	printjson(replStatus);
}

var sleep = function (milliseconds) {
  var start = new Date().getTime();
  for (var i = 0; i < 1e7; i++) {
    if ((new Date().getTime() - start) > milliseconds){
      break;
    }
  }
};
