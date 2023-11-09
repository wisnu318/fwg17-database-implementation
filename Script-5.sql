create table "users" (
	"id" serial primary key,
	"fullName" varchar(100) not null,
	"email" varchar(100) not null,
	"password" varchar(100) not null,
	"address" text not null,
	"picture" varchar(255),
	"phoneNumber" varchar(100) not null,
	"role" varchar(100) check ("role" in ('admin','staff','customer'))not null,
	"created_At" timestamp default now(),
	"updated_At" timestamp
);
create table "products"(
	"id" serial primary key,
	"name" varchar(100) not null,
	"description" text not null,
	"basePrice" numeric(12,2) not null,
	"image"varchar(255) not null,
	"discount" float not null,
	"isRecommended" varchar(100)check ("isRecommended"in ('Recomended','Not Recomended')) not null,
	"created_At" timestamp default now(),
	"updated_At" timestamp
);
create table "productSize" (
	"id" serial primary key,
	"size" varchar(100) check ("size" in ('small','medium','large')) not null,
	"aditionalPrice" numeric(12,2) not null,
	"created_At" timestamp default now(),
	"updated_At" timestamp
);
create table "productVariant"(
	"id" serial primary key,
	"name" varchar(100) check ("name" in ('ice','hot')) not null,
	"adittionalPrice" numeric(12,2) not null,
	"created_At" timestamp default now(),
	"updated_At" timestamp
);
create table "tags"(
	"id" serial primary key,
	"name" varchar(100) not null,
	"created_At" timestamp default now(),
	"updated_At" timestamp
);
create table "productTags" (
	"id" serial primary key,
	"productId" int references "products"("id"),
	"tagId" int references "tags"("id"),
	"created_At" timestamp default now(),
	"updated_At" timestamp
);
create table "productRatings" (
	"id" serial primary key,
	"productId" int references "products"("id"),
	"rate" int check ("rate" >= 1 and "rate"<=5) not null,
	"reviewMessage" text not null,
	"userId" int references "users"("id"),
	"created_At" timestamp default now(),
	"updated_At" timestamp
);
create table "categories"(
	"id" serial primary key,
	"name" varchar(100) not null,
	"created_At" timestamp default now(),
	"updated_At" timestamp
);
create table "productCategories"(
	"id" serial primary key,
	"productId" int references "products"("id"),
	"categoryId" int references "categories"("id"),
	"created_At" timestamp default now(),
	"updated_At" timestamp
);
create table "promo"(
	"id" serial primary key,
	"name" varchar(100) not null,
	"code" varchar(100) not null,
	"description" text not null,
	"percentage" float not null,
	"isExpired" date not null,
	"maximumPromo" numeric (12,2) not null,
	"minimumAmount" numeric (12,2) not null,
	"created_At" timestamp default now(),
	"updated_At" timestamp
);
create table "orders" (
	"id" serial primary key,
	"userId" int references "users"("id"),
	"orderNumber" varchar(100) not null,
	"promoId" int references "promo"("id"),
	"total" numeric(12,2) not null,
	"taxAmount" float not null,
	"status" varchar(100) check ("status" in ('on-progress','delivered','canceled','ready-to-pick')) not null,
	"deliveryAddress" text not null,
	"fullName" varchar(100) not null,
	"email" varchar(100) not null,
	"created_At" timestamp default now(),
	"updated_At" timestamp
);
create table "orderDetails"(
	"id" serial primary key,
	"productId" int references "products"("id"),
	"productSizeId" int references "productSize"("id"),
	"productVariantId" int references "productVariant"("id"),
	"quantity" int not null,
	"orderId" int references "orders"("id"),
	"created_At" timestamp default now(),
	"updated_At" timestamp
);
create table "message"(
	"id" serial primary key,
	"recipientId" int references "users"("id"),
	"senderId" int references "users"("id"),
	"text" text not null,
	"created_At" timestamp default now(),
	"updated_At" timestamp
);

