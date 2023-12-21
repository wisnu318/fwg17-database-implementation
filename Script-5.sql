CREATE TYPE "roles" AS ENUM ('admin', 'staff', 'customer');
CREATE TABLE "users" (
	"id" SERIAL PRIMARY KEY,
	"fullName" VARCHAR(100) NOT NULL,
	"email" VARCHAR(100) NOT NULL UNIQUE,
	"password" VARCHAR(100) NOT NULL UNIQUE,
	"address" TEXT,
	"picture" VARCHAR(255),
	"phoneNumber" VARCHAR(15),
	"role" "roles" DEFAULT 'customer',
	"created_At" TIMESTAMP DEFAULT now(),
	"updated_At" TIMESTAMP
);

CREATE TABLE "products"(
	"id" SERIAL PRIMARY KEY,
	"name" VARCHAR(100) NOT NULL,
	"description" TEXT,
	"basePrice" INT NOT NULL,
	"image"VARCHAR(255),
	"discount" NUMERIC(3,2),
	"isRecommended" BOOLEAN,
    "stock" INT,
	"created_At" TIMESTAMP DEFAULT now(),
	"updated_At" TIMESTAMP
);

CREATE TYPE "itemSize" AS ENUM ('Small', 'Medium', 'Large');
CREATE TABLE "productSize" (
	"id" SERIAL PRIMARY KEY,
	"size" "itemSize",
	"aditionalPrice" INT NOT NULL,
	"created_At" TIMESTAMP DEFAULT now(),
	"updated_At" TIMESTAMP
);
CREATE TYPE "itemVariant" AS ENUM ('Ice', 'Hot');
CREATE TABLE "productVariant"(
	"id" SERIAL PRIMARY KEY,
	"name" "itemVariant" ,
	"adittionalPrice" INT NOT NULL,
	"created_At" TIMESTAMP DEFAULT now(),
	"updated_At" TIMESTAMP
);
CREATE TABLE "tags"(
	"id" SERIAL PRIMARY KEY,
	"name" VARCHAR(100) NOT NULL,
	"created_At" TIMESTAMP DEFAULT now(),
	"updated_At" TIMESTAMP
);
CREATE TABLE "productTags" (
	"id" SERIAL PRIMARY KEY,
	"productId" INT REFERENCES "products"("id"),
	"tagId" INT REFERENCES "tags"("id"),
	"created_At" TIMESTAMP DEFAULT now(),
	"updated_At" TIMESTAMP
);
CREATE TABLE "productRatings" (
	"id" SERIAL PRIMARY KEY,
	"productId" INT REFERENCES "products"("id"),
	"rate" INT NOT NULL,
	"reviewMessage" TEXT,
	"userId" INT REFERENCES "users"("id"),
	"created_At" TIMESTAMP DEFAULT now(),
	"updated_At" TIMESTAMP
);
CREATE TABLE "categories"(
	"id" SERIAL PRIMARY KEY,
	"name" VARCHAR(100) NOT NULL,
	"created_At" TIMESTAMP DEFAULT now(),
	"updated_At" TIMESTAMP
);
CREATE TABLE "productCategories"(
	"id" SERIAL PRIMARY KEY,
	"productId" INT REFERENCES "products"("id"),
	"categoryId" INT REFERENCES "categories"("id"),
	"created_At" TIMESTAMP DEFAULT now(),
	"updated_At" TIMESTAMP
);
CREATE TABLE "promo"(
	"id" SERIAL PRIMARY KEY,
	"name" VARCHAR(100) NOT NULL,
	"code" VARCHAR(100) NOT NULL,
	"description" TEXT,
	"percentage" NUMERIC(3,2) NOT NULL,
	"expiredAt" TIMESTAMP NOT NULL,
	"maximumPromo" INT,
	"minimumAmount" INT,
	"created_At" TIMESTAMP DEFAULT now(),
	"updated_At" TIMESTAMP
);
CREATE TYPE "orderStatus" AS ENUM ('ON-PROCCESS', 'DELIVERED', 'CANCELED','READY-TO-PICK');
CREATE TABLE "orders" (
	"id" SERIAL PRIMARY KEY,
	"userId" INT REFERENCES "users"("id"),
	"orderNumber" VARCHAR(100) NOT NULL,
	"promoId" INT REFERENCES "promo"("id"),
	"total" INT,
	"taxAmount" INT,
	"status" "orderStatus",
	"deliveryAddress" TEXT,
	"fullName" VARCHAR(100) NOT NULL,
	"email" VARCHAR(100) NOT NULL,
	"created_At" TIMESTAMP DEFAULT now(),
	"updated_At" TIMESTAMP
);

