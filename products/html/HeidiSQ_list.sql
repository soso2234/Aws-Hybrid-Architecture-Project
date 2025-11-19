-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.6.5-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- dev 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `dev` /*!40100 DEFAULT CHARACTER SET utf8mb3 */;
USE `dev`;

-- 테이블 dev.t_category 구조 내보내기
CREATE TABLE IF NOT EXISTS `t_category` (
  `id` int(11) unsigned NOT NULL COMMENT '카테고리아이디',
  `category1` varchar(50) NOT NULL COMMENT '카테고리1',
  `category2` varchar(50) NOT NULL COMMENT '카테고리2',
  `category3` varchar(50) DEFAULT NULL COMMENT '카테고리3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 dev.t_category:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `t_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_category` ENABLE KEYS */;

-- 테이블 dev.t_image 구조 내보내기
CREATE TABLE IF NOT EXISTS `t_image` (
  `id` int(11) unsigned NOT NULL,
  `product_id` int(11) unsigned NOT NULL COMMENT '제품아이디',
  `type` int(1) NOT NULL DEFAULT 1 COMMENT '1-썸네일, 2-제품이미지, 3-제품설명이미지 ',
  `path` varchar(150) NOT NULL COMMENT '이미지path',
  PRIMARY KEY (`id`),
  KEY `FK_t_image_t_product` (`product_id`),
  CONSTRAINT `FK_t_image_t_product` FOREIGN KEY (`product_id`) REFERENCES `t_product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 dev.t_image:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `t_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_image` ENABLE KEYS */;

-- 테이블 dev.t_product 구조 내보내기
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

-- 테이블 데이터 dev.t_product:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `t_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_product` ENABLE KEYS */;

-- 테이블 dev.t_seller 구조 내보내기
CREATE TABLE IF NOT EXISTS `t_seller` (
  `id` int(11) unsigned NOT NULL COMMENT '판매자아이디',
  `name` varchar(50) NOT NULL COMMENT '판매자명',
  `email` varchar(100) NOT NULL COMMENT '판매자이메일',
  `phone` varchar(12) NOT NULL COMMENT '판매자휴대전화번호',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 dev.t_seller:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `t_seller` DISABLE KEYS */;
INSERT INTO `t_seller` (`id`, `name`, `email`, `phone`) VALUES
	(1, '이민기', 'mingi371@nate.com', '01012341234');
/*!40000 ALTER TABLE `t_seller` ENABLE KEYS */;

-- 테이블 dev.t_user 구조 내보내기
CREATE TABLE IF NOT EXISTS `t_user` (
  `nickname` varchar(20) NOT NULL COMMENT '이름',
  `email` varchar(50) NOT NULL COMMENT '사용자이메일',
  `type` int(1) NULL COMMENT '1-buyer, 2-seller',
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='유저테이블';

-- 테이블 데이터 dev.t_user:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `t_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;



/*Sequel ACE 쿼리문*/
-- 테이블 dev.t_category 구조 내보내기
CREATE TABLE IF NOT EXISTS t_category (
	id int(11) NOT NULL,
  	category1 varchar(50) NOT NULL,
  	category2 varchar(50) NOT NULL,
  	category3 varchar(50),
  	PRIMARY KEY (id)
) ;

-- 테이블 dev.t_seller 구조 내보내기
CREATE TABLE IF NOT EXISTS t_seller (
  id int(11) NOT NULL AUTO INCREMENT,
  name varchar(50) NOT NULL,
  email varchar(100) NOT NULL,
  phone varchar(12) NOT NULL,
  PRIMARY KEY (id)
) ;

-- 테이블 dev.t_user 구조 내보내기
CREATE TABLE IF NOT EXISTS t_user (
  nickname varchar(20) NOT NULL,
  email varchar(50) NOT NULL,
  type int(1) NULL,
  PRIMARY KEY (email)
);

-- 테이블 dev.t_product 구조 내보내기
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

-- 테이블 dev.t_image 구조 내보내기
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
	name VARCHAR(20)
	, buyer_id VARCHAR(20)
	, address VARCHAR(50)
	, phone VARCHAR(13)
	, message VARCHAR(100)
	, postcode int
	, total_price int
	, product_id int
);