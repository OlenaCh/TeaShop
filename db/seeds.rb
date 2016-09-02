# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

shipments = Shipment.create([{ title: 'Post', description: 'By post', price: 10.0 }, 
	                         { title: 'Taxi', description: 'By taxi', price: 20.0 },
	                         { title: 'Plane', description: 'By plane', price: 50.0}])

# admin = User.create([{ name: 'Admin', password: 'adminadmin', 
# 	                   email: 'olena.chernilevska@gmail.com', role: 'admin', confirmed_at: '2016-09-02 13:31:59.763341' }])