SELECT * FROM "orders"

CREATE TABLE "orderDetails"(
	"id" SERIAL PRIMARY KEY,
	"productId" INT REFERENCES "products"("id"),
	"productSizeId" INT REFERENCES "productSize"("id"),
	"productVariantId" INT REFERENCES "productVariant"("id"),
	"quantity" INT,
	"orderId" INT REFERENCES "orders"("id"),
    "subTotal"INT,
	"created_At" TIMESTAMP DEFAULT now(),
	"updated_At" TIMESTAMP
);
CREATE TABLE "message"(
	"id" SERIAL PRIMARY KEY,
	"recipientId" INT REFERENCES "users"("id"),
	"senderId" INT REFERENCES "users"("id"),
	"text" TEXT,
	"created_At" TIMESTAMP DEFAULT now(),
	"updated_At" TIMESTAMP
);


INSERT INTO "users"("fullName","email","password","address","picture","phoneNumber","role")
values
	('Lala Rizky','lalarizky@gmail.com','lala456','Jl. Flamboyan No. 23, Bukit Kecil, Palembang',NULL,'+6291789012345','customer'),
	('Maman Hermawan','mamanhermawan@yahoo.com','maman789','Jl. Teratai No. 45, Bukit Kecil, Palembang',NULL,'+6291890123456','admin'),
	('Nana Sari','nanasari@hotmail.com','nana012','Jl. Mawar No. 67, Bukit Kecil, Palembang',NULL,'+6291901234567','staff'),
	('Oki Prasetyo','okiprasetyo@outlook.com','oki345','Jl. Kenanga No. 89, Bukit Kecil, Palembang',NULL,'+6292012345678','customer'),
	('Pina Wulandari','pinawulandari@gmail.com','pina678','Jl. Cempaka No. 12, Bukit Kecil, Palembang',NULL,'+6292123456789','staff'),
	('Raka Satria','rakasatria@gmail.com','raka901','Jl. Kemuning No. 34, Bukit Kecil, Palembang',NULL,'+6292234567890','admin'),
	('Sinta Larasati','sintalarasati@yahoo.com','sinta234','Jl. Dahlia No. 56, Bukit Kecil, Palembang',NULL,'+6292345678901','staff'),
	('Tia Permata','tiapermata@hotmail.com','tia567','Jl. Teratai No. 78, Bukit Kecil, Palembang',NULL,'+6292456789012','customer'),
	('Ujang Pratama','ujangpratama@outlook.com','ujang890','Jl. Mawar No. 90, Bukit Kecil, Palembang',NULL,'+6292567890123','staff'),
	('Vivi Surya','vivisurya@gmail.com','vivi123','Jl. Kenanga No. 12, Bukit Kecil, Palembang',NULL,'+6292678901234','customer'),
	('Lala indri','lalaindri@gmail.com','lala789','Jl. Flamboyan No. 11, Bukit Kecil, Palembang',NULL,'+6291789015678','admin'),
	('Maman Hendrawan','mamanhendrawan@yahoo.com','maman123','Jl. Teratai No. 13, Bukit Kecil, Palembang',NULL,'+6291890123544','admin'),
	('Nana santi','nanasanti@hotmail.com','nana123','Jl. Mawar No. 15, Bukit Kecil, Palembang',NULL,'+6291901234123','staff'),
	('Oki Candra','okicandra@outlook.com','oki678','Jl. Kenanga No. 01, Bukit Kecil, Palembang',NULL,'+6292012345123','customer'),
	('Pina Cantika','pinacantika@gmail.com','pina123','Jl. Cempaka No. 02, Bukit Kecil, Palembang',NULL,'+6292123456123','staff'),
	('Raka Satrianta','rakasatrianta@gmail.com','raka213','Jl. Kemuning No. 13, Bukit Kecil, Palembang',NULL,'+6292234567123','admin'),
	('Sinta Larasanti','sintalarasanti@yahoo.com','sinta123','Jl. Dahlia No. 12, Bukit Kecil, Palembang',NULL,'+6292345678123','staff'),
	('Tia Permata Sari','tiapermata01@hotmail.com','tia123','Jl. Teratai No. 12, Bukit Kecil, Palembang',NULL,'+6292456789123','customer'),
	('Ujang Pramata','ujangpramata@outlook.com','ujang123','Jl. Mawar No. 11, Bukit Kecil, Palembang',NULL,'+6292567890123','staff'),
	('Vivi Suryaningsih','vivisuryaningsih@gmail.com','vivi456','Jl. Kenanga No. 67, Bukit Kecil, Palembang',NULL,'+6292678901567','customer');
	
