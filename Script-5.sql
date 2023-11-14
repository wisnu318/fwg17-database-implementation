-- Active: 1699586113023@@127.0.0.1@5432@Coffee Shop@public
/*DEMO PEMBUATAN TABLE*/
CREATE TYPE "roles" AS ENUM ('admin', 'staff', 'customer');
CREATE TABLE "users" (
	"id" SERIAL PRIMARY KEY,
	"fullName" VARCHAR(100) NOT NULL,
	"email" VARCHAR(100) NOT NULL,
	"password" VARCHAR(100) NOT NULL,
	"address" TEXT,
	"picture" VARCHAR(255),
	"phoneNumber" VARCHAR(15) NOT NULL,
	"role" "roles",
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
	('Vivi Suryaningsih','vivisuryaningsih@gmail.com','vivi456','Jl. Kenanga No. 67, Bukit Kecil, Palembang',NULL,'+6292678901567','customer'),
	('Bima Satria','bimasatria@gmail.com','bima456','Jl. Flamboyan No. 23, Bukit Kecil, Palembang',NULL,'+6290789012345','customer'),
	('Cinta Larasati','cintalarasati@yahoo.com','cinta789','Jl. Teratai No. 45, Bukit Kecil, Palembang',NULL,'+6290890123456','admin'),
	('Dian Permata','dianpermata@hotmail.com','dian012','Jl. Mawar No. 67, Bukit Kecil, Palembang',NULL,'+6290901234567','staff'),
	('Eko Prasetyo','ekoprasetyo@outlook.com','eko345','Jl. Kenanga No. 89, Bukit Kecil, Palembang',NULL,'+6291012345678','customer'),
	('Fina Wulandari','finawulandari@gmail.com','fina678','Jl. Cempaka No. 12, Bukit Kecil, Palembang',NULL,'+6291123456789','staff'),
	('Vina Rizky','vinarizky@gmail.com','vina901','Jl. Dahlia No. 34, Bukit Kecil, Palembang',NULL,'+6290234567890','admin'),
	('Wawan Hermawan','wawanhermawan@yahoo.com','wawan234','Jl. Teratai No. 56, Bukit Kecil, Palembang',NULL,'+6290345678901','staff'),
	('Yuli Astuti','yuliastuti@hotmail.com','yuli567','Jl. Mawar No. 78, Bukit Kecil, Palembang',NULL,'+6290456789012','customer'),
	('Zaki Pratama','zakipratama@outlook.com','zaki890','Jl. Kenanga No. 90, Bukit Kecil, Palembang',NULL,'+6290567890123','staff'),
	('Aini Nurul','aininurul@gmail.com','aini123','Jl. Cempaka No. 12, Bukit Kecil, Palembang',NULL,'+6290678901234','customer'),
	('Puput Lestari','puputlestari@gmail.com','puput456','Jl. Mawar No. 23, Bukit Kecil, Palembang',NULL,'+6289789012345','customer'),
	('Rian Aditya','rianaditya@yahoo.com','rian789','Jl. Kenanga No. 45, Bukit Kecil, Palembang',NULL,'+6289890123456','admin'),
	('Sari Dewi','saridewi@hotmail.com','sari012','Jl. Cempaka No. 67, Bukit Kecil, Palembang',NULL,'+6289901234567','staff'),
	('Teguh Pratama','teguhpratama@outlook.com','teguh345','Jl. Flamboyan No. 89, Bukit Kecil, Palembang',NULL,'+6290012345678','customer'),
	('Umi Kalsum','umikalsum@gmail.com','umi678','Jl. Kemuning No. 12, Bukit Kecil, Palembang',NULL,'+6290123456789','staff'),
	('Kiki Ramadhan','kikiramadhan@gmail.com','kiki901','Jl. Cempaka No. 34, Bukit Kecil, Palembang',NULL,'+6289234567890','admin'),
	('Lina Wati','linawati@yahoo.com','lina234','Jl. Flamboyan No. 56, Bukit Kecil, Palembang',NULL,'+6289345678901','staff'),
	('Mira Fitri','mirafitri@hotmail.com','mira567','Jl. Kemuning No. 78, Bukit Kecil, Palembang',NULL,'+6289456789012','customer'),
	('Nando Putra','nandoputra@outlook.com','nando890','Jl. Dahlia No. 90, Bukit Kecil, Palembang',NULL,'+6289567890123','staff'),
	('Oka Surya','okasurya@gmail.com','oka123','Jl. Teratai No. 12, Bukit Kecil, Palembang',NULL,'+6289678901234','customer'),
	('Fajar Rizki','fajarrizki@gmail.com','fajar456','Jl. Durian No. 23, Bukit Kecil, Palembang',NULL,'+6286789012345','customer'),
	('Gita Sari','gitasari@yahoo.com','gita789','Jl. Melati No. 45, Bukit Kecil, Palembang',NULL,'+6287890123456','admin'),
	('Hadi Prasetyo','hadiprasetyo@hotmail.com','hadi012','Jl. Anggrek No. 67, Bukit Kecil, Palembang',NULL,'+6288901234567','staff'),
	('Indah Puspita','indahpuspita@outlook.com','indah345','Jl. Mawar No. 89, Bukit Kecil, Palembang',NULL,'+6289012345678','customer'),
	('Joko Widodo','jokowidodo@gmail.com','joko678','Jl. Kenanga No. 12, Bukit Kecil, Palembang',NULL,'+6289123456789','staff'),
	('Agus Setiawan','agussetiawan@gmail.com','agus123','Jl. Merdeka No. 12, Bukit Kecil, Palembang',NULL,'+6281234567890','admin'),
	('Budi Santoso','budisantoso@yahoo.com','budi456','Jl. Raya No. 34, Bukit Kecil, Palembang',NULL,'+6282345678901','staff'),
	('Cici Nurul','cicinurul@hotmail.com','cici789','Jl. Kebun No. 56, Bukit Kecil, Palembang',NULL,'+6283456789012','customer'),
	('Dedi Pratama','dedipratama@outlook.com','dedi012','Jl. Mangga No. 78, Bukit Kecil, Palembang',NULL,'+6284567890123','staff'),
	('Eka Putri','ekaputri@gmail.com','eka345','Jl. Nanas No. 90, Bukit Kecil, Palembang',NULL,'+6285678901234','customer'),
	('John Doe','john.doe@example.com','hashed_password_1','123 Main St, City',NULL,'+6281234567890','admin'),
	('Jane Smith','jane.smith@example.com','hashed_password_2','456 Oak St, Town',NULL,'+6289876543210','staff'),
	('Bob Johnson','bob.johnson@example.com','hashed_password_3','789 Pine St, Village',NULL,'+6281112223333','customer'),
	('Alice Lee','alice.lee@example.com','hashed_password_4','999 Elm St, Hamlet',NULL,'+6284445556666','customer'),
	('David Wang','david.wang@example.com','hashed_password_5','567 Birch St, Suburb',NULL,'+6285556667777','admin');
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
    ('Irish Coffee', 'Kopi dengan campuran whiskey dan krim', 10000, NULL, NULL, NULL, NULL),
    ('Pour Over', 'Metode penyeduhan kopi secara manual dengan air panas', 10000, NULL, NULL, NULL, NULL),
    ('Turkish Coffee', 'Kopi yang diseduh dengan bubuk kopi, air, dan gula', 10000, NULL, NULL, NULL, NULL),
    ('Vienna Coffee', 'Espresso dengan tambahan krim dan gula', 10000, NULL, NULL, NULL, NULL),
    ('Ristretto', 'Espresso dengan volume air yang lebih sedikit', 10000, NULL, NULL, NULL, NULL),
    ('Iced Caramel Macchiato', 'Espresso dengan susu dan sirup karamel di atas es', 10000, NULL, NULL, NULL, NULL),
    ('Nitro Cold Brew', 'Cold brew dengan nitrogen untuk kelembutan dan kebasaan', 10000, NULL, NULL, NULL, NULL),
    ('Maple Pecan Latte', 'Latte dengan campuran rasa maple dan kacang pecan', 10000, NULL, NULL, NULL, NULL),
    ('Cascara Fizz', 'Minuman ringan berkarbonasi dengan cascara (kulit buah kopi)', 10000, NULL, NULL, NULL, NULL),
    ('Honey Lavender Latte', 'Latte dengan campuran madu dan lavender', 10000, NULL, NULL, NULL, NULL),
    ('Cinnamon Dolce Latte', 'Latte dengan campuran cinnamon dan gula', 10000, NULL, NULL, NULL, NULL),
    ('Black and Tan', 'Campuran Cold Brew dan Nitro Cold Brew', 10000, NULL, NULL, NULL, NULL),
    ('Espresso Tonic', 'Espresso disajikan dengan tonik dan es', 10000, NULL, NULL, NULL, NULL),
    ('Coconut Cold Brew', 'Cold brew dengan tambahan susu kelapa', 10000, NULL, NULL, NULL, NULL),
    ('Chai Latte', 'Campuran teh chai dengan susu dan rempah-rempah', 10000, NULL, NULL, NULL, NULL),
    ('Hazelnut Mocha', 'Mocha dengan tambahan rasa hazelnut', 10000, NULL, NULL, NULL, NULL),
    ('Café au Lait', 'Setengah kopi, setengah susu panas', 10000, NULL, NULL, NULL, NULL),
    ('Iced Matcha Latte', 'Matcha dengan susu dan es', 10000, NULL, NULL, NULL, NULL),
    ('Espresso Affogato', 'Espresso disiramkan ke atas es krim vanilla', 10000, NULL, NULL,NULL, NULL),
    ('Pumpkin Spice Latte', 'Latte dengan campuran pumpkin spice', 10000, NULL, NULL, NULL, NULL),
    ('Irish Cream Cold Brew', 'KOPI Cold brew dengan campuran irish cream', 10000, NULL, NULL,NULL, NULL),
    ('Avocado Toast', 'Roti gandum panggang dengan alpukat matang di atasnya', 15000, NULL, NULL, NULL, NULL),
    ('Caprese Sandwich', 'Roti dengan tomat, mozzarella, dan daun basil', 15000, NULL, NULL, NULL, NULL),
    ('Quinoa Salad', 'Salad segar dengan quinoa, sayuran, dan dressing balsamic', 15000, NULL, NULL, NULL, NULL),
    ('Chicken Caesar Wrap', 'Wrap dengan potongan ayam panggang, selada romaine, dan dressing caesar', 15000, NULL, NULL, NULL, NULL),
    ('Vegetarian Panini', 'Panini dengan sayuran panggang dan keju', 15000, NULL, NULL, NULL, NULL),
    ('Smashed Chickpea Sandwich', 'Roti dengan pasta kececi yang diremas, selada, dan tomat', 15000, NULL, NULL, NULL, NULL),
    ('Bacon and Egg Croissant', 'Croissant dengan bacon dan telur dadar', 15000, NULL, NULL, NULL, NULL),
    ('Spinach and Feta Quiche', 'Quiche dengan bayam dan keju feta', 15000, NULL, NULL, NULL, NULL),
    ('Classic Bagel with Cream Cheese', 'Bagel klasik dengan krim keju', 15000, NULL, NULL, NULL, NULL),
    ('Blueberry Muffin', 'Muffin dengan blueberry di dalamnya', 15000, NULL, NULL, NULL, NULL),
    ('Salmon Bagel', 'Bagel dengan irisan salmon, krim keju, dan capers', 15000, NULL, NULL, NULL, NULL),
    ('Vegan Buddha Bowl', 'Bowl dengan campuran sayuran panggang, quinoa, dan hummus', 15000, NULL, NULL, NULL, NULL),
    ('Turkey and Swiss Sandwich', 'Roti dengan daging kalkun, keju Swiss, dan selada', 15000, NULL, NULL, NULL, NULL),
    ('Shrimp Tacos', 'Taco dengan udang panggang, salsa, dan saus krim', 15000, NULL, NULL, NULL, NULL),
    ('Pesto Chicken Panini', 'Panini dengan potongan ayam, saus pesto, dan keju', 15000, NULL, NULL, NULL, NULL),
    ('Mushroom Risotto', 'Risotto dengan jamur panggang dan parmesan', 15000, NULL, NULL, NULL, NULL),
    ('Crispy Cauliflower Bites', 'Gorengan kembang kol yang renyah', 15000, NULL, NULL, NULL, NULL),
    ('Tomato Basil Soup', 'Sup tomat dengan basil segar', 15000, NULL, NULL, NULL, NULL),
    ('Steak and Arugula Salad', 'Salad dengan irisan daging sapi panggang dan rucola', 15000, NULL, NULL, NULL, NULL),
    ('Choco-Banana Pancakes', 'MAKANAN Pancake dengan potongan pisang dan saus cokelat', 15000, NULL, NULL, NULL, NULL),
    ('Classic Lemonade', 'Lemonade segar dengan es', 10000, NULL, NULL, NULL, NULL),
    ('Iced Tea', 'Teh hitam atau hijau disajikan dengan es', 10000, NULL, NULL, NULL, NULL),
    ('Orange Mango Smoothie', 'Smoothie dengan campuran jeruk dan mangga', 10000, NULL, NULL, NULL, NULL),
    ('Sparkling Raspberry Lemonade', 'Lemonade bersoda dengan rasa raspberry', 10000, NULL, NULL, NULL, NULL),
    ('Minty Fresh Limeade', 'Limeade dengan aroma mint yang menyegarkan', 10000, NULL, NULL, NULL, NULL),
    ('Pineapple Coconut Cooler', 'Minuman dingin dengan campuran nanas dan kelapa', 10000, NULL, NULL, NULL, NULL),
    ('Berry Burst Frappuccino', 'Minuman dingin berbasis susu dengan campuran buah berry', 10000, NULL, NULL, NULL, NULL),
    ('Cucumber Mint Refresher', 'Minuman segar dengan campuran mentimun dan mint', 10000, NULL, NULL, NULL, NULL),
    ('Watermelon Lemon Splash', 'Minuman lemonade dengan campuran semangka', 10000, NULL, NULL,NULL, NULL),
    ('Blueberry Lavender Fizz', 'Minuman berkarbonasi dengan campuran blueberry dan lavender', 10000, NULL, NULL, NULL, NULL),
    ('Lemon Berry Splash', 'Minuman segar dengan campuran lemon dan beri', 10000, NULL, NULL,NULL, NULL),
    ('Passion Fruit Iced Tea', 'Teh hitam dengan campuran buah markisa dan es', 10000, NULL, NULL, NULL, NULL),
    ('Peachy Keen Smoothie', 'Smoothie dengan campuran buah persik dan yogurt', 10000, NULL, NULL, NULL, NULL),
    ('Green Apple Fizz', 'Minuman berkarbonasi dengan rasa apel hijau', 10000, NULL, NULL, NULL, NULL),
    ('Cherry Lime Rickey', 'Minuman dengan campuran ceri, lime, dan soda', 10000, NULL, NULL, NULL,NULL),
    ('Mango Tango Cooler', 'Minuman dingin dengan campuran mangga dan jeruk', 10000, NULL, NULL, NULL, NULL),
    ('Blackberry Basil Lemonade', 'Lemonade dengan campuran blackberry dan daun basil', 10000, NULL, NULL, NULL, NULL),
    ('Coconut Pineapple Refresher', 'Minuman segar dengan campuran kelapa dan nanas', 10000, NULL, NULL, NULL,NULL),
    ('Hibiscus Rose Punch', 'Minuman punch dengan campuran hibiscus dan rose', 10000, NULL, NULL, NULL, NULL),
    ('Cranberry Cucumber Sparkle', 'Minuman berkarbonasi dengan campuran cranberry dan mentimun', 10000, NULL, NULL, NULL, NULL),
    ('Tropical Mango Twist', 'Minuman dingin dengan campuran mangga dan buah tropis lainnya', 10000, NULL, NULL, NULL,NULL),
    ('Raspberry Lemon Spritz', 'Minuman berkarbonasi dengan campuran raspberry dan lemon', 10000, NULL, NULL, NULL,NULL),
    ('Ginger Peach Iced Tea', 'Teh dingin dengan campuran jahe dan buah persik', 10000, NULL, NULL, NULL, NULL),
    ('Blue Lagoon Smoothie', 'Smoothie dengan campuran blueberry dan yogurt', 10000, NULL, NULL, NULL, NULL),
    ('Watermelon Mint Refresher', 'Minuman segar dengan campuran semangka dan mint', 10000, NULL, NULL, NULL, NULL),
    ('Cranberry Orange Sparkle', 'Minuman berkarbonasi dengan campuran cranberry dan jeruk', 10000, NULL, NULL, NULL, NULL),
    ('Pineapple Basil Splash', 'Minuman dingin dengan campuran nanas dan daun basil', 10000, NULL, NULL, NULL, NULL),
    ('Citrus Punch Fizz', 'Minuman berkarbonasi dengan campuran berbagai buah citrus', 10000, NULL, NULL, NULL, 100),
    ('Berry Hibiscus Cooler', 'Minuman dingin dengan campuran beri dan bunga hibiscus', 10000, NULL, NULL, NULL, 50),
    ('Green Tea Mojito', 'Minuman dingin dengan campuran green tea, mint, dan lime', 10000, NULL, NULL, NULL, 100);
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
    (11,1),
    (12,1),
    (13,1),
    (14,1),
    (15,1),
    (16,1),
    (17,1),
    (18,1),
    (19,1),
    (20,1),
    (21,1),
    (22,1),
    (23,1),
    (24,1),
    (25,1),
    (26,1),
    (27,1),
    (28,1),
    (28,1),
    (30,1),
    (31,2),
    (32,2),
    (33,2),
    (34,2),
    (35,2),
    (36,2),
    (37,2),
    (38,2),
    (39,2),
    (40,2),
    (41,2),
    (42,2),
    (43,2),
    (44,2),
    (45,2),
    (46,2),
    (47,2),
    (48,2),
    (49,2),
    (50,2),
    (51,3),
    (52,3),
    (53,3),
    (54,3),
    (55,3),
    (56,3),
    (57,3),
    (58,3),
    (59,3),
    (60,3),
    (61,3),
    (62,3),
    (63,3),
    (64,3),
    (65,3),
    (66,3),
    (67,3),
    (68,3),
    (69,3),
    (70,3),
    (71,3),
    (72,3),
    (73,3),
    (74,3),
    (75,3),
    (76,3),
    (77,3),
    (78,3),
    (79,3),
    (80,3);

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
SELECT * FROM "orders";
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
(2, '#001-10112023-0004', NULL, ((SELECT "basePrice" FROM "products" WHERE "id" = 61) + 
    (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + 
    (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1)), 0, 
    'DELIVERED', 'Jl. Teratai No. 45, Bukit Kecil, Palembang', 'Maman Hermawan','mamanhermawan@yahoo.com'),
(2, '#001-10112023-0005', NULL, ((SELECT "basePrice" FROM "products" WHERE "id" = 31)) , 0, 
    'DELIVERED', 'Jl. Teratai No. 45, Bukit Kecil, Palembang', 'Maman Hermawan','mamanhermawan@yahoo.com');
SELECT * FROM "orders";
INSERT INTO "orderDetails" ("productId", "productSizeId", "productVariantId", "quantity", "orderId", "subTotal")
VALUES
(1, 1, 2, 1, 3, ((SELECT "basePrice" FROM "products" WHERE "id" = 1) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2))),
(61, 1, 1, 1, 4, ((SELECT "basePrice" FROM "products" WHERE "id" = 61) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1))),
(31, 1, 2, 1, 5, ((SELECT "basePrice" FROM "products" WHERE "id" = 31)));
SELECT * FROM "orderDetails";
-- 3
INSERT INTO "orders"("userId", "orderNumber", "promoId", "total", "taxAmount", "status", "deliveryAddress", "fullName", "email")
VALUES
(4, '#001-10112023-0006', NULL, 
((SELECT "basePrice" FROM "products" WHERE "id" = 1) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2)) + 
((SELECT "basePrice" FROM "products" WHERE "id" = 2) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 2) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2)) + 
((SELECT "basePrice" FROM "products" WHERE "id" = 61) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 3) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1)) + 
((SELECT "basePrice" FROM "products" WHERE "id" = 62) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1)) +
((SELECT "basePrice" FROM "products" WHERE "id" = 31)), 0, 'READY-TO-PICK', 'Jl. Kenanga No. 89, Bukit Kecil, Palembang', 'Oki Prasetyo','okiprasetyo@outlook.com'),
(4, '#001-10112023-0007', NULL, 
((SELECT "basePrice" FROM "products" WHERE "id" = 3) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2)) + 
((SELECT "basePrice" FROM "products" WHERE "id" = 4) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 2) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2)) + 
((SELECT "basePrice" FROM "products" WHERE "id" = 63) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 3) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1)) + 
((SELECT "basePrice" FROM "products" WHERE "id" = 64) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1)) +
((SELECT "basePrice" FROM "products" WHERE "id" = 32)), 0, 'READY-TO-PICK', 'Jl. Kenanga No. 89, Bukit Kecil, Palembang', 'Oki Prasetyo','okiprasetyo@outlook.com'),
(4, '#001-10112023-0008', NULL, 
((SELECT "basePrice" FROM "products" WHERE "id" = 5) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2)) + 
((SELECT "basePrice" FROM "products" WHERE "id" = 6) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 2) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2)) + 
((SELECT "basePrice" FROM "products" WHERE "id" = 65) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 3) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1)) + 
((SELECT "basePrice" FROM "products" WHERE "id" = 66) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1)) +
((SELECT "basePrice" FROM "products" WHERE "id" = 33)), 0, 'READY-TO-PICK', 'Jl. Kenanga No. 89, Bukit Kecil, Palembang', 'Oki Prasetyo','okiprasetyo@outlook.com'),
(4, '#001-10112023-0009', NULL, 
((SELECT "basePrice" FROM "products" WHERE "id" = 7) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2)) + 
((SELECT "basePrice" FROM "products" WHERE "id" = 8) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 2) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2)) + 
((SELECT "basePrice" FROM "products" WHERE "id" = 67) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 3) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1)) + 
((SELECT "basePrice" FROM "products" WHERE "id" = 68) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1)) +
((SELECT "basePrice" FROM "products" WHERE "id" = 34)), 0, 'READY-TO-PICK', 'Jl. Kenanga No. 89, Bukit Kecil, Palembang', 'Oki Prasetyo','okiprasetyo@outlook.com'),
(4, '#001-10112023-0010', NULL, 
((SELECT "basePrice" FROM "products" WHERE "id" = 9) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2)) + 
((SELECT "basePrice" FROM "products" WHERE "id" = 10) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 2) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 2)) + 
((SELECT "basePrice" FROM "products" WHERE "id" = 69) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 3) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1)) + 
((SELECT "basePrice" FROM "products" WHERE "id" = 70) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1)) +
((SELECT "basePrice" FROM "products" WHERE "id" = 35)), 0, 'READY-TO-PICK', 'Jl. Kenanga No. 89, Bukit Kecil, Palembang', 'Oki Prasetyo','okiprasetyo@outlook.com');

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
(61, 3, 2, 1, 6, ((SELECT "basePrice" FROM "products" WHERE "id" = 61) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 3) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1))),
(62, 1, 2, 1, 6, ((SELECT "basePrice" FROM "products" WHERE "id" = 62) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1))),
(63, 3, 2, 1, 7, ((SELECT "basePrice" FROM "products" WHERE "id" = 63) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 3) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1))),
(64, 1, 2, 1, 7, ((SELECT "basePrice" FROM "products" WHERE "id" = 64) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1))),
(65, 3, 2, 1, 8, ((SELECT "basePrice" FROM "products" WHERE "id" = 65) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 3) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1))),
(66, 1, 2, 1, 8, ((SELECT "basePrice" FROM "products" WHERE "id" = 66) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1))),
(67, 3, 2, 1, 9, ((SELECT "basePrice" FROM "products" WHERE "id" = 67) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 3) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1))),
(68, 1, 2, 1, 9, ((SELECT "basePrice" FROM "products" WHERE "id" = 68) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1))),
(69, 3, 2, 1, 10, ((SELECT "basePrice" FROM "products" WHERE "id" = 69) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 3) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1))),
(70, 1, 2, 1, 10, ((SELECT "basePrice" FROM "products" WHERE "id" = 70) + (SELECT "aditionalPrice" FROM "productSize" WHERE "id" = 1) + (SELECT "adittionalPrice" FROM "productVariant" WHERE "id" = 1))),
(31, NULL, NULL, 1, 6, (SELECT "basePrice" FROM "products" WHERE "id" = 31)),
(32, NULL, NULL, 1, 7, (SELECT "basePrice" FROM "products" WHERE "id" = 32)),
(33, NULL, NULL, 1, 8, (SELECT "basePrice" FROM "products" WHERE "id" = 33)),
(34, NULL, NULL, 1, 9, (SELECT "basePrice" FROM "products" WHERE "id" = 34)),
(35, NULL, NULL, 1, 10, (SELECT "basePrice" FROM "products" WHERE "id" = 35));

