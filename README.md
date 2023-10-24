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
  * View customer orders and accept it

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
6. `email VARCHAR(150)` - user's email
7. `is_staff BOOLEAN` - user's status option, assigned to user during registration
8. `is_superuser BOOLEAN` - user's status option, assigned to user during registration

* OneToMany to "review"
* OneToMany to "journal"
* OneToMany to "article"
* OneToOne to "customer"
* OneToOne to "employee"
  </br>
  </br>
  </br>

  
## customer
1. `id INT` - PK
2. `user_id INT` - FK
* OneToOne to "user"
* OneToMany to "orders"
  </br>
  </br>
  </br>


## employee
1. `id INT` - PK
2. `experience INT` - years of work (ex. 12)
3. `age INT` - age of employee
4. `user_id INT` - FK
5. `stores_id INT` - FK

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
* OneToMany to "review_stores"
  </br>
  </br>
  </br>


## orders
1. `id INT` - PK
2. `date DATATIME` - when order was created
3. `status VARCHAR(30)` - status of order
4. `customer_id INT` - FK

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
5. `supplier_id INT` - FK

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
5. `user_id INT` - FK

* ManyToOne to "user"
* OneToMany to "review_stores"
  </br>
  </br>
  </br>


## suppliers
1. `id INT` - PK
2. `company_name VARCHAR(50)` - name of supplier
3. `email VARCHAR(150)` - contact email
4. `address VARCHAR(100)` - supplier address
5. `description VARCHAR(200)` - about company

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
3. `user_id INT` - FK
4. `action_type_id INT` - FK

* ManyToOne to "action_type"
* ManyToOne to "user"
  </br>
  </br>
  </br>


## orders_products
1. `id INT` - PK
2. `irders_id INT` - FK
3. `product_id INT` - FK

* ManyToOne to "orders"
* ManyToOne to "products"
  </br>
  </br>
  </br>

## article
1. `id INT` - PK
2. `title VARCHAR(255)` - title
3. `date DATE` - when published
4. `content TEXT` - content
5. `author_id INT` - FK

* ManyToOne to "user"
* OneToMany to "review_stores"
  </br>
  </br>
  </br>

## review_stores
1. `id INT` - PK
2. `review_id INT` - FK
3. `stores_id INT` - FK

* ManyToOne to "orders"
* ManyToOne to "products"
  </br>
  </br>
  </br>




   



   
