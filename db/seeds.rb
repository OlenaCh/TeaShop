# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

shipments = Shipment.create([{ title: 'Post', description: 'By post', price: 10.0 }, 
	                         { title: 'Taxi', description: 'By taxi', price: 20.0 },
	                         { title: 'Plane', description: 'By plane', price: 50.0}])