SELECT * FROM "orderDetails";
SELECT SUM("subTotal") AS "totalHarusBayar"
FROM "orderDetails"
WHERE id BETWEEN 6 AND 35;



/*demo join*/
select "p"."name","basePrice", "c"."name"
from "products" "p"
join "productCategories" "pc" on "p"."id"="pc"."productId" 
join "categories" "c" on "pc"."categoryId" = "c"."id" 
where "c"."id" in ('2');

SELECT "p"."name","c"."name", "ps"."size", "pv"."name", "o"."orderNumber", "od"."subTotal" 
FROM "products" "p"
JOIN "productCategories" "pc" ON "pc"."productId" = "p"."id"
JOIN "categories" "c" ON "c"."id" = "pc"."categoryId"
JOIN "orderDetails" "od" ON "p"."id" = "od"."productId"
JOIN "productSize" "ps" ON "od"."productSizeId" = "ps"."id"
JOIN "productVariant" "pv" ON "od"."productVariantId" = "pv"."id"
JOIN "orders" "o" ON "od"."orderId" = "o"."id";

/*DEMO CRUD*/
INSERT INTO "promo" ("name","code","description","percentage","expiredAt","maximumPromo","minimumAmount")
VALUES
('HARI MERDEKA', 'MERDEKA80', NULL, 0.8, now() + INTERVAL '1 day', 50000, 100000);

