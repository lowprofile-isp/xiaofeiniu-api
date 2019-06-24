SET NAMES UTF8;
DROP DATABASE IF EXISTS xiaofeiniu;
CREATE DATABASE xiaofeiniu CHARSET=UTF8;
USE xiaofeiniu;

/*管理员*/
CREATE TABLE xfn_admin(
	aid 		INT		PRIMARY KEY AUTO_INCREMENT,
	aname 	VARCHAR(32) UNIQUE,
	apwd		VARCHAR(64)
);
INSERT INTO xfn_admin VALUES
(NULL,'admin',PASSWORD('123456'));

/*全局设置表*/
CREATE TABLE xfn_settings(
	sid				INT		PRIMARY KEY AUTO_INCREMENT,
	appName 	VARCHAR(32),
	apiUrl		VARCHAR(64),
	adminUrl  VARCHAR(64),
	appUrl		VARCHAR(64),
	icp				VARCHAR(64),
	copyright	VARCHAR(128)
);
INSERT INTO xfn_settings VALUES
(NULL,'小肥牛','http://127.0.0.1:8090','http://127.0.0.1:8091','http://127.0.0.1:8092','京ICP备12003709号-3','Copyright © 北京达内金桥科技有限公司版权所有');

/*桌台信息*/
CREATE TABLE xfn_table(
	tid			INT		PRIMARY KEY AUTO_INCREMENT,
	tname 	VARCHAR(32),
	type 		VARCHAR(16),
	status 	BIGINT
);
INSERT INTO xfn_table VALUES
(1, '金镶玉', '2人桌', 1),
(2, '玉如意', '2人桌', 1),
(3, '齐天寿', '6人桌', 3),
(5, '福临门', '4人桌', 2),
(6, '全家福', '6人桌', 3),
(7, '展宏图', '2人桌', 1),
(8, '万年长', '8人桌', 1),
(9, '百事通', '4人桌', 3),
(10, '满堂彩', '10人桌', 2),
(11, '鸿运头', '8人桌', 1),
(12, '福满堂', '12人桌', 1),
(13, '高升阁', '4人桌', 3),
(15, '乐逍遥', '2人桌',3);

/*桌台预定信息*/
CREATE TABLE xfn_reservation(
  rid INT PRIMARY KEY AUTO_INCREMENT,
  contactName VARCHAR(32),
  phone VARCHAR(16),
  contactTime BIGINT,
  dinnerTime BIGINT,
  tableId INT,
  FOREIGN KEY(tableId) REFERENCES xfn_table(tid) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO xfn_reservation VALUES
(NULL, '丁丁', '13501234561', '1548311700000', '1549011000000', '1'),
(NULL, '当当', '13501234562', '1548311710000', '1549011100000', '1'),
(NULL, '豆豆', '13501234563', '1548311720000', '1549011200000', '2'),
(NULL, '丫丫', '13501234564', '1548311730000', '1549011300000', '2'),
(NULL, '丁丁', '13501234565', '1548311740000', '1549011400000', '3'),
(NULL, '当当', '13501234566', '1548311750000', '1549011500000', '3'),
(NULL, '豆豆', '13501234561', '1548311760000', '1549011600000', '5'),
(NULL, '丫丫', '13501234562', '1548311770000', '1549011700000', '5'),
(NULL, '丁丁', '13501234563', '1548311780000', '1549011800000', '6'),
(NULL, '当当', '13501234564', '1548311790000', '1549011900000', '6'),
(NULL, '豆豆', '13501234565', '1548311800000', '1549011000000', '7'),
(NULL, '丫丫', '13501234566', '1548311810000', '1549011100000', '8'),
(NULL, '豆豆', '13501234567', '1548311820000', '1549011200000', '9'),
(NULL, '丫丫', '13501234561', '1548311840000', '1549011300000', '10'),
(NULL, '丁丁', '13501234562', '1548311850000', '1549011400000', '10'),
(NULL, '当当', '13501234563', '1548311860000', '1549011500000', '11'),
(NULL, '豆豆', '13501234564', '1548311870000', '1549011600000', '11'),
(NULL, '丫丫', '13501234565', '1548311880000', '1549011600000', '12'),
(NULL, '豆豆', '13501234566', '1548311890000', '1549011500000', '13'),
(NULL, '当当', '13501234567', '1548311900000', '1549011300000', '13'),
(NULL, '丫丫', '13501234568', '1548311910000', '1549011200000', '15');


/*菜品类别*/
CREATE TABLE xfn_category(
	cid				INT		PRIMARY KEY AUTO_INCREMENT,
	cname 		VARCHAR(32)
);
INSERT INTO xfn_category VALUES
(1, '肉类'),
(2, '海鲜河鲜'),
(3, '丸滑类'),
(4, '蔬菜豆制品'),
(5, '菌菇类');


/*菜品*/
CREATE TABLE xfn_dish(
	did				INT		PRIMARY KEY AUTO_INCREMENT,
	title 		VARCHAR(32),
	imgUrl		VARCHAR(128),
	price 		DECIMAL(6,2),
	detail		VARCHAR(128),
	categoryId	INT,
	FOREIGN KEY(categoryId) REFERENCES xfn_category(cid) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO xfn_dish VALUES
(1,'招牌虾滑','1.jpg',35,'精选湛江、北海区域出产的南美品种白虾虾仁，配以盐和淀粉等调料制作而成。虾肉含量越高，虾滑口感越纯正。相比纯虾肉，虾滑食用方便、入口爽滑鲜甜Q弹，海底捞独有的定制生产工艺，含肉量虾肉含量93%，出品装盘前手工摔打10次，是火锅中的经典食材。',1);


/*订单*/
CREATE TABLE xfn_order(
	oid				INT		PRIMARY KEY AUTO_INCREMENT,
	startTime BIGINT,
	endTime		BIGINT,
	customerCount 	INT,
	tableId		INT,
	FOREIGN KEY(tableId) REFERENCES xfn_table(tid) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO xfn_order VALUES
(1, '1547800000000', '1547814918000', '2', '1');

/*订单详情*/
CREATE TABLE xfn_order_detail(
	did				INT		PRIMARY KEY AUTO_INCREMENT,
	dishId 		INT,			/*菜品编号*/
	dishCount	INT,			/*份数*/
	customerName 	VARCHAR(32),	/*顾客名称*/
	orderId		INT,			/*订单编号*/
	FOREIGN KEY(dishId) REFERENCES xfn_dish(did) ON DELETE CASCADE ON UPDATE CASCADE, 
	FOREIGN KEY(orderId) REFERENCES xfn_order(oid) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO xfn_order_detail VALUES
(NULL, '1', '2', '丁丁', '1');
