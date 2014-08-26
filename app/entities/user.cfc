component persistent = "true" table = "users" entityname = "users" {

	property(name="id" fieldtype="id" ormtype="integer" type="numeric" datatype="integer" generator="identity");
	
	property(name="username" ormtype="string" length="32");
	
	property(name="email" ormtype="string" length="128");

	property(name="password" ormtype="string" length="128");
}