UPDATE "users" SET "fullName" = 'Eka Riana', "email" = 'ekariana@gmail.com' WHERE "id" = '50';

DELETE FROM "users" WHERE "id" IN ('51','52','53','54','55');

SELECT "u"."fullName","email" FROM "users" AS "u";
SELECT * FROM "users";

-- DEMO QUERY PRODUK BERDASARKAN NAMA
SELECT "p"."name" FROM "products" AS "p";
SELECT "p"."id","name" FROM "products" AS "p" WHERE "id" = '30';
SELECT "p"."name" FROM "products" AS "p" LIMIT '10';
SELECT "p"."id","name" "nameProducts" FROM "products" AS "p" LIMIT '10' OFFSET '30';
SELECT * FROM "products" WHERE "name" ILIKE '%er';
SELECT * FROM "products" WHERE "name" ILIKE '%er%';
SELECT * FROM "products" WHERE "name" ILIKE 'ma%';

-- DEMO QUERY PRODUK BERDASARKAN NAMA,KATEGORI, PROMO & HARGA
select* FROM"products";
SELECT "p"."name" "nameProducts", "basePrice", "c"."name" "nameCategories", "pr"."code" 
FROM "products" "p"
FULL JOIN "productCategories" "pc" ON "pc"."productId" = "p"."id"
FULL JOIN "categories" "c" ON "pc"."categoryId" = "c"."id"
FULL JOIN "orderDetails" "od" ON "p"."id" = "od"."productId"
FULL JOIN "orders" "o" ON "od"."orderId" = "o"."id"
FULL JOIN "promo" "pr" ON "pr"."id" = "o"."promoId";

