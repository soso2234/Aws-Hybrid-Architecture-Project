SELECT T1.*, T2.category1, T2.category2, T2.category3, T3.path
FROM t_product T1, t_category T2, t_image T3
WHERE T1.CATEGORY_ID = T2.id 
AND T1.id = T3.product_id


/*썸네일*/
SELECT T1.*, T2.category1, T2.category2, T2.category3, T3.path
FROM t_product T1, t_category T2, t_image T3
WHERE T1.CATEGORY_ID = T2.id 
AND T1.id = T3.product_id
AND T3.type = 1


/*제품상세 이미지*/
SELECT T1.*, T2.category1, T2.category2, T2.category3, T3.type,T3.path
FROM t_product T1, t_category T2, t_image T3
WHERE T1.CATEGORY_ID = T2.id 
AND T1.id = T3.product_id
AND T3.type = 3
AND T1.ID = 1


SELECT * FROM t_image 
WHERE PRODUCT_ID = 1
AND TYPE = 2


INSERT INTO t_product 
(
	ID
	, PRODUCT_NAME
	, PRODUCT_PRICE
	, delivery_price
	, add_delivery
	, tags
	, outbound_days
	, seller_id
	, category_id
)
VALUES
(
	3
	,'TEST PRODUCT'
	, '50'
	, '2.5'
	, '5'
	, 'TEST'
	, 5
	, 1
	, 1
)

COMMIT

/*select 쿼리 1*/
SELECT
	t1.*
	, t2.path
	, t3.category1
	, t3.category2
	, t3.category3 
FROM 
	t_product t1, t_image t2, t_category t3
WHERE t1.id = t2.product_id 
AND	t2.`type` = 1
AND	t1.category_id = t3.id

/*select 쿼리 2 -- 상세페이지*/
SELECT
	t1.*
	, t2.path
	, t3.category1
	, t3.category2
	, t3.category3 
FROM 
	t_product t1, t_image t2, t_category t3
WHERE t1.id = 1
AND	t1.id = t2.product_id
AND	t2.`type` = 3
AND	t1.category_id = t3.id


/*SELECT 메인 이미지 가져오기*/
SELECT * FROM t_image
WHERE product_id = 1 AND type = 2

/*insert 제품등록 */
INSERT INTO t_product (id,product_name, product_price, delivery_price, add_delivery, tags, outbound_days, seller_id, category_id)
VALUES (6,"TEST PRODUCT2", 70000, 2500, 2500, "TEST", 5, 1,1)


SELECT * FROM t_product