insert into "users"("fullName","email","password","address","picture","phoneNumber","role")
values
	('Lala Rizky','lalarizky@gmail.com','lala456','Jl. Flamboyan No. 23, Bukit Kecil, Palembang','http://example.com/lala456.jpg','+6291789012345','customer'),
	('Maman Hermawan','mamanhermawan@yahoo.com','maman789','Jl. Teratai No. 45, Bukit Kecil, Palembang','http://example.com/maman123.jpg','+6291890123456','admin'),
	('Nana Sari','nanasari@hotmail.com','nana012','Jl. Mawar No. 67, Bukit Kecil, Palembang','http://example.com/nana012.jpg','+6291901234567','staff'),
	('Oki Prasetyo','okiprasetyo@outlook.com','oki345','Jl. Kenanga No. 89, Bukit Kecil, Palembang','http://example.com/oki345.jpg','+6292012345678','customer'),
	('Pina Wulandari','pinawulandari@gmail.com','pina678','Jl. Cempaka No. 12, Bukit Kecil, Palembang','http://example.com/pina123.jpg','+6292123456789','staff'),
	('Raka Satria','rakasatria@gmail.com','raka901','Jl. Kemuning No. 34, Bukit Kecil, Palembang','http://example.com/raka213.jpg','+6292234567890','admin'),
	('Sinta Larasati','sintalarasati@yahoo.com','sinta234','Jl. Dahlia No. 56, Bukit Kecil, Palembang','http://example.com/sinta234.jpg','+6292345678901','staff'),
	('Tia Permata','tiapermata@hotmail.com','tia567','Jl. Teratai No. 78, Bukit Kecil, Palembang','http://example.com/tia567.jpg','+6292456789012','customer'),
	('Ujang Pratama','ujangpratama@outlook.com','ujang890','Jl. Mawar No. 90, Bukit Kecil, Palembang','http://example.com/ujang890.jpg','+6292567890123','staff'),
	('Vivi Surya','vivisurya@gmail.com','vivi123','Jl. Kenanga No. 12, Bukit Kecil, Palembang','http://example.com/vivi123.jpg','+6292678901234','customer'),
	('Lala indri','lalaindri@gmail.com','lala789','Jl. Flamboyan No. 11, Bukit Kecil, Palembang','http://example.com/lala789.jpg','+6291789015678','admin'),
	('Maman Hendrawan','mamanhendrawan@yahoo.com','maman123','Jl. Teratai No. 13, Bukit Kecil, Palembang','http://example.com/maman123.jpg','+6291890123544','admin'),
	('Nana santi','nanasanti@hotmail.com','nana123','Jl. Mawar No. 15, Bukit Kecil, Palembang','http://example.com/nana123.jpg','+6291901234123','staff'),
	('Oki Candra','okicandra@outlook.com','oki678','Jl. Kenanga No. 01, Bukit Kecil, Palembang','http://example.com/oki678.jpg','+6292012345123','customer'),
	('Pina Cantika','pinacantika@gmail.com','pina123','Jl. Cempaka No. 02, Bukit Kecil, Palembang','http://example.com/pina123.jpg','+6292123456123','staff'),
	('Raka Satrianta','rakasatrianta@gmail.com','raka213','Jl. Kemuning No. 13, Bukit Kecil, Palembang','http://example.com/raka213.jpg','+6292234567123','admin'),
	('Sinta Larasanti','sintalarasanti@yahoo.com','sinta123','Jl. Dahlia No. 12, Bukit Kecil, Palembang','http://example.com/sinta123.jpg','+6292345678123','staff'),
	('Tia Permata Sari','tiapermata01@hotmail.com','tia123','Jl. Teratai No. 12, Bukit Kecil, Palembang','http://example.com/tia123.jpg','+6292456789123','customer'),
	('Ujang Pramata','ujangpramata@outlook.com','ujang123','Jl. Mawar No. 11, Bukit Kecil, Palembang','http://example.com/ujang123.jpg','+6292567890123','staff'),
	('Vivi Suryaningsih','vivisuryaningsih@gmail.com','vivi456','Jl. Kenanga No. 67, Bukit Kecil, Palembang','http://example.com/20.jpg','+6292678901567','customer'),
	('Bima Satria','bimasatria@gmail.com','bima456','Jl. Flamboyan No. 23, Bukit Kecil, Palembang','http://example.com/21.jpg','+6290789012345','customer'),
	('Cinta Larasati','cintalarasati@yahoo.com','cinta789','Jl. Teratai No. 45, Bukit Kecil, Palembang','http://example.com/22.jpg','+6290890123456','admin'),
	('Dian Permata','dianpermata@hotmail.com','dian012','Jl. Mawar No. 67, Bukit Kecil, Palembang','http://example.com/23.jpg','+6290901234567','staff'),
	('Eko Prasetyo','ekoprasetyo@outlook.com','eko345','Jl. Kenanga No. 89, Bukit Kecil, Palembang','http://example.com/24.jpg','+6291012345678','customer'),
	('Fina Wulandari','finawulandari@gmail.com','fina678','Jl. Cempaka No. 12, Bukit Kecil, Palembang','http://example.com/25.jpg','+6291123456789','staff'),
	('Vina Rizky','vinarizky@gmail.com','vina901','Jl. Dahlia No. 34, Bukit Kecil, Palembang','http://example.com/26.jpg','+6290234567890','admin'),
	('Wawan Hermawan','wawanhermawan@yahoo.com','wawan234','Jl. Teratai No. 56, Bukit Kecil, Palembang','http://example.com/27.jpg','+6290345678901','staff'),
	('Yuli Astuti','yuliastuti@hotmail.com','yuli567','Jl. Mawar No. 78, Bukit Kecil, Palembang','http://example.com/28.jpg','+6290456789012','customer'),
	('Zaki Pratama','zakipratama@outlook.com','zaki890','Jl. Kenanga No. 90, Bukit Kecil, Palembang','http://example.com/29.jpg','+6290567890123','staff'),
	('Aini Nurul','aininurul@gmail.com','aini123','Jl. Cempaka No. 12, Bukit Kecil, Palembang','http://example.com/30.jpg','+6290678901234','customer'),
	('Puput Lestari','puputlestari@gmail.com','puput456','Jl. Mawar No. 23, Bukit Kecil, Palembang','http://example.com/31.jpg','+6289789012345','customer'),
	('Rian Aditya','rianaditya@yahoo.com','rian789','Jl. Kenanga No. 45, Bukit Kecil, Palembang','http://example.com/32.jpg','+6289890123456','admin'),
	('Sari Dewi','saridewi@hotmail.com','sari012','Jl. Cempaka No. 67, Bukit Kecil, Palembang','http://example.com/33.jpg','+6289901234567','staff'),
	('Teguh Pratama','teguhpratama@outlook.com','teguh345','Jl. Flamboyan No. 89, Bukit Kecil, Palembang','http://example.com/34.jpg','+6290012345678','customer'),
	('Umi Kalsum','umikalsum@gmail.com','umi678','Jl. Kemuning No. 12, Bukit Kecil, Palembang','http://example.com/35.jpg','+6290123456789','staff'),
	('Kiki Ramadhan','kikiramadhan@gmail.com','kiki901','Jl. Cempaka No. 34, Bukit Kecil, Palembang','http://example.com/36.jpg','+6289234567890','admin'),
	('Lina Wati','linawati@yahoo.com','lina234','Jl. Flamboyan No. 56, Bukit Kecil, Palembang','http://example.com/37.jpg','+6289345678901','staff'),
	('Mira Fitri','mirafitri@hotmail.com','mira567','Jl. Kemuning No. 78, Bukit Kecil, Palembang','http://example.com/38.jpg','+6289456789012','customer'),
	('Nando Putra','nandoputra@outlook.com','nando890','Jl. Dahlia No. 90, Bukit Kecil, Palembang','http://example.com/39.jpg','+6289567890123','staff'),
	('Oka Surya','okasurya@gmail.com','oka123','Jl. Teratai No. 12, Bukit Kecil, Palembang','http://example.com/40.jpg','+6289678901234','customer'),
	('Fajar Rizki','fajarrizki@gmail.com','fajar456','Jl. Durian No. 23, Bukit Kecil, Palembang','http://example.com/41.jpg','+6286789012345','customer'),
	('Gita Sari','gitasari@yahoo.com','gita789','Jl. Melati No. 45, Bukit Kecil, Palembang','http://example.com/42.jpg','+6287890123456','admin'),
	('Hadi Prasetyo','hadiprasetyo@hotmail.com','hadi012','Jl. Anggrek No. 67, Bukit Kecil, Palembang','http://example.com/43.jpg','+6288901234567','staff'),
	('Indah Puspita','indahpuspita@outlook.com','indah345','Jl. Mawar No. 89, Bukit Kecil, Palembang','http://example.com/44.jpg','+6289012345678','customer'),
	('Joko Widodo','jokowidodo@gmail.com','joko678','Jl. Kenanga No. 12, Bukit Kecil, Palembang','http://example.com/45.jpg','+6289123456789','staff'),
	('Agus Setiawan','agussetiawan@gmail.com','agus123','Jl. Merdeka No. 12, Bukit Kecil, Palembang','http://example.com/46.jpg','+6281234567890','admin'),
	('Budi Santoso','budisantoso@yahoo.com','budi456','Jl. Raya No. 34, Bukit Kecil, Palembang','http://example.com/47.jpg','+6282345678901','staff'),
	('Cici Nurul','cicinurul@hotmail.com','cici789','Jl. Kebun No. 56, Bukit Kecil, Palembang','http://example.com/48.jpg','+6283456789012','customer'),
	('Dedi Pratama','dedipratama@outlook.com','dedi012','Jl. Mangga No. 78, Bukit Kecil, Palembang','http://example.com/49.jpg','+6284567890123','staff'),
	('Eka Putri','ekaputri@gmail.com','eka345','Jl. Nanas No. 90, Bukit Kecil, Palembang','http://example.com/50.jpg','+6285678901234','customer'),
	('John Doe','john.doe@example.com','hashed_password_1','123 Main St, City','http://example.com/johndoe.jpg','+6281234567890','admin'),
	('Jane Smith','jane.smith@example.com','hashed_password_2','456 Oak St, Town','http://example.com/janesmith.jpg','+6289876543210','staff'),
	('Bob Johnson','bob.johnson@example.com','hashed_password_3','789 Pine St, Village','http://example.com/bobjohnson.jpg','+6281112223333','customer'),
	('Alice Lee','alice.lee@example.com','hashed_password_4','999 Elm St, Hamlet','http://example.com/alicelee.jpg','+6284445556666','customer'),
	('David Wang','david.wang@example.com','hashed_password_5','567 Birch St, Suburb','http://example.com/davidwang.jpg','+6285556667777','admin');
	