/*PAGINATION (endapatkan sejumlah tertentu baris dari hasil kueri, dimulai dari posisi tertentu)*/
SELECT "p"."id","name" "nameProducts" FROM "products" AS "p" LIMIT '10' OFFSET '30';

/*DEMO TRANSAKSI*/
-- 1
START TRANSACTION;

INSERT INTO "orders"("userId", "orderNumber", "promoId", "total", "taxAmount", "status", "deliveryAddress", "fullName", "email")
VALUES (10, '#001-10112023-0011', NULL, 75000, 0, 'ON-PROCCESS', 'Jl. Mawar No. 67, Bukit Kecil, Palembang', 'Nana Sari', 'nanasari@hotmail.com');

INSERT INTO "orderDetails" ("productId", "productSizeId", "productVariantId", "quantity", "orderId", "subTotal")
VALUES
(80, 1, 2, 5, 11, 75000);
UPDATE "products"
SET "stock" = 95
WHERE "id" = 80;

COMMIT;
-- ROLLBACK;

SELECT * FROM "products";
-- 2
START TRANSACTION;

INSERT INTO "orders"("userId", "orderNumber", "promoId", "total", "taxAmount", "status", "deliveryAddress", "fullName", "email")
VALUES (11, '#001-10112023-0012', NULL, 75000, 0, 'ON-PROCCESS', 'Jl. Mawar No. 67, Bukit Kecil, Palembang', 'Nana Sari', 'nanasari@hotmail.com');