SELECT COUNT("id") FROM "users";

INSERT INTO "products" ("name","description","basePrice","image","discount","isRecommended","stock")
VALUES
    ('Espresso', 'Kopi hitam klasik dengan rasa pekat', 10000, NULL, NULL, NULL, NULL),
    ('Latte', 'Espresso dengan susu steamed dan sedikit buih', 10000, NULL, NULL, NULL, NULL),
    ('Cappuccino', 'Espresso dengan sejumlah sama susu dan foam susu', 10000, NULL, NULL, NULL, NULL),
    ('Americano', 'Espresso dengan lebih banyak air', 10000, NULL, NULL, NULL, NULL),
    ('Mocha', 'Espresso dengan campuran susu dan cokelat', 10000, NULL, NULL, NULL, NULL),
    ('Macchiato', 'Espresso dengan sejumlah kecil susu', 10000, NULL, NULL, NULL, NULL),
    ('Flat White', 'Espresso dengan susu steamed dan foam yang halus', 10000, NULL, NULL, NULL, NULL),
    ('Affogato', 'Espresso disiramkan ke atas es krim vanilla', 10000, NULL, NULL, NULL, NULL),
    ('Cold Brew', 'Kopi diseduh dengan air dingin selama beberapa jam', 10000, NULL, NULL, NULL, NULL),
    ('Irish Coffee', 'KOPI dengan campuran whiskey dan krim', 10000, NULL, NULL, NULL, NULL),
    ('Avocado Toast', 'Roti gandum panggang dengan alpukat matang di atasnya', 15000, NULL, NULL, NULL, NULL),
    ('Caprese Sandwich', 'Roti dengan tomat, mozzarella, dan daun basil', 15000, NULL, NULL, NULL, NULL),
    ('Quinoa Salad', 'Salad segar dengan quinoa, sayuran, dan dressing balsamic', 15000, NULL, NULL, NULL, NULL),
    ('Chicken Caesar Wrap', 'Wrap dengan potongan ayam panggang, selada romaine, dan dressing caesar', 15000, NULL, NULL, NULL, NULL),
    ('Vegetarian Panini', 'MAKANAN dengan sayuran panggang dan keju', 15000, NULL, NULL, NULL, NULL),
    ('Classic Lemonade', 'Lemonade segar dengan es', 10000, NULL, NULL, NULL, NULL),
    ('Iced Tea', 'Teh hitam atau hijau disajikan dengan es', 10000, NULL, NULL, NULL, NULL),
    ('Orange Mango Smoothie', 'Smoothie dengan campuran jeruk dan mangga', 10000, NULL, NULL, NULL, NULL),
    ('Sparkling Raspberry Lemonade', 'Lemonade bersoda dengan rasa raspberry', 10000, NULL, NULL, NULL, NULL),
    ('Minty Fresh Limeade', 'Limeade dengan aroma mint yang menyegarkan', 10000, NULL, NULL, NULL, NULL),
    ('Pineapple Coconut Cooler', 'Minuman dingin dengan campuran nanas dan kelapa', 10000, NULL, NULL, NULL, NULL),
    ('Berry Burst Frappuccino', 'Minuman dingin berbasis susu dengan campuran buah berry', 10000, NULL, NULL, NULL, NULL),
    ('Cucumber Mint Refresher', 'Minuman segar dengan campuran mentimun dan mint', 10000, NULL, NULL, NULL, NULL),
    ('Watermelon Lemon Splash', 'Minuman lemonade dengan campuran semangka', 10000, NULL, NULL,NULL, NULL),
    ('Blueberry Lavender Fizz', 'Minuman berkarbonasi dengan campuran blueberry dan lavender', 10000, NULL, NULL, NULL, NULL);

INSERT INTO "productSize" ("size", "aditionalPrice")
VALUES
    ('Small', 3000),
    ('Medium', 5000),
    ('Large', 8000);


INSERT INTO "productVariant" ("name", "adittionalPrice")
VALUES
    ('Ice', 4000),
    ('Hot', 2000);

