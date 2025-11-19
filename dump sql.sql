SQL 설계 DUMP
-- --------------------------------------------------------
-- 호스트:                         127.0.0.1
-- 서버 버전:                      10.6.5-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  11.3.0.6295
-- --------------------------------------------------------

CREATE DATABASE IF NOT EXISTS `dev`
USE `dev`;

CREATE TABLE IF NOT EXISTS `t_category` (
  `id` int(11) unsigned NOT NULL COMMENT '카테고리아이디',
  `category1` varchar(50) NOT NULL COMMENT '카테고리1',
  `category2` varchar(50) NOT NULL COMMENT '카테고리2',
  `category3` varchar(50) DEFAULT NULL COMMENT '카테고리3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE IF NOT EXISTS `t_image` (
  `id` int(11) unsigned NOT NULL,
  `product_id` int(11) unsigned NOT NULL COMMENT '제품아이디',
  `type` int(1) NOT NULL DEFAULT 1 COMMENT '1-썸네일, 2-제품이미지, 3-제품설명이미지 ',
  `path` varchar(150) NOT NULL COMMENT '이미지path',
  PRIMARY KEY (`id`),
  KEY `FK_t_image_t_product` (`product_id`),
  CONSTRAINT `FK_t_image_t_product` FOREIGN KEY (`product_id`) REFERENCES `t_product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE IF NOT EXISTS `t_product` (
  `id` int(11) unsigned NOT NULL COMMENT '제품아이디',
  `product_name` varchar(200) DEFAULT NULL COMMENT '제품명',
  `product_price` int(11) NOT NULL DEFAULT 0 COMMENT '제품가',
  `delivery_price` int(11) NOT NULL DEFAULT 0 COMMENT '배송비',
  `add_delivery` int(11) NOT NULL DEFAULT 0 COMMENT '추가배송비',
  `tags` varchar(100) DEFAULT NULL COMMENT '해시태그',
  `outbound_days` int(2) DEFAULT 5 COMMENT '출고일',
  `created_date` datetime NOT NULL DEFAULT current_timestamp() COMMENT '제품등록일',
  `seller_id` int(11) unsigned NOT NULL COMMENT '판매자아이디',
  `category_id` int(11) unsigned NOT NULL COMMENT '카테고리아이디',
  PRIMARY KEY (`id`),
  KEY `FK_t_product_t_seller` (`seller_id`),
  KEY `FK_t_product_t_category` (`category_id`),
  CONSTRAINT `FK_t_product_t_category` FOREIGN KEY (`category_id`) REFERENCES `t_category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_t_product_t_seller` FOREIGN KEY (`seller_id`) REFERENCES `t_seller` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE IF NOT EXISTS `t_seller` (
  `id` int(11) unsigned NOT NULL COMMENT '판매자아이디',
  `name` varchar(50) NOT NULL COMMENT '판매자명',
  `email` varchar(100) NOT NULL COMMENT '판매자이메일',
  `phone` varchar(12) NOT NULL COMMENT '판매자휴대전화번호',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO `t_seller` (`id`, `name`, `email`, `phone`) VALUES
	(1, '이민기', 'mingi371@nate.com', '01012341234');

CREATE TABLE IF NOT EXISTS `t_user` (
  `email` varchar(50) NOT NULL COMMENT '사용자이메일',
  `type` int(1) NOT NULL COMMENT '1-buyer, 2-seller',
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='유저테이블';


CREATE TABLE IF NOT EXISTS t_category (
	id int(11) NOT NULL,
  	category1 varchar(50) NOT NULL,
  	category2 varchar(50) NOT NULL,
  	category3 varchar(50),
  	PRIMARY KEY (id)
) ;

CREATE TABLE IF NOT EXISTS t_seller (
  id int(11) NOT NULL,
  name varchar(50) NOT NULL,
  email varchar(100) NOT NULL,
  phone varchar(12) NOT NULL,
  PRIMARY KEY (id)
) ;

CREATE TABLE IF NOT EXISTS t_user (
  email varchar(50) NOT NULL,
  type int(1) NOT NULL,
  PRIMARY KEY (email)
);

CREATE TABLE IF NOT EXISTS t_product (
  id int(11) NOT NULL,
  product_name varchar(200) DEFAULT NULL,
  product_price int(11) NOT NULL DEFAULT 0,
  delivery_price int(11) NOT NULL DEFAULT 0,
  add_delivery int(11) NOT NULL DEFAULT 0,
  tags varchar(100) DEFAULT NULL,
  outbound_days int(2) DEFAULT 5,
  created_date datetime NOT NULL DEFAULT current_timestamp(),
  seller_id int(11) NOT NULL,
  category_id int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY FK_t_product_t_seller (seller_id),
  KEY FK_t_product_t_category (category_id),
  CONSTRAINT FK_t_product_t_category FOREIGN KEY (category_id) REFERENCES t_category (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_t_product_t_seller FOREIGN KEY (seller_id) REFERENCES t_seller (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ;

CREATE TABLE IF NOT EXISTS t_image (
  id int(11) NOT NULL,
  product_id int(11) NOT NULL,
  type int(1) NOT NULL DEFAULT 1,
  path varchar(150) NOT NULL,
  PRIMARY KEY (id),
  KEY FK_t_image_t_product (product_id),
  CONSTRAINT FK_t_image_t_product FOREIGN KEY (product_id) REFERENCES t_product (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE t_cart (
	product_name VARCHAR(50)
	, tags VARCHAR(50)
	, PATH VARCHAR(20)
	, product_id INT
	, product_price int
	, delivery_price int
	, buyer_id VARCHAR(20)
	, category_id int
);


CREATE TABLE t_order (
	NAME VARCHAR(20)
	, buyer_id VARCHAR(20)
	, address VARCHAR(50)
	, phone VARCHAR(13)
	, message VARCHAR(100)
	, postcode int
	, total_price int
	, product_id int
);