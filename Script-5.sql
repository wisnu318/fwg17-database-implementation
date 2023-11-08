create table "users" (
	"id" int serial primary key,
	"fullName" varchar(100) not null,
	"email" varchar(100) not null,
	"password" varchar(100) not null,
	"address" text not null,
	"picture" varchar(255),
	"phoneNumber" varchar(100) not null,
	"role" enum ("admin","staff","customer") not null,
	"created_At" timestamp default now(),
	"updated_At" timestamp
);
create table "products"(
	"id" int serial primary key,
	"name" varchar(100) not null,
	"description" text not null,
	"basePrice" numeric(12,2) not null,
	"image"varchar(255) not null,
	"discount" float not null,
	"isRecommended" enum ('Recomended','Not Recomended') not null,
	"created_At" timestamp default now(),
	"updated_At" timestamp
);
create table "productSize" (
	"id" int serial primary key,
	"size"enum ('small','medium','large') not null,
	"aditionalPrice" numeric(12,2) not null,
	"created_At" timestamp default now(),
	"updated_At" timestamp
);
create table "productVariant"(
	"id" int serial primary key,
	"name" enum ('ice','hot') not null,
	"adittionalPrice" numeric(12,2) not null,
	"created_At" timestamp default now(),
	"updated_At" timestamp
);
create table "tags"(
	"id" int serial primary key,
	"name" varchar(100) not null,
	"created_At" timestamp default now(),
	"updated_At" timestamp
);
create table "productTags" (
	"id" int serial primary key,
	"productId" int references "products"("id"),
	"tagId" int references "tags"("id"),
	"created_At" timestamp default now(),
	"updated_At" timestamp
);
create table "productRatings" (
	"id" int serial primary key,
	"productId" int references "products"("id"),
	"rate" int check ("rate" >= 1 and "rate"<=5) not null,
	"reviewMessage" text not null,
	"userId" int references "users"("id"),
	"created_At" timestamp default now(),
	"updated_At" timestamp
);
create table "categories"(
	"id" int serial primary key,
	"name" varchar(100) not null,
	"created_At" timestamp default now(),
	"updated_At" timestamp
);
create table "productCategories"(
	"id" int serial primary key,
	"productId" int references "products"("id"),
	"categoryId" int references "categories"("id"),
	"created_At" timestamp default now(),
	"updated_At" timestamp
);
create table "promo"(
	"id" int serial primary key,
	"name" varchar(100) not null,
	"code" varchar(100) not null,
	"description" text not null,
	"percentage" float not null
	"isExpired" date not null,
	"maximumPromo" numeric (12,2) not null,
	"minimumAmount" numeric (12,2) not null,
	"created_At" timestamp default now(),
	"updated_At" timestamp
);
create table "orders" (
	"id" int serial primary key,
	"userId" int references "users"("id"),
	"orderNumber" varchar(100) not null,
	"promoId" int references "promo"("id"),
	"total" numeric(12,2) not null,
	"taxAmount" float not null,
	"status" enum('on-progress','delivered','canceled','ready-to-pick') not null,
	"deliveryAddress" text not null,
	"fullName" varchar(100) not null,
	"email"varchar(100) not null,
	"created_At" timestamp default now(),
	"updated_At" timestamp
);
create table "orderDetails"(
	"id" int serial primary key,
	"productId" int references "products"("id"),
	"productSizeId" int references "productSize"("id"),
	"productVariantId" int references "productVariant"("id"),
	"quantity" int not null,
	"orderId" int references "orders"("id"),
	"created_At" timestamp default now(),
	"updated_At" timestamp
);
create table "message"(
	"id" int serial primary key,
	"recipientId" int references "users"("id"),
	"senderId" int references "users"("id"),
	"text" text not null,
	"created_At" timestamp default now(),
	"updated_At" timestamp
);