INSERT INTO "tags"("name")
VALUES
    ('Buy 1 get 1'),
    ('Flash sale'),
    ('Birthday Package'),
    ('Cheap');


UPDATE "tags" SET "name" = 'motherday', "created_At" = now() WHERE "id" = 4

INSERT INTO "productTags" ("productId","tagId")
VALUES
    (1,2),
    (2,2),
    (3,2),
    (4,2),
    (5,2),
    (6,2),
    (7,2),
    (8,2),
    (9,2),
    (10,2),
    (11,2),
    (12,2),
    (13,2),
    (14,2),
    (15,2),
    (16,2),
    (17,2),
    (18,2),
    (19,2),
    (20,2),
    (21,2),
    (22,2),
    (23,2),
    (24,2),
    (25,2);

SELECT * FROM "productCategories"

INSERT INTO "categories" ("name")
VALUES
    ('coffee'),
    ('food'),
    ('nonCoffe');

INSERT INTO "productCategories" ("productId","categoryId")
VALUES
    (1,1),
    (2,1),
    (3,1),
    (4,1),
    (5,1),
    (6,1),
    (7,1),
    (8,1),
    (9,1),
    (10,1),
    (11,2),
    (12,2),
    (13,2),
    (14,2),
    (15,2),
    (16,3),
    (17,3),
    (18,3),
    (19,3),
    (20,3),
    (21,3),
    (22,3),
    (23,3),
    (24,3),
    (25,3);

INSERT INTO "productRatings" ("productId", "rate", "reviewMessage", "userId")
VALUES
(1,5,'good',2),
(2,4,'perfect',3);

SELECT * FROM "productRatings"

/*example ambil name product, price dan category name dari id categories*/
select "p"."name","basePrice", "c"."name"
from "products" "p"
join "productCategories" "pc" on "p"."id"="pc"."productId" 
join "categories" "c" on "pc"."categoryId" = "c"."id" 
where "c"."id" in ('2');

INSERT INTO "promo" ("name","code","description","percentage","expiredAt","maximumPromo","minimumAmount")
VALUES
('Fazz Food 11-11', 'FAZZFOOD50', NULL, 0.5, now() + INTERVAL '1 day', 50000, 20000),
('Ditraktir 11-11', 'DITRAKTIR60', NULL, 0.6, now() + INTERVAL '1 day', 35000, 10000);

INSERT INTO "orders"("userId", "orderNumber", "promoId", "total", "taxAmount", "status", "deliveryAddress", "fullName", "email")
VALUES (3, '#001-10112023-0001', NULL, 15000, 0, 'ON-PROCCESS', 'Jl. Mawar No. 67, Bukit Kecil, Palembang', 'Nana Sari', 'nanasari@hotmail.com');

INSERT INTO "orderDetails" ("productId", "productSizeId", "productVariantId", "quantity", "orderId", "subTotal")
VALUES
(1, 1, 2, 1, 1, 15000);

SELECT "p"."name","c"."name", "ps"."size", "pv"."name", "o"."orderNumber", "od"."subTotal" FROM "products" "p"
JOIN "productCategories" "pc" ON "pc"."productId" = "p"."id"
JOIN "categories" "c" ON "c"."id" = "pc"."categoryId"
JOIN "orderDetails" "od" ON "p"."id" = "od"."productId"
JOIN "productSize" "ps" ON "od"."productSizeId" = "ps"."id"
JOIN "productVariant" "pv" ON "od"."productVariantId" = "pv"."id"
JOIN "orders" "o" ON "od"."orderId" = "o"."id";

