**Stovba Vladislav 153505**
# Butcher shop

# Functional requirements
* Guest
  * Registration
  * Authorization
  * View published news and announcements
  * View shop staff
  * View information about the shop

</br>

* Authorized (customer)
  * All Guest functionality
  * View store products
  * View his own orders
  * Set reviews

    
</br>

* Staff (employee)
  * All Guest functionality
  * View his own place of work
  * View customer orders

</br>

* Administrator
  * Edit information about the shop
  * Edit customer and employee personal info
  * Create and edit products
  * Publish news and announcements
  * View employee and customer logs

</br>
</br>

# Entities
## user
1. `id INT` - PK
2. `first_name VARCHAR(45)` - user's first name
3. `last_name VARCHAR(45)` - user's last name
4. `username VARCHAR(30)` - user's username
5. `password VARCHAR(50)` - user's password
6. `email VARCHAR(255)` - user's email
7. `is_staff TINYINT(1)` - user's status option, assigned to user during registration
8. `is_superuser TINYINT(1)` - user's status option, assigned to user during registration

* OneToMany to "review"
* OneToMany to "journal"
* OneToOne to "customer"
* OneToOne to "employee"
  </br>
  </br>
  </br>

  
## customer
1. `id INT` - PK
* OneToOne to "user"
* OneToMany to "orders"
  </br>
  </br>
  </br>


## employee
1. `id INT` - PK
2. `experience INT` - years of work (ex. 12)
3. `age INT` - age of employee

* ManyToOne to "stores"
* OneToOne to "user"
  </br>
  </br>
  </br>

  
## stores
1. `id INT` - PK
2. `title VARCHAR(45)` - store title
3. `address TEXT` - address of shop
* OneToMany to "employee"
  </br>
  </br>
  </br>


## orders
1. `id INT` - PK
2. `date DATATIME` - when order was created
3. `status VARCHAR(30)` - status of order

* OneToMany to "orders_products"
* ManyToOne to "customer"
  </br>
  </br>
  </br>


## products
1. `id INT` - PK
2. `title VARCHAR(45)` - title of product
3. `amount INT` - count of products
4. `cost DECIMIAL(10,2)` - cost of product

* OneToMany to "orders_products"
* ManyToOne to "suppliers"
  </br>
  </br>
  </br>


## review
1. `id INT` - PK
2. `date DATE` - date when user left a review
3. `content TEXT` - information that user write in a review
4. `rate INT` -  rate that user left

* ManyToOne to "user"
  </br>
  </br>
  </br>


## suppliers
1. `id INT` - PK
2. `company_name VARCHAR(50)` - name of supplier
3. `email VARCHAR(255)` - contact email
4. `address VARCHAR(255)` - supplier address
5. `description VARCHAR(255)` - about company

* OneToMany to "products"
  </br>
  </br>
  </br>



## action_type
1. `id INT` - PK
2. `name VARCHAR(50)` - type of action that been logged

* OneToMany to "journal"
  </br>
  </br>
  </br>

## journal
1. `id INT` - PK
2. `date DATETIME` - time of any action

* ManyToOne to "action_type"
* ManyToOne to "user"
  </br>
  </br>
  </br>


## orders_products
1. `id INT` - PK

* ManyToOne to "orders"
* ManyToOne to "products"
  </br>
  </br>
  </br>



   



   