insert into "products" ("name","description","basePrice","image","discount","isRecommended")
values
('Espresso', 'Kopi hitam klasik dengan rasa pekat', 10000, 'http://example.com/p1.jpg', 0, 'Recomended'),
('Latte', 'Espresso dengan susu steamed dan sedikit buih', 10000, 'http://example.com/p2.jpg', 0, 'Not Recomended'),
('Cappuccino', 'Espresso dengan sejumlah sama susu dan foam susu', 10000, 'http://example.com/p3.jpg', 0, 'Recomended'),
('Americano', 'Espresso dengan lebih banyak air', 10000, 'http://example.com/p4.jpg', 0, 'Not Recomended'),
('Mocha', 'Espresso dengan campuran susu dan cokelat', 10000, 'http://example.com/p5.jpg', 0, 'Recomended'),
('Macchiato', 'Espresso dengan sejumlah kecil susu', 10000, 'http://example.com/p6.jpg', 0, 'Not Recomended'),
('Flat White', 'Espresso dengan susu steamed dan foam yang halus', 10000, 'http://example.com/p7.jpg', 0, 'Recomended'),
('Affogato', 'Espresso disiramkan ke atas es krim vanilla', 10000, 'http://example.com/p8.jpg', 0, 'Not Recomended'),
('Cold Brew', 'Kopi diseduh dengan air dingin selama beberapa jam', 10000, 'http://example.com/p9.jpg', 0, 'Recomended'),
('Irish Coffee', 'Kopi dengan campuran whiskey dan krim', 10000, 'http://example.com/p10.jpg', 0, 'Not Recomended'),
('Pour Over', 'Metode penyeduhan kopi secara manual dengan air panas', 10000, 'http://example.com/p11.jpg', 0, 'Recomended'),
('Turkish Coffee', 'Kopi yang diseduh dengan bubuk kopi, air, dan gula', 10000, 'http://example.com/p12.jpg', 0, 'Not Recomended'),
('Vienna Coffee', 'Espresso dengan tambahan krim dan gula', 10000, 'http://example.com/p13.jpg', 0, 'Recomended'),
('Ristretto', 'Espresso dengan volume air yang lebih sedikit', 10000, 'http://example.com/p14.jpg', 0, 'Not Recomended'),
('Iced Caramel Macchiato', 'Espresso dengan susu dan sirup karamel di atas es', 10000, 'http://example.com/p15.jpg', 0, 'Recomended'),
('Nitro Cold Brew', 'Cold brew dengan nitrogen untuk kelembutan dan kebasaan', 10000, 'http://example.com/p16.jpg', 0, 'Not Recomended'),
('Maple Pecan Latte', 'Latte dengan campuran rasa maple dan kacang pecan', 10000, 'http://example.com/p17.jpg', 0, 'Recomended'),
('Cascara Fizz', 'Minuman ringan berkarbonasi dengan cascara (kulit buah kopi)', 10000, 'http://example.com/p18.jpg', 0, 'Not Recomended'),
('Honey Lavender Latte', 'Latte dengan campuran madu dan lavender', 10000, 'http://example.com/p19.jpg', 0, 'Recomended'),
('Cinnamon Dolce Latte', 'Latte dengan campuran cinnamon dan gula', 10000, 'http://example.com/p20.jpg', 0, 'Not Recomended'),
('Black and Tan', 'Campuran Cold Brew dan Nitro Cold Brew', 10000, 'http://example.com/p21.jpg', 0, 'Recomended'),
('Espresso Tonic', 'Espresso disajikan dengan tonik dan es', 10000, 'http://example.com/p22.jpg', 0, 'Not Recomended'),
('Coconut Cold Brew', 'Cold brew dengan tambahan susu kelapa', 10000, 'http://example.com/p23.jpg', 0, 'Recomended'),
('Chai Latte', 'Campuran teh chai dengan susu dan rempah-rempah', 10000, 'http://example.com/p24.jpg', 0, 'Not Recomended'),
('Hazelnut Mocha', 'Mocha dengan tambahan rasa hazelnut', 10000, 'http://example.com/p25.jpg', 0, 'Recomended'),
('Café au Lait', 'Setengah kopi, setengah susu panas', 10000, 'http://example.com/p26.jpg', 0, 'Not Recomended'),
('Iced Matcha Latte', 'Matcha dengan susu dan es', 10000, 'http://example.com/p27.jpg', 0, 'Recomended'),
('Espresso Affogato', 'Espresso disiramkan ke atas es krim vanilla', 10000, 'http://example.com/p28.jpg', 0,'Not Recomended'),
('Pumpkin Spice Latte', 'Latte dengan campuran pumpkin spice', 10000, 'http://example.com/p29.jpg', 0, 'Recomended'),
('Irish Cream Cold Brew', 'KOPI Cold brew dengan campuran irish cream', 10000, 'http://example.com/p30.jpg', 0,'Not Recomended'),
('Avocado Toast', 'Roti gandum panggang dengan alpukat matang di atasnya', 15000, 'http://example.com/p31.jpg', 0, 'Recomended'),
('Caprese Sandwich', 'Roti dengan tomat, mozzarella, dan daun basil', 15000, 'http://example.com/p32.jpg', 0, 'Not Recomended'),
('Quinoa Salad', 'Salad segar dengan quinoa, sayuran, dan dressing balsamic', 15000, 'http://example.com/p33.jpg', 0, 'Recomended'),
('Chicken Caesar Wrap', 'Wrap dengan potongan ayam panggang, selada romaine, dan dressing caesar', 15000, 'http://example.com/p34.jpg', 0, 'Not Recomended'),
('Vegetarian Panini', 'Panini dengan sayuran panggang dan keju', 15000, 'http://example.com/p35.jpg', 0, 'Recomended'),
('Smashed Chickpea Sandwich', 'Roti dengan pasta kececi yang diremas, selada, dan tomat', 15000, 'http://example.com/p36.jpg', 0, 'Not Recomended'),
('Bacon and Egg Croissant', 'Croissant dengan bacon dan telur dadar', 15000, 'http://example.com/p37.jpg', 0, 'Recomended'),
('Spinach and Feta Quiche', 'Quiche dengan bayam dan keju feta', 15000, 'http://example.com/p38.jpg', 0, 'Not Recomended'),
('Classic Bagel with Cream Cheese', 'Bagel klasik dengan krim keju', 15000, 'http://example.com/p39.jpg', 0, 'Recomended'),
('Blueberry Muffin', 'Muffin dengan blueberry di dalamnya', 15000, 'http://example.com/p40.jpg', 0, 'Not Recomended'),
('Salmon Bagel', 'Bagel dengan irisan salmon, krim keju, dan capers', 15000, 'http://example.com/p41.jpg', 0, 'Recomended'),
('Vegan Buddha Bowl', 'Bowl dengan campuran sayuran panggang, quinoa, dan hummus', 15000, 'http://example.com/p42.jpg', 0, 'Not Recomended'),
('Turkey and Swiss Sandwich', 'Roti dengan daging kalkun, keju Swiss, dan selada', 15000, 'http://example.com/p43.jpg', 0, 'Recomended'),
('Shrimp Tacos', 'Taco dengan udang panggang, salsa, dan saus krim', 15000, 'http://example.com/p44.jpg', 0, 'Not Recomended'),
('Pesto Chicken Panini', 'Panini dengan potongan ayam, saus pesto, dan keju', 15000, 'http://example.com/p45.jpg', 0, 'Recomended'),
('Mushroom Risotto', 'Risotto dengan jamur panggang dan parmesan', 15000, 'http://example.com/p46.jpg', 0, 'Not Recomended'),
('Crispy Cauliflower Bites', 'Gorengan kembang kol yang renyah', 15000, 'http://example.com/p47.jpg', 0, 'Recomended'),
('Tomato Basil Soup', 'Sup tomat dengan basil segar', 15000, 'http://example.com/p48.jpg', 0, 'Not Recomended'),
('Steak and Arugula Salad', 'Salad dengan irisan daging sapi panggang dan rucola', 15000, 'http://example.com/p49.jpg', 0, 'Recomended'),
('Choco-Banana Pancakes', 'MAKANAN Pancake dengan potongan pisang dan saus cokelat', 15000, 'http://example.com/p50.jpg', 0, 'Not Recomended'),
('Classic Lemonade', 'Lemonade segar dengan es', 10000, 'http://example.com/p51.jpg', 0, 'Recomended'),
('Iced Tea', 'Teh hitam atau hijau disajikan dengan es', 10000, 'http://example.com/p52.jpg', 0, 'Not Recomended'),
('Orange Mango Smoothie', 'Smoothie dengan campuran jeruk dan mangga', 10000, 'http://example.com/p53.jpg', 0, 'Recomended'),
('Sparkling Raspberry Lemonade', 'Lemonade bersoda dengan rasa raspberry', 10000, 'http://example.com/p54.jpg', 0, 'Not Recomended'),
('Minty Fresh Limeade', 'Limeade dengan aroma mint yang menyegarkan', 10000, 'http://example.com/p55.jpg', 0, 'Recomended'),
('Pineapple Coconut Cooler', 'Minuman dingin dengan campuran nanas dan kelapa', 10000, 'http://example.com/p56.jpg', 0, 'Not Recomended'),
('Berry Burst Frappuccino', 'Minuman dingin berbasis susu dengan campuran buah berry', 10000, 'http://example.com/p57.jpg', 0, 'Recomended'),
('Cucumber Mint Refresher', 'Minuman segar dengan campuran mentimun dan mint', 10000, 'http://example.com/p58.jpg', 0, 'Not Recomended'),
('Watermelon Lemon Splash', 'Minuman lemonade dengan campuran semangka', 10000, 'http://example.com/p59.jpg', 0,'Recomended'),
('Blueberry Lavender Fizz', 'Minuman berkarbonasi dengan campuran blueberry dan lavender', 10000, 'http://example.com/p60.jpg', 0, 'Not Recomended'),
('Lemon Berry Splash', 'Minuman segar dengan campuran lemon dan beri', 10000, 'http://example.com/p61.jpg', 0,'Recomended'),
('Passion Fruit Iced Tea', 'Teh hitam dengan campuran buah markisa dan es', 10000, 'http://example.com/p62.jpg', 0, 'Not Recomended'),
('Peachy Keen Smoothie', 'Smoothie dengan campuran buah persik dan yogurt', 10000, 'http://example.com/p63.jpg', 0, 'Recomended'),
('Green Apple Fizz', 'Minuman berkarbonasi dengan rasa apel hijau', 10000, 'http://example.com/p64.jpg', 0, 'Not Recomended'),
('Cherry Lime Rickey', 'Minuman dengan campuran ceri, lime, dan soda', 10000, 'http://example.com/p65.jpg', 0, 'Recomended'),
('Mango Tango Cooler', 'Minuman dingin dengan campuran mangga dan jeruk', 10000, 'http://example.com/p66.jpg', 0, 'Not Recomended'),
('Blackberry Basil Lemonade', 'Lemonade dengan campuran blackberry dan daun basil', 10000, 'http://example.com/p67.jpg', 0, 'Recomended'),
('Coconut Pineapple Refresher', 'Minuman segar dengan campuran kelapa dan nanas', 10000, 'http://example.com/p68.jpg', 0, 'Not Recomended'),
('Hibiscus Rose Punch', 'Minuman punch dengan campuran hibiscus dan rose', 10000, 'http://example.com/p69.jpg', 0, 'Recomended'),
('Cranberry Cucumber Sparkle', 'Minuman berkarbonasi dengan campuran cranberry dan mentimun', 10000, 'http://example.com/p70.jpg', 0, 'Not Recomended'),
('Tropical Mango Twist', 'Minuman dingin dengan campuran mangga dan buah tropis lainnya', 10000, 'http://example.com/p71.jpg', 0, 'Recomended'),
('Raspberry Lemon Spritz', 'Minuman berkarbonasi dengan campuran raspberry dan lemon', 10000, 'http://example.com/p72.jpg', 0, 'Not Recomended'),
('Ginger Peach Iced Tea', 'Teh dingin dengan campuran jahe dan buah persik', 10000, 'http://example.com/p73.jpg', 0, 'Recomended'),
('Blue Lagoon Smoothie', 'Smoothie dengan campuran blueberry dan yogurt', 10000, 'http://example.com/p74.jpg', 0, 'Not Recomended'),
('Watermelon Mint Refresher', 'Minuman segar dengan campuran semangka dan mint', 10000, 'http://example.com/p75.jpg', 0, 'Recomended'),
('Cranberry Orange Sparkle', 'Minuman berkarbonasi dengan campuran cranberry dan jeruk', 10000, 'http://example.com/p76.jpg', 0, 'Not Recomended'),
('Pineapple Basil Splash', 'Minuman dingin dengan campuran nanas dan daun basil', 10000, 'http://example.com/p77.jpg', 0, 'Recomended'),
('Citrus Punch Fizz', 'Minuman berkarbonasi dengan campuran berbagai buah citrus', 10000, 'http://example.com/p78.jpg', 0, 'Not Recomended'),
('Berry Hibiscus Cooler', 'Minuman dingin dengan campuran beri dan bunga hibiscus', 10000, 'http://example.com/p79.jpg', 0, 'Recomended'),
('Green Tea Mojito', 'Minuman dingin dengan campuran green tea, mint, dan lime', 10000, 'http://example.com/p80.jpg', 0, 'Not Recomended');

insert into "productSize" ("size", "aditionalPrice")
values
('small', 3000),
('medium', 5000),
('large', 8000);

insert into "productVariant" ("name", "adittionalPrice")
values
('ice', 4000),
('hot', 2000);

insert into "tags"("name")
values
('Buy 1 get 1'),
('Flash sale'),
('Birthday Package'),
('Cheap');

insert into "categories" ("name")
values
('coffee'),
('food'),
('nonCoffe');

insert into "productCategories" ("productId","categoryId")
values
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