-- Tugas
-- 1
INSERT INTO "orders"("userId", "orderNumber", "promoId", "total", "taxAmount", "status", "deliveryAddress", "fullName", "email")
VALUES
(1, '#001-10112023-0002', NULL, 
(SELECT "basePrice" FROM "products" WHERE "id" = 1) + 
(SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + 
(SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2), 0, 
'ON-PROCCESS', 'Jl. Flamboyan No. 23, Bukit Kecil, Palembang', 'Lala Rizky', 'lalarizky@gmail.com');

INSERT INTO "orderDetails" ("productId", "productSizeId", "productVariantId", "quantity", "orderId", "subTotal")
VALUES
(1, 1, 2, 1, 2, (SELECT "basePrice" FROM "products" WHERE "id" = 1) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2));
SELECT * FROM "orderDetails";
-- 2
INSERT INTO "orders"("userId", "orderNumber", "promoId", "total", "taxAmount", "status", "deliveryAddress", "fullName", "email")
VALUES
(2, '#001-10112023-0003', NULL, ((SELECT "basePrice" FROM "products" WHERE "id" = 1) + 
    (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + 
    (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2)), 0, 
    'DELIVERED', 'Jl. Teratai No. 45, Bukit Kecil, Palembang', 'Maman Hermawan','mamanhermawan@yahoo.com'),
(2, '#001-10112023-0004', NULL, ((SELECT "basePrice" FROM "products" WHERE "id" = 21) + 
    (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + 
    (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1)), 0, 
    'DELIVERED', 'Jl. Teratai No. 45, Bukit Kecil, Palembang', 'Maman Hermawan','mamanhermawan@yahoo.com'),
(2, '#001-10112023-0005', NULL, ((SELECT "basePrice" FROM "products" WHERE "id" = 11)) , 0, 
    'DELIVERED', 'Jl. Teratai No. 45, Bukit Kecil, Palembang', 'Maman Hermawan','mamanhermawan@yahoo.com');
SELECT * FROM "orders";
INSERT INTO "orderDetails" ("productId", "productSizeId", "productVariantId", "quantity", "orderId", "subTotal")
VALUES
(1, 1, 2, 1, 3, ((SELECT "basePrice" FROM "products" WHERE "id" = 1) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2))),
(21, 1, 1, 1, 4, ((SELECT "basePrice" FROM "products" WHERE "id" = 21) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1))),
(11, 1, 2, 1, 5, ((SELECT "basePrice" FROM "products" WHERE "id" = 11)));
SELECT * FROM "orderDetails";
-- 3
INSERT INTO "orders"("userId", "orderNumber", "promoId", "total", "taxAmount", "status", "deliveryAddress", "fullName", "email")
VALUES
(4, '#001-10112023-0006', NULL, 
((SELECT "basePrice" FROM "products" WHERE "id" = 1) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2)) + 
((SELECT "basePrice" FROM "products" WHERE "id" = 2) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 2) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2)) + 
((SELECT "basePrice" FROM "products" WHERE "id" = 21) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 3) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1)) + 
((SELECT "basePrice" FROM "products" WHERE "id" = 22) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1)) +
((SELECT "basePrice" FROM "products" WHERE "id" = 11)), 0, 'READY-TO-PICK', 'Jl. Kenanga No. 89, Bukit Kecil, Palembang', 'Oki Prasetyo','okiprasetyo@outlook.com'),
(4, '#001-10112023-0007', NULL, 
((SELECT "basePrice" FROM "products" WHERE "id" = 3) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2)) + 
((SELECT "basePrice" FROM "products" WHERE "id" = 4) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 2) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2)) + 
((SELECT "basePrice" FROM "products" WHERE "id" = 23) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 3) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1)) + 
((SELECT "basePrice" FROM "products" WHERE "id" = 24) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1)) +
((SELECT "basePrice" FROM "products" WHERE "id" = 12)), 0, 'READY-TO-PICK', 'Jl. Kenanga No. 89, Bukit Kecil, Palembang', 'Oki Prasetyo','okiprasetyo@outlook.com'),
(4, '#001-10112023-0008', NULL, 
((SELECT "basePrice" FROM "products" WHERE "id" = 5) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2)) + 
((SELECT "basePrice" FROM "products" WHERE "id" = 6) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 2) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2)) + 
((SELECT "basePrice" FROM "products" WHERE "id" = 25) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 3) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1)) + 
((SELECT "basePrice" FROM "products" WHERE "id" = 16) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1)) +
((SELECT "basePrice" FROM "products" WHERE "id" = 13)), 0, 'READY-TO-PICK', 'Jl. Kenanga No. 89, Bukit Kecil, Palembang', 'Oki Prasetyo','okiprasetyo@outlook.com'),
(4, '#001-10112023-0009', NULL, 
((SELECT "basePrice" FROM "products" WHERE "id" = 7) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2)) + 
((SELECT "basePrice" FROM "products" WHERE "id" = 8) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 2) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2)) + 
((SELECT "basePrice" FROM "products" WHERE "id" = 17) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 3) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1)) + 
((SELECT "basePrice" FROM "products" WHERE "id" = 18) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1)) +
((SELECT "basePrice" FROM "products" WHERE "id" = 14)), 0, 'READY-TO-PICK', 'Jl. Kenanga No. 89, Bukit Kecil, Palembang', 'Oki Prasetyo','okiprasetyo@outlook.com'),
(4, '#001-10112023-0010', NULL, 
((SELECT "basePrice" FROM "products" WHERE "id" = 9) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2)) + 
((SELECT "basePrice" FROM "products" WHERE "id" = 10) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 2) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2)) + 
((SELECT "basePrice" FROM "products" WHERE "id" = 19) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 3) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1)) + 
((SELECT "basePrice" FROM "products" WHERE "id" = 20) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1)) +
((SELECT "basePrice" FROM "products" WHERE "id" = 15)), 0, 'READY-TO-PICK', 'Jl. Kenanga No. 89, Bukit Kecil, Palembang', 'Oki Prasetyo','okiprasetyo@outlook.com');

