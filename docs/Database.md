========== Module 1: Authentication & Account ========== 
===Authentication
 POST /api/register
 POST /api/login
 POST /api/logout
 POST /api/forgot-password
===Account
 GET /api/users/profile
 PUT /api/users/update
 PUT /api/users/change-password


========== Module 2: Products ==========
===Product APIs
 GET /api/products
 GET /api/products/{id}
 GET /api/products/search
 GET /api/products/brand/{brandId}
 GET /api/products/category/{categoryId}
 GET /api/products/gender/{gender}
===Admin Product
 POST /api/admin/products
 PUT /api/admin/products/{id}
 DELETE /api/admin/products/{id}


========== Module 3: Cart ==========
===Cart APIs
 POST /api/cart/add
 GET /api/cart
 PUT /api/cart/update/{id}
 DELETE /api/cart/delete/{id}


========== Module 4: Orders ==========
===Order APIs
 POST /api/orders/checkout
 GET /api/orders/history
 GET /api/orders/{id}
 PUT /api/orders/cancel/{id}
===Admin Order
 GET /api/admin/orders
 PUT /api/admin/orders/status/{id}


========== Module 5: Payment ==========
===Payment APIs
 POST /api/payments/create
 GET /api/payments/vnpay-return
 GET /api/payments/status/{orderId}


========== Module 6: Reviews ==========
===Review APIs
 POST /api/reviews/add
 GET /api/reviews/product/{perfumeId}


========== Module 7: Admin ==========
User Management
 GET /api/admin/users
 PUT /api/admin/users/lock/{id}
Dashboard
 GET /api/admin/dashboard
 GET /api/admin/revenue