INSERT INTO "orderDetails" ("productId", "productSizeId", "productVariantId", "quantity", "orderId", "subTotal")
VALUES
(79, 1, 2, 5, 12, 75000);
UPDATE "products"
SET "stock" = 45
WHERE "id" = 79;

-- COMMIT;
ROLLBACK;
SELECT * FROM "products";
SELECT * FROM "users";

/*DEMO RELATION*/
SELECT "p"."name" "nameProducts", "basePrice", "c"."name" "nameCategories", "pr"."code" 
FROM "products" "p"
FULL JOIN "productCategories" "pc" ON "pc"."productId" = "p"."id"
FULL JOIN "categories" "c" ON "pc"."categoryId" = "c"."id"
FULL JOIN "orderDetails" "od" ON "p"."id" = "od"."productId"
FULL JOIN "orders" "o" ON "od"."orderId" = "o"."id"
FULL JOIN "promo" "pr" ON "pr"."id" = "o"."promoId";

SELECT "p"."name","c"."name", "ps"."size", "pv"."name", "o"."orderNumber", "od"."subTotal" 
FROM "products" "p"
INNER JOIN "productCategories" "pc" ON "pc"."productId" = "p"."id"
INNER JOIN "categories" "c" ON "c"."id" = "pc"."categoryId"
INNER JOIN "orderDetails" "od" ON "p"."id" = "od"."productId"
JOIN "productSize" "ps" ON "od"."productSizeId" = "ps"."id"
JOIN "productVariant" "pv" ON "od"."productVariantId" = "pv"."id"
JOIN "orders" "o" ON "od"."orderId" = "o"."id";

SELECT "p"."name" "nameProducts", "basePrice", "c"."name" "nameCategories", "pr"."code" 
FROM "products" "p"
LEFT JOIN "productCategories" "pc" ON "pc"."productId" = "p"."id"
LEFT JOIN "categories" "c" ON "pc"."categoryId" = "c"."id"
LEFT JOIN "orderDetails" "od" ON "p"."id" = "od"."productId"
LEFT JOIN "orders" "o" ON "od"."orderId" = "o"."id"
LEFT JOIN "promo" "pr" ON "pr"."id" = "o"."promoId";

SELECT "p"."name" "nameProducts", "basePrice", "c"."name" "nameCategories", "pr"."code" 
FROM "products" "p"
RIGHT JOIN "productCategories" "pc" ON "pc"."productId" = "p"."id"
RIGHT JOIN "categories" "c" ON "pc"."categoryId" = "c"."id"
RIGHT JOIN "orderDetails" "od" ON "p"."id" = "od"."productId"
RIGHT JOIN "orders" "o" ON "od"."orderId" = "o"."id"
RIGHT JOIN "promo" "pr" ON "pr"."id" = "o"."promoId";