SELECT * FROM "orders";
SELECT SUM("total") AS "totalUserId4" FROM "orders" WHERE "id" IN (6, 7, 8, 9, 10);
INSERT INTO "orderDetails" ("productId", "productSizeId", "productVariantId", "quantity", "orderId", "subTotal")
VALUES
(1, 1, 2, 1, 6, ((SELECT "basePrice" FROM "products" WHERE "id" = 1) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2))),
(2, 2, 2, 1, 6, ((SELECT "basePrice" FROM "products" WHERE "id" = 2) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 2) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2))),
(3, 1, 2, 1, 7, ((SELECT "basePrice" FROM "products" WHERE "id" = 3) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2))),
(4, 2, 2, 1, 7, ((SELECT "basePrice" FROM "products" WHERE "id" = 4) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 2) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2))),
(5, 1, 2, 1, 8, ((SELECT "basePrice" FROM "products" WHERE "id" = 5) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2))),
(6, 2, 2, 1, 8, ((SELECT "basePrice" FROM "products" WHERE "id" = 6) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 2) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2))),
(7, 1, 2, 1, 9, ((SELECT "basePrice" FROM "products" WHERE "id" = 7) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2))),
(8, 2, 2, 1, 9, ((SELECT "basePrice" FROM "products" WHERE "id" = 8) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 2) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2))),
(9, 1, 2, 1, 10, ((SELECT "basePrice" FROM "products" WHERE "id" = 9) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2))),
(10, 2, 2, 1, 10, ((SELECT "basePrice" FROM "products" WHERE "id" = 10) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 2) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2))),
(21, 3, 2, 1, 6, ((SELECT "basePrice" FROM "products" WHERE "id" = 21) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 3) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1))),
(22, 1, 2, 1, 6, ((SELECT "basePrice" FROM "products" WHERE "id" = 22) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1))),
(23, 3, 2, 1, 7, ((SELECT "basePrice" FROM "products" WHERE "id" = 23) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 3) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1))),
(24, 1, 2, 1, 7, ((SELECT "basePrice" FROM "products" WHERE "id" = 24) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1))),
(25, 3, 2, 1, 8, ((SELECT "basePrice" FROM "products" WHERE "id" = 25) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 3) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1))),
(16, 1, 2, 1, 8, ((SELECT "basePrice" FROM "products" WHERE "id" = 16) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1))),
(17, 3, 2, 1, 9, ((SELECT "basePrice" FROM "products" WHERE "id" = 17) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 3) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1))),
(18, 1, 2, 1, 9, ((SELECT "basePrice" FROM "products" WHERE "id" = 18) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1))),
(19, 3, 2, 1, 10, ((SELECT "basePrice" FROM "products" WHERE "id" = 19) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 3) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1))),
(20, 1, 2, 1, 10, ((SELECT "basePrice" FROM "products" WHERE "id" = 20) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1))),
(11, NULL, NULL, 1, 6, (SELECT "basePrice" FROM "products" WHERE "id" = 11)),
(12, NULL, NULL, 1, 7, (SELECT "basePrice" FROM "products" WHERE "id" = 12)),
(13, NULL, NULL, 1, 8, (SELECT "basePrice" FROM "products" WHERE "id" = 13)),
(14, NULL, NULL, 1, 9, (SELECT "basePrice" FROM "products" WHERE "id" = 14)),
(15, NULL, NULL, 1, 10, (SELECT "basePrice" FROM "products" WHERE "id" = 15));

INSERT INTO "message" ("recipientId","senderId","text")
VALUES
(1,2,'good servis');

SELECT * FROM "orderDetails";
SELECT SUM("subTotal") AS "totalHarusBayar"
FROM "orderDetails"
WHERE id BETWEEN 6 AND 35;