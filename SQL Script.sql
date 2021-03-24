/**************************************************************/
/*						Team Sun Tzu						  */
/*					Fall 2020 - Covid Kids					  */
/**************************************************************/
/*
	Logical Database Design preceeds each table createion.
	Data Dictionary is coded via extended properties. Queries are below
	Query Dictionary preceeds each query.

*/


/******************************************************/
/*				Create Database                       */
/*			Great Reviews Technologies Inc            */			--Name changed to protect IP
/*				^Organization Name^					  */
/******************************************************/
	USE Master;

	GO

/******************************************************/
/*				Create Database                       */
/*			Great Reviews Technologies Inc            */
/******************************************************/

	/* DROP DB IF EXISTS FOR development simplicity */
	DROP DATABASE IF EXISTS Sun_Tzu_Final_Proj;
	
	CREATE DATABASE Sun_Tzu_Final_Proj;

	GO

/**************************************************************/
/*					Create Tables in the Database			  */
/**************************************************************/
	USE Sun_Tzu_Final_Proj;

	GO

/*	Create the PRODUCTS table
	schema: PRODUCTS (ProductID, Title, Description, Discontinued, BrandName)
					NOT NULL Title
*/
	
	CREATE TABLE tblProducts
	(	ProductID			INT				IDENTITY	(10001, 1)	PRIMARY KEY,
		Title				VARCHAR(500)	NOT NULL,
		Description			VARCHAR(1000),
		Discontinued		BIT,
		BrandName			VARCHAR(200)
	);
	-- Assign a comments section to the table
	GO  
	EXEC sys.sp_addextendedproperty   
	@name = N'comments',   
	@value = N'All products in database (past and present)',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblProducts';  
	GO  
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'The auto generated ID for each Product',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblProducts',
	@level2type = N'Column', @level2name = 'ProductID';  
	GO 
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Name of the product provided by the seller',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblProducts',
	@level2type = N'Column', @level2name = 'Title';  
	GO 
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Text description of the product provided by the seller',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblProducts',
	@level2type = N'Column', @level2name = 'Description';  
	GO 
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Check for if a product is now discontinued',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblProducts',
	@level2type = N'Column', @level2name = 'Discontinued';  
	GO 
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Brand of the product',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblProducts',
	@level2type = N'Column', @level2name = 'BrandName';  
	GO 

/*	Create the ProductCategories table
    schema: ProductCategories (PK:CatID, SubCat, ParentCategory)
					NOT NULL SubCat
*/

	CREATE TABLE tblProductCategories
	(	CatID				INT				IDENTITY	(20001, 1)	PRIMARY KEY,
		SubCat				VARCHAR(100),
		ParentCategory		VARCHAR(100)    NOT NULL
	);
	-- Assign a comments section to the table
	GO  
	EXEC sys.sp_addextendedproperty   
	@name = N'comments',   
	@value = N'The available categories of each product',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblProductCategories';  
	GO 
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'The auto generated ID for each Catagory',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblProductCategories',
	@level2type = N'Column', @level2name = 'CatID';  
	GO 
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Name of the sub-category',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblProductCategories',
	@level2type = N'Column', @level2name = 'SubCat';  
	GO 
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Parent category for each sub-category',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblProductCategories',
	@level2type = N'Column', @level2name = 'ParentCategory';  
	GO 

/*	Create the Products_ProductCategories table
    schema: Products_ProductCategories (PK:ProductCatID, FK:ProductID, FK:CatID)
					NOT NULL ProductID  REFERENCES   tblProducts,
                    NOT NULL CatID  REFERENCES   tblProductCategories,
					UNIQUE AK:(ProductID, CatID)
*/

	CREATE TABLE tblProducts_ProductCategories
	(	ProductCatID		INT				IDENTITY	(30001, 1)	PRIMARY KEY ,
		ProductID			INT				FOREIGN KEY REFERENCES	tblProducts(ProductID),
		CatID				INT				FOREIGN KEY REFERENCES	tblProductCategories(CatID),
		CONSTRAINT			AK_ProdIDCatID	UNIQUE		(ProductID, CatID)
	);
	-- Assign a comments section to the table
	GO  
	EXEC sys.sp_addextendedproperty   
	@name = N'comments',   
	@value = N'Assoc table of each product and the possible categoies that they fall in.',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblProducts_ProductCategories';  
	GO 
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'The auto generated ID for each assosiated product and catagory pair',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblProducts_ProductCategories',
	@level2type = N'Column', @level2name = 'ProductCatID';  
	GO 
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'The product to be assigend a catagory',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblProducts_ProductCategories',
	@level2type = N'Column', @level2name = 'ProductID';  
	GO 
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Category that a product can be from',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblProducts_ProductCategories',
	@level2type = N'Column', @level2name = 'CatID';  
	GO 

/*	Create the USERS table
	schema: USERS (PK:user_ID, Username, Join_Date, Country)
					Username UNIQUE, NOT NULL
*/
	Create Table tblUsers
	(	user_ID				INT				IDENTITY	(40001, 1)	PRIMARY KEY,
		Username			VARCHAR(16)		UNIQUE		NOT NULL,
		Join_Date			DATE,
		Country				VARCHAR(90)
	);
	-- Assign a comments section to the table
	GO  
	EXEC sys.sp_addextendedproperty   
	@name = N'comments',   
	@value = N'All users with high level location data',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblUsers';  
	GO 
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'The auto generated ID for each user',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblUsers',
	@level2type = N'Column', @level2name = 'user_ID';  
	GO
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Username selected on sign up',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblUsers',
	@level2type = N'Column', @level2name = 'Username';  
	GO
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Date user joined in local date',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblUsers',
	@level2type = N'Column', @level2name = 'Join_Date';  
	GO
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Home country selected by user',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblUsers',
	@level2type = N'Column', @level2name = 'Country';  
	GO

/*	Create the SESSIONS table
	schema: SESSIONS (PK:Session_ID, FK:user_ID, start, length, type, ip_address)
					fk user_ID references USERS
*/

	CREATE TABLE tblSessions
	(	Session_ID			INT				IDENTITY	(50001, 1)	PRIMARY KEY,
	    user_ID				INT				FOREIGN KEY REFERENCES	tblUsers(user_ID),
		start 				DATETIME,
		length				FLOAT,
		type				VARCHAR(50),
		ip_address			VARCHAR(32)
	);
	-- Assign a comments section to the table
	GO  
	EXEC sys.sp_addextendedproperty   
	@name = N'comments',   
	@value = N'All sessions for users and thier exposed IP address',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblSessions';  
	GO 
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'The auto generated ID for each session',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblSessions',
	@level2type = N'Column', @level2name = 'Session_ID';  
	GO 
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'User executing the session',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblSessions',
	@level2type = N'Column', @level2name = 'user_ID';  
	GO 
		EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Start of the session in GMT',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblSessions',
	@level2type = N'Column', @level2name = 'start';  
	GO 
		EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Length of session in seconds',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblSessions',
	@level2type = N'Column', @level2name = 'length';  
	GO 
		EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Type of session',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblSessions',
	@level2type = N'Column', @level2name = 'type';  
	GO 
		EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Session''s exposed IP address',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblSessions',
	@level2type = N'Column', @level2name = 'ip_address';  
	GO 
/*	Create the ACTIONS table
	schema: ACTIONS (PK:ACTION_ID, Action_name, DATETIME, FK:product_id, FK:Session_id)
					fk product_id references PRODUCTS
					fk Session_id references SESSIONS
*/
	Create table tblActions
	(	ACTION_ID			INT				IDENTITY	(60001, 1)	NOT NULL	PRIMARY KEY,
		Action_name			VARCHAR(24),
		Time_stamp			DATETIME,
		ProductID			INT				FOREIGN KEY REFERENCES	tblProducts(ProductID),
		Session_ID			INT				FOREIGN KEY REFERENCES	tblSessions(Session_ID)
	);
	-- Assign a comments section to the table
	GO  
	EXEC sys.sp_addextendedproperty   
	@name = N'comments',   
	@value = N'All the possible Actions that a user can take or do',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblActions';  
	GO 
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'The auto generated ID for each action',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblActions',
	@level2type = N'Column', @level2name = 'ACTION_ID';  
	GO
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'The common name for the action in English',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblActions',
	@level2type = N'Column', @level2name = 'Action_name';  
	GO
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'GMT event time',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblActions',
	@level2type = N'Column', @level2name = 'Time_stamp';  
	GO
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Product page in which the action was taken',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblActions',
	@level2type = N'Column', @level2name = 'ProductID';  
	GO
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Session during which the action was taken',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblActions',
	@level2type = N'Column', @level2name = 'Session_ID';  
	GO

/*	Create the PAST_PURCHASES table
	schema: PAST_PURCHASES (PK:purchase_ID, FK:ProductID, FK:user_ID, purchase_price, purchase_link, date, on_sale)
					fk user_ID references USERS
					purchase_link not null
*/
	CREATE TABLE tblPastPurchases
    (	purchase_ID			INT				IDENTITY	(70001, 1)	PRIMARY KEY,
	    ProductID           INT				FOREIGN KEY REFERENCES	tblProducts(ProductID),
		user_ID				INT				FOREIGN KEY REFERENCES	tblUsers(user_ID),
		purchase_price		FLOAT,
		purchase_link		VARCHAR(1000)	NOT NULL,
		date				DATE,
		on_sale				BIT
	);
	-- Assign a comments section to the table
	GO  
	EXEC sys.sp_addextendedproperty   
	@name = N'comments',   
	@value = N'Record of all previous purchases imported from partner platforms when authorized by users',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblPastPurchases';  
	GO 
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'The auto generated ID for each purchase',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblPastPurchases',
	@level2type = N'Column', @level2name = 'purchase_ID';  
	GO
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Product that was purchased',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblPastPurchases',
	@level2type = N'Column', @level2name = 'ProductID';  
	GO
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'User who purchased',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblPastPurchases',
	@level2type = N'Column', @level2name = 'user_ID';  
	GO
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Price product was purchased for',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblPastPurchases',
	@level2type = N'Column', @level2name = 'purchase_price';  
	GO
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Link to the product provided by the importing platform',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblPastPurchases',
	@level2type = N'Column', @level2name = 'purchase_link';  
	GO
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Date of the purchase',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblPastPurchases',
	@level2type = N'Column', @level2name = 'date';  
	GO
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Check if the item was on sale when purchased',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblPastPurchases',
	@level2type = N'Column', @level2name = 'on_sale';  
	GO

/*	Create the REVIEWS table
	schema: REVIEWS (PK:review_id, FK:purchase_ID, rating, date, edited, review_text)
					fk purchase_id references PAST_PURCHASES
*/
	CREATE TABLE tblReviews
	(	review_ID			INT				IDENTITY	(80001, 1)  PRIMARY KEY,
		purchase_ID			INT				FOREIGN KEY REFERENCES	tblPastPurchases(purchase_ID),
		rating				INT,
		date				DATE,
		edited				BIT,
		review_text			VARCHAR(250)
	);
	-- Assign a comments section to the table
	GO  
	EXEC sys.sp_addextendedproperty   
	@name = N'comments',   
	@value = N'Locally produced reveiws by community users',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblReviews';  
	GO 
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'The auto generated ID for each review',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblReviews',
	@level2type = N'Column', @level2name = 'review_ID';  
	GO
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Purchase connected with the review',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblReviews',
	@level2type = N'Column', @level2name = 'purchase_ID';  
	GO
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Rating assigned by user 1-5 scale',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblReviews',
	@level2type = N'Column', @level2name = 'rating';  
	GO
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Date of the review or when edited',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblReviews',
	@level2type = N'Column', @level2name = 'date';  
	GO
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Check if review was edited',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblReviews',
	@level2type = N'Column', @level2name = 'edited';  
	GO
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Text of the review provided by user',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblReviews',
	@level2type = N'Column', @level2name = 'review_text';  
	GO
	
/*	Create the VENDORS table
	schema: VENDORS (PK:vend_id, vend_name)
					not null vend_name
*/
	CREATE TABLE tblVendors
	(	vend_id				INT				IDENTITY	(90001, 1)	PRIMARY KEY,
		vend_name			VARCHAR(128)	NOT NULL
	);
	-- Assign a comments section to the table
	GO  
	EXEC sys.sp_addextendedproperty   
	@name = N'comments',   
	@value = N'All partner Vendors (past or present)',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblVendors';  
	GO 
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'The auto generated ID for each vendor',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblVendors',
	@level2type = N'Column', @level2name = 'vend_id';  
	GO
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Name of the vendor selling the product',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblVendors',
	@level2type = N'Column', @level2name = 'vend_name';  
	GO

/*	Create the PLATFORMS table
	schema: PLATFORMS (PK:plat_id, plat_name)
					not null plat_name
*/
	CREATE TABLE tblPlatforms
	(	plat_id				INT				IDENTITY	(100001, 1) PRIMARY KEY,
		plat_name			VARCHAR(128)	NOT NULL
	);
	-- Assign a comments section to the table
	GO  
	EXEC sys.sp_addextendedproperty   
	@name = N'comments',   
	@value = N'All partner Platforms (past or present)',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblPlatforms';  
	GO 
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'The auto generated ID for each platform',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblPlatforms',
	@level2type = N'Column', @level2name = 'plat_id';  
	GO
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Name of the platform through which the vendor is selling products',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblPlatforms',
	@level2type = N'Column', @level2name = 'plat_name';  
	GO

/*	Create the OFFERS table
	schema: OFFERS (PK:offer_id, FK:vend_id, FK:plat_id, FK:ProductID, price)
					fk vend_id	references VENDORS
					fk plat_id	references PLATFORMS
					fk ProductID references PRODUCTS
					not null price default 0
*/
	CREATE TABLE tblOffers
	(	offer_id			INT				IDENTITY	(110001, 1) PRIMARY KEY,
		vend_id				INT				FOREIGN KEY REFERENCES	tblVendors(vend_id),
		plat_id				INT				FOREIGN KEY REFERENCES	tblPlatforms(plat_id),
		ProductID			INT				FOREIGN KEY REFERENCES	tblProducts(ProductID),
		price				FLOAT			not null	default		0
	);
	-- Assign a comments section to the table
	GO  
	EXEC sys.sp_addextendedproperty   
	@name = N'comments',   
	@value = N'Current offers as displayed in app',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblOffers';  
	GO
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'The auto generated ID for each offer',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblOffers',
	@level2type = N'Column', @level2name = 'offer_id';  
	GO
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Vendor selling the product offered',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblOffers',
	@level2type = N'Column', @level2name = 'vend_id';  
	GO
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Platform used by the vendor selling the product offered',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblOffers',
	@level2type = N'Column', @level2name = 'plat_id';  
	GO
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Product beeing offered by the combined platform-vendor',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblOffers',
	@level2type = N'Column', @level2name = 'ProductID';  
	GO
	EXEC sys.sp_addextendedproperty   
	@name = N'Data_Desc',   
	@value = N'Offer price for the product',   
	@level0type = N'SCHEMA', @level0name = 'dbo',  
	@level1type = N'TABLE',  @level1name = 'tblOffers',
	@level2type = N'Column', @level2name = 'price';  
	GO

/* xxxxxxxxxxxxxxxxxxxx END OF CREATE AND DEFINE TABLES xxxxxxxxxxxxxxxxxxxx */

/**************************************************************/
/*						Create Indexs						  */
/**************************************************************/

	/*	Create the products_idx index for tblProducts 
		To improve queries for products of specific brands
	*/
	CREATE INDEX products_idx
	ON tblProducts (Title, BrandName);

	/*	Create the sessions_idx index for tblSessions 
		To improve queries for session security checks
	*/
	CREATE INDEX sessions_idx
	ON tblSessions (start, length, ip_address);

	/*	Create the products_idx index for tblReviews 
		To improve queries for review profiles
	*/
	CREATE INDEX reviews_idx
	ON tblReviews (review_ID, purchase_ID);

	GO
/**************************************************************/
/*					Insert DATA in the Tables				  */
/**************************************************************/

--	Insert data into the PRODUCTS table
--	schema: PRODUCTS (ProductID, Title, Description, Discontinued, BrandName)
    INSERT INTO tblProducts VALUES
    ('Rosa Nero Running Shoes', 'The nike air zoom Rosa Nero running shoe has been redesigned to be incredibly snappy, both in appearance and performance.', 0, 'Nike'),
    ('Roomba 675 Robot Vacuum','The patented 3-Stage Cleaning System is specially engineered to loosen, lift, and suction everything from small particles to large debris from carpets and hard floors.', 0, 'iRobot'),
    ('Hand Santizing Wipes','Germs are no longer a threat to your well-being with ProCure''s hand sanitizing wipes!', 1, 'ProCure'),
    ('Tanjun Walking Shoes', 'The Nike® Tanjun SE smooths out the path for an everyday shoe.', 0, 'Nike'),
    ('Intelligent Design Nadia Comforter Set, Full/Queen, Teal', 'The Intelligent Design Nadia Comforter Set turns any bedroom into fun and inviting getaway. This stylish comforter features a grey and white chevron print broken up by white vertical stripes and a solid teal color that pops! Matching sham(s) with a teal flange pairs exceptionally well with the delightful chevron pattern, while two decorating pillows in coordinating colors help complete the look. Completely reversible, the comforter can flip to a solid grey, for a more neutral look. Made from ultra-soft microfiber, this comforter set is machine washable for easy care.', 0, 'Nadia Collection'),
    ('Apple MacBook Air (13-inch Retina Display, 8GB RAM, 256GB SSD Storage)', 'The incredibly thin and light MacBook Air features a brillant Retina display with True Tone Technology.', 0, 'Apple'),
    ('SCHITTS CREEK COMPLETE COLLECTION', NULL , 1, 'DVD'),
    ('Fire 7 tablet (7" display, 16 GB) - Black', 'Engineered and tested by Amazon, Fire 7 is our best-selling tablet—now 2X the storage, faster quad-core processor, hands-free with Alexa, and 2X as durable as the latest iPad mini. Complete tasks, enjoy movies on the go, browse recipes, or ask Alexa for the weather—making your every day easier.', 0, 'Amazon'),
    ('Sportsstuff Big Mable | 1-2 Rider Towable Tube for Boating', 'This next generation Big Mable for 1 to 2 riders has a high backrest and air cushioned side walls to keep you on board Dual tow points allow for 2 completely different riding experiences', 0, 'Sportsstuff'),
    ('SimpleHouseware Bathroom Hanging Shower Head Caddy Organizer, Chrome (26 x 16 x 5.5 inches)', 'SimpleHouseware Bathroom Hanging Shower Head Caddy Organizer, Chrome (26 x 16 x 5.5 inches)', 0, 'Simple Houseware'),
    ('Fossil Gen 5 Carlyle Stainless Steel', 'Operating System: Wear OS by Google Sensors: Optical Heart Rate, Ambient Light, Barometric Altimeter, GPS, Accelerometer, Gyroscope, Microphone, Speaker Processor: Qualcomm Snapdragon Wear 3100 (our fastest yet) What’s in the Box: Smartwatch, USB Charging Cable, Quick Start Guide, Warranty Booklet', 0, 'Fossil'),
    ('Saodimallsu Womens Turtleneck Oversized Sweaters Batwing Long Sleeve Pullover Loose Chunky Knit Jumper', 'Saodimallsu is an international online fashion retailer. All the time, we strive to provide ladies with high standard bikinis, sweaters, dresses, and etc. We believe good clothing has the power to inspire confidence and beauty.', 0, 'Saodimallsu'),
    ('August Smart Lock, 2nd Generation, HomeKit enabled (Silver)', 'Works with Alexa for voice control (hub required, Alexa device and hub sold separately).', 0, 'August Home'),
    ('Monopoly Classic Game', 'The thrill of bankrupting an opponent, but it pays to play nice, because fortunes could change with the roll of the dice.', 0, 'Monopoly'),
    ('Apple iPad Air 2, 64 GB, Space Gray, (Renewed)', 'Put the power of a PC in the palm of your hand with the Apple iPad Air 2 Tablet. With iOS 8 Operating System, Apple A8x processor, and 1.5 GHz processing speeds, this tablet has the power to handle just about any job.', 0, 'Apple'),
	('Neutrogena water resistant sunscreen','Neutrogena Beach Defense Water Resistant Sunscreen Body Lotion with Broad Spectrum SPF 70, Oil-Free and Fast-Absorbing, 6.7 oz', 0, 'Neutrogena'),
	('Tree hut body butter','Tree Hut 24 Hour Intense Hydrating Shea Body Butter Tropical Mango, 7oz, Hydrating Moisturizer with Pure Shea Butter for Nourishing Essential Body Care', 0, 'Tree Hut'),
	('Dress_shoe_10018','Comfotrable shoes to look good in!',0,'Oxford'),
	('Soap_10019','Gets you all clean!',0,'Dial'),
	('Movado_Watch_10020','Time for the civilized!',1,'Movado'),
	('7inch_Tablet_10021','play work and watch all you need',0,'Samsung'),
	('Socks_10022','they work',0,'Hains'),
	('Socks_10023','they work',1,'Fruit of the Loom'),
	('Nail_polish_10024','lasts for days!',1,'Revlon'),
	('Dress_slacks_10025','look good and feel good!',1,'Structure'),
	('Mouse_10026','basic pointer',1,'Logitech'),
	('MacGuyver_Complete_Series_10027','Use what you have while sporting a mullet',0,'Paramount'),
	('Nintendo_game_10028','play with the family',0,'Nintendo'),
	('Bubble_Bath_10029','just clean fun',1,'Neutrogena'),
	('BoardGame_10030','for ages 12 and up',1,'Hasbro'),
	('Playstation_game_10031','Revel in the challenge',0,'Sony'),
	('Mobile_10032','sleepy baby time',0,'Graco'),
	('Rock_Album_10033','Master of Puppets',0,'Megaforce Records'),
	('Nerf_10034','Nothing but Nerf. Hit um with your best shot',0,'Hasbro'),
	('Slip_n_Slide_10035','wahooooooo',0,'Wham-O'),
	('Xbox_game_10036','take the challenge!',1,'Microsoft'),
	('Skin_cream_10037','silky smooth',1,'Neutrogena'),
	('Powercord_10038','premium power cord',0,'Belkin'),
	('Casual_shoe_10039','looks good feel good all day long',1,'Sketcher'),
	('Polo_Shirt_10040','dress for success',1,'Ralph Lauren');




--	Insert data into the PRODUCT_CATEGORIES table
--	schema: ProductCategories (CatID, SubCat, ParentCategory)
	INSERT INTO tblProductCategories VALUES
	('Women','Clothing, Shoes, Jewelry & Watches'),
	('Vacuums','Smart Home'),
    ('Health', 'Beauty, Health & Personal Care'),
    ('Bed & Bath', 'Home, Garden & Pets'),
    ('Computers, Tablets & PC Products', 'Computers'),
    ('Laptops', 'Electronics'),
    ('Movies & TV', 'Movies, Music & Games'),
    ('Water Sports', 'Outdoors'),
    ('Men','Clothing, Shoes, Jewelry & Watches'),
    ('Toys & Games', 'Toys, Kids & Baby'),
	('Beauty', 'Beauty, Health & Personal Care');



--	Insert data into the PRODUCTS_PRODUCT_CATEGORIES table
--	schema: Products_ProductCategories (ProductCatID, ProductID, CatID)
	INSERT INTO tblProducts_ProductCategories VALUES
    (10001, 20001),
    (10002, 20002),
    (10003, 20003),
    (10004, 20001),
    (10005, 20004),
    (10006, 20005),
    (10006, 20006),
    (10007, 20007),
    (10008, 20006),
    (10009, 20008),
    (10010, 20004),
    (10011, 20009),
    (10012, 20001),
    (10013, 20002),
    (10014, 20010),
    (10015, 20005),
	(10016, 20011),
    (10017, 20011),
	(10018,	20009),
	(10019,	20011),
	(10020,	20001),
	(10021,	20005),
	(10022,	20001),
	(10023,	20009),
	(10024,	20011),
	(10025,	20009),
	(10026,	20006),
	(10027,	20007),
	(10028,	20007),
	(10029,	20011),
	(10030,	20007),
	(10031,	20007),
	(10032,	20010),
	(10033,	20007),
	(10034,	20010),
	(10035,	20008),
	(10036,	20007),
	(10037,	20003),
	(10038,	20006),
	(10039,	20009),
	(10040,	20009);



--	Insert data into the USERS table
--	schema: USERS (user_ID, Username, Join_Date, Country)
	INSERT INTO tblUsers VALUES
	('fancyBuyer', '2020-08-15', 'USA'),
	('Buy$tuff', '2020-10-02', 'USA'),
	('DaffyDuck', '2020-09-04', 'Switzerland'),
	('BugsDAHBunny', '2018-01-30', 'Brazil'),
	('itawtithaw', '2019-04-23', 'Botswana'),
	('Grandma', '2015-06-27', 'England'),
	('YosmiteSamDynmit', '2019-05-02','USA'),
	('PorkyAintPorky65', '2020-03-18', 'Japan'),
	('00MarvinFromMars', '2018-06-07', 'Russia'),
	('Roadrunner', '2019-08-10', 'USA'),
	('WylieCoyote', '2019-08-11', 'USA'),
	('ElmurHasAGun374', '2018-12-13', 'South Africa'),
	('Fa5tRat1nAH4t', '2020-02-25', 'Mexico');


--	Insert data into the PAST_PURCHASES table
--	schema: PAST_PURCHASES (purchase_ID,ProductID, user_ID, purchase_price, purchase_link, date, on_sale)
    INSERT INTO tblPastPurchases VALUES														
    (10016, 40001,	6.29,	'https://www.amazon.com/Neutrogena-Resistant-Sunscreen-Spectrum-Fast-Absorbing/dp/B00AEN4QZ8/ref=sr_1_14?crid=1J26FMYUWY287&dchild=1&keywords=sunscreen&qid=1605895958&sprefix=sunscreen%2Caps%2C228&sr=8-14', '2020-11-01', 1),
    (10017, 40002,	7.99,	'https://www.amazon.com/Tree-Hut-Intense-Hydrating-Tropical/dp/B06XW3PD13/ref=sr_1_5?crid=T77TI7WDRX83&dchild=1&keywords=body+butter&qid=1605896135&s=beauty&sprefix=body+butter%2Caps%2C245&sr=1-5' ,'2020-11-05', 0),
	(10003, 40001,	24.39,	'https://www.amazon.com/ProCure-Hand-Sanitizing-Wipes-Canister/dp/B07DRNKN7F', '2020-11-30', 0),
	(10014, 40002,	20.16,	'https://www.amazon.com/Hasbro-Gaming-C1009-Monopoly-Classic/dp/B01MU9K3XU', '2020-11-12', 0),
	(10002, 40001,	179.00, 'https://www.amazon.com/iRobot-Roomba-675-Connectivity-Carpets/dp/B07DL4QY5V/ref=sr_1_3?dchild=1&keywords=Roomba+675+Robot+Vacuum%27&qid=1606943883&sr=8-3', '2020-11-22', 0),
	(10002, 40002,	179.00, 'https://www.amazon.com/iRobot-Roomba-675-Connectivity-Carpets/dp/B07DL4QY5V/ref=sr_1_3?dchild=1&keywords=Roomba+675+Robot+Vacuum%27&qid=1606943883&sr=8-3', '2020-11-24', 0),
	(10003, 40003,	24.39,	'https://www.amazon.com/ProCure-Hand-Sanitizing-Wipes-Canister/dp/B07DRNKN7F', '2020-11-28', 0),
	(10026,	40006,	1125.55,'https://www.amazon.com/product_10026.html','2020-11-17',0),
	(10035,	40012,	993.55,	'https://www.amazon.com/product_10035.html','2020-08-27',1),
	(10022,	40008,	263.55,	'https://www.amazon.com/product_10022.html','2020-09-05',1),
	(10025,	40004,	543.27,	'https://www.amazon.com/product_10025.html','2020-09-28',0),
	(10029,	40007,	1006.55,'https://www.amazon.com/product_10029.html','2020-11-02',1),
	(10035,	40010,	53.27,	'https://www.amazon.com/product_10035.html','2020-11-16',1),
	(10026,	40011,	455.13,	'https://www.amazon.com/product_10026.html','2020-11-14',0),
	(10030,	40011,	1100.55,'https://www.amazon.com/product_10030.html','2020-09-10',1),
	(10023,	40010,	382.13,	'https://www.amazon.com/product_10023.html','2020-09-20',0),
	(10038,	40010,	811.13,	'https://www.amazon.com/product_10038.html','2020-10-20',1),
	(10029,	40008,	253.13,	'https://www.amazon.com/product_10029.html','2020-10-28',0),
	(10024,	40008,	598.27,	'https://www.amazon.com/product_10024.html','2020-11-12',0),
	(10027,	40002,	1187.88,'https://www.amazon.com/product_10027.html','2020-09-09',1),
	(10040,	40010,	226.55,	'https://www.amazon.com/product_10040.html','2020-12-02',0),
	(10040,	40008,	723.88,	'https://www.amazon.com/product_10040.html','2020-09-04',1),
	(10022,	40007,	158.27,	'https://www.amazon.com/product_10022.html','2020-11-12',1),
	(10036,	40009,	6.55,	'https://www.amazon.com/product_10036.html','2020-10-17',1),
	(10022,	40003,	323.88,	'https://www.amazon.com/product_10022.html','2020-09-28',1),
	(10027,	40006,	1138.88,'https://www.amazon.com/product_10027.html','2020-09-22',0),
	(10031,	40006,	41.27,	'https://www.amazon.com/product_10031.html','2020-09-23',0),
	(10030,	40002,	1193.27,'https://www.amazon.com/product_10030.html','2020-10-07',0),
	(10019,	40010,	369.27,	'https://www.amazon.com/product_10019.html','2020-11-07',1),
	(10026,	40004,	200.88,	'https://www.amazon.com/product_10026.html','2020-09-21',0);


--	Insert data into the REVIEWS table
--	schema: REVIEWS (review_id, purchase_ID, rating, date, edited, review_text)
    INSERT INTO tblReviews VALUES
    (70001, 5,	'2020-11-29', 0, 'the best sunscreen I have ever used'),
	(70003, 5,	'2020-12-01', 0, 'keeps the germophobic in me sane!'),
	(70002, 4,	'2020-11-20', 1, 'I used this once and have not looked for a different body butter since then....'),
	(70004, 5,	'2020-11-20', 0, 'buying this as gift, mine is alreayd worn out  - best for saturday afternoons!'),
	(70026,	1,	'2020-09-30', 1, 'I love Mac! All he needs is Ducktape and a swiss army knife!'),
	(70030,	4,	'2020-11-24', 1, 'This mouse is cheap, but it works well enough!'),
	(70016,	4,	'2020-11-07', 0, 'These are comfy socks! and they last long.'),
	(70017,	3,	'2020-11-20', 1, 'This thing broke after 1 week. dont recommend!'),
	(70015,	1,	'2020-09-17', 0, 'Be careful, you will end up playing for hours!'),
	(70005,	1,	'2020-11-30', 1, 'Saves an hour every day!'),
	(70020,	5,	'2020-10-01', 0, 'BRING BACK THE MULLET! MULLET! MULLET!'),
	(70011,	3,	'2020-10-15', 1, 'Pretty cheap, good for 1 or 2 uses, aftger they they frey up :(');


--	Insert data into the SESSIONS table
--	schema: SESSIONS (Session_ID, user_ID, start, length, type, ip_address) length in tenths of a second
	INSERT INTO tblSessions VALUES
	(40001, '2020-11-19 01:09:46.297' , 125.15, 'type1', '125.232.78.77'),
	(40002, '2020-11-19 07:53:02.394' , 657.42, 'type2', '192.60.58.163'),
	(40003, NULL , NULL, NULL, NULL),
	(40004, '2020-11-22 08:25:03.254' , 221.51, 'type2', '112.87.24.197'),
	(40005, '2020-11-22 06:41:35.547' , 242.11, 'type1', '173.58.108.235'),
	(40006, '2020-11-24 08:02:22.254' , 351.29, 'type2', '78.169.168.20'),
	(40007, '2020-11-25 19:52:19.254' , 196.15, 'type1', '172.125.16.196'),
	(40008, '2020-11-25 14:22:35.547' , 265.38, 'type1', '181.58.108.235'),
	(40009, NULL, NULL, NULL, NULL),
	(40013,	'2020-12-14 17:30:00.000' ,	42.07,	'type1', '189.159.25.111'),
	(40001,	'2020-11-20 01:09:45.435' ,	124.23,	'type2', '72.232.78.21');



--	Insert data into the ACTIONS table
--	schema: ACTIONS (ACTION_ID, Action_name, DATETIME, productID, Session_id)
	INSERT INTO tblActions Values
	('View_Product', '2020-11-19 01:09:46.297', 10001, 50001),
	('View_Product', '2020-11-19 01:09:46.297', 10002, 50001),
	('like_review', '2020-11-19 01:09:46.297', 10002, 50001),
	('Buy_product', '2020-11-19 01:09:46.297', 10002, 50001),
	('View_Product', '2020-11-19 01:09:46.297', 10003, 50001),
	('like_review', '2020-11-19 01:09:46.297', 10003, 50001),
	('View_Product', '2020-11-19 01:09:46.297', 10004, 50001),
	('View_Product', '2020-11-19 01:09:46.297', 10005, 50001),
	('View_Product', '2020-11-19 01:09:46.297', 10006, 50001),
	('Buy_product', '2020-11-19 01:09:46.297', 10006, 50001),
    ('View_Product', '2020-11-19 01:09:46.297', 10003, 50002),
	('View_Review', '2020-11-19 01:09:46.297', 10003, 50002),
	('Dislike_review', '2020-11-19 01:09:46.297', 10003, 50002),
	('View_Product', '2020-11-19 01:09:46.297', 10002, 50007),
	('View_Product', '2020-11-19 01:09:46.297', 10007, 50004),
	('Buy_product', '2020-11-19 01:09:46.297', 10007, 50004),
	('View_Product', '2020-11-19 01:09:46.297', 10004, 50005),
	('View_Review', '2020-11-19 01:09:46.297', 10004, 50005),
	('View_Product', '2020-11-19 01:09:46.297', 10006, 50006),
	('Buy_product', '2020-11-19 01:09:46.297', 10006, 50006);

--	Insert data into the VENDORS table
--	schema: VENDORS (vend_id, vend_name)
	INSERT INTO tblVendors VALUES
	('Vendor_1'),
	('Vendor_2'),
	('Vendor_3'),
	('Vendor_4'),
	('Vendor_5'),
	('Vendor_6'),
	('Vendor_7');


--	Insert data into the PLATFORMS table
--	schema: PLATFORMS (plat_id,plat_name)
	INSERT INTO tblPlatforms VALUES
	('Platform_1'),
	('Platform_2'),
	('Platform_3'),
	('Platform_4'),
	('Platform_5'),
	('Platform_6');



--	Insert data into the OFFERS table
--	schema: OFFERS (offer_id, vend_id, plat_id, ProductID, price) price in USD
	INSERT INTO tblOffers VALUES
	(90001, 100001, 10001, 29.99),
	(90002, 100001, 10002, 9.98),
	(90001, 100002, 10004, 17.58),
	(90002, 100001, 10001, 13.76),
	(90002, 100001, 10002, 10.76),
	(90002, 100002, 10003, 83.76),
	(90001, 100002, 10004, 63.62),
	(90003,	100002,	10022, 170.55),
	(90002,	100001,	10019, 365.00),
	(90004,	100001,	10033, 190.88),
	(90005,	100001,	10014, 19.99),
	(90003,	100001,	10031, 45.27),
	(90002,	100002,	10013, 150.99),
	(90004,	100001,	10029, 750.00),
	(90005,	100001,	10021, 8.99),
	(90003,	100002,	10014, 19.99),
	(90001,	100001,	10005, 0.99),
	(90001,	100001,	10018, 789.99),
	(90005,	100001,	10017, 7.99),
	(90005,	100002,	10002, 179.00),
	(90005,	100002,	10015, 259.88),
	(90002,	100001,	10009, 643.21),
	(90001,	100002,	10040, 555.55),
	(90001,	100002,	10033, 1100.01),
	(90005,	100001,	10008, 189.99),
	(90001,	100002,	10006, 324.12),
	(90003,	100001,	10010, 999.99),
	(90001,	100002,	10035, 990.00),
	(90005,	100002,	10016, 6.29),
	(90005,	100002,	10034, 221.13),
	(90001,	100001,	10032, 753.25),
	(90001,	100001,	10010, 188.48),
	(90005,	100002,	10027, 1150.00),
	(90004,	100002,	10021, 8.98),
	(90002,	100002,	10028, 201.68),
	(90004,	100002,	10001, 29.99),
	(90002,	100001,	10011, 423.98),
	(90001,	100001,	10022, 169.99),
	(90001,	100001,	10008, 189.99),
	(90005,	100001,	10021, 8.99),
	(90001,	100002,	10013, 1023.32),
	(90004,	100001,	10027, 1100.00),
	(90004,	100001,	10012, 89.99),
	(90004,	100002,	10038, 799.99);

/* xxxxxxxxxxxxxxxxxxxx END OF ADD VALUES xxxxxxxxxxxxxxxxxxxx */

	GO


/****************************************************************/
/*						Begin Data Dictionary					*/
/****************************************************************/

/********************************************************/
/*			List of all tables with a description		*/
/********************************************************/
	select schema_name(tab.schema_id) as schema_name,
		tab.name as table_name, 
		tab.create_date as created,  
		tab.modify_date as last_modified, 
		p.rows as num_rows,
		ep.value as comments 
	from sys.tables tab
		inner join (select distinct 
							p.object_id,
							sum(p.rows) rows
						from sys.tables t
							inner join sys.partitions p 
								on p.object_id = t.object_id 
					group by p.object_id,
							p.index_id) p
			on p.object_id = tab.object_id
		left join sys.extended_properties ep 
			on tab.object_id = ep.major_id
			and ep.name = 'comments'
			and ep.minor_id = 0
			and ep.class_desc = 'OBJECT_OR_COLUMN'
	order by schema_name,
		table_name;

	GO
/********************************************************/
/*	List of all columns by table with a description		*/
/********************************************************/
	select
	   SCHEMA_NAME(tbl.schema_id) AS SchemaName,	
	   tbl.name AS table_name, 
	   clmns.name AS column_name,
	   p.name AS ExtendedPropertyName,
	   CAST(p.value AS sql_variant) AS Data_Description
	from
	   sys.tables AS tbl
	   INNER JOIN sys.all_columns AS clmns ON clmns.object_id=tbl.object_id
	   INNER JOIN sys.extended_properties AS p ON p.major_id=tbl.object_id AND p.minor_id=clmns.column_id AND p.class=1;
	GO
/********************************************************/
/*		List of all columns with data type				*/
/********************************************************/
	select TABLE_NAME,
			COLUMN_NAME,
			DATA_TYPE,
			IS_NULLABLE
	from information_schema.columns
	order by TABLE_NAME;

/* xxxxxxxxxxxxxxxxxxxx END OF DATA DICTIONARY xxxxxxxxxxxxxxxxxxxx */
	GO


/********************************************************/
/*			List of all values in each tables			*/
/********************************************************/

	SELECT * FROM tblProducts;
	SELECT * FROM tblProductCategories;
	SELECT * FROM tblProducts_ProductCategories;
	SELECT * FROM tblUsers;
	SELECT * FROM tblSessions;
	SELECT * FROM tblActions;
	SELECT * FROM tblPastPurchases;
	SELECT * FROM tblReviews;
	SELECT * FROM tblVendors;
	SELECT * FROM tblPlatforms;
	SELECT * FROM tblOffers;

	

/**************************************************************/
/*		QUERIES FOR BUSINESS SCENARIOS & QUESTIONS			  */
/**************************************************************/ 
--	Structure of question, why query is below

/*	
	Question:

--	Why
*/
--	SQL QUERY
-------------------------------------------------------------------------------------------

/**************************************************************/
/*				Start of Questions and Queries				  */
/**************************************************************/
/*

	Business Question 1: What is the average length of user sessions? 

--	This is a standard metric that is tracked to understand the performance 
	of the app. Generally the product teams would want this to be along 
	the lines of the industry standard average session length

	Addresses Business req a & e
*/


	SELECT AVG(length) Avg_Session_length 
	FROM tblSessions;
-------------------------------------------------------------------------------------------

/*
	Business Question 2: Who are the top three users in terms of the number of reviews?  

--	This question helps the business understand the top users and can be used for 
	targeted marketing to make sure they don't lose the top users

	Addresses Business req d
*/


	SELECT TOP 3 u.Username, COUNT(review_ID) as Num_Reviews
	FROM tblReviews r JOIN tblPastPurchases p ON r.purchase_ID = p.purchase_ID
	JOIN tblUsers u ON p.user_ID = u.user_ID
	GROUP BY u.Username;
-------------------------------------------------------------------------------------------

/*  
	Business Question 3: How many days after making a purchase do the users  
    post a review about it? Does this change by category?                    

--	This question helps the business understand how many days after purchase 
    users post a review about the products. This would help them understand 
	user behaviour and plan a targeted marketing activity, like sending 
	notifications for prompting users to post reviews

	Addresses Business req c & d
*/
	
	SELECT pp.user_ID, DATEDIFF(day, pp.date, r.date) Review_After_days, c.SubCat, c.ParentCategory
	FROM tblReviews r JOIN tblPastPurchases pp ON r.purchase_ID = pp.purchase_ID
	JOIN tblProducts p ON pp.ProductID = p.ProductID
    JOIN tblProducts_ProductCategories pc ON p.ProductID = pc.ProductID
	JOIN tblProductCategories c ON pc.CatID = c.CatID
	ORDER BY c.SubCat, Review_After_days ;
 
-------------------------------------------------------------------------------------------

/*
	Business Question 4: How many users have more than 2 purchases through our app?

--	Users with more than 2 purchases are considered loyal customers.
	Display all loyal customers.

	Addresses Business req b
*/

	SELECT *
	FROM tblUsers OuterQuery
	JOIN ( SELECT InnerQuery.user_ID, COUNT(InnerQuery.user_ID) as count_purchases
		   FROM tblPastPurchases InnerQuery
		   GROUP BY InnerQuery.user_ID) LoyalCustomers
    ON LoyalCustomers.user_ID = OuterQuery.user_ID
    WHERE LoyalCustomers.count_purchases > 2;
-------------------------------------------------------------------------------------------
	
/*
	Business Question 5: How many times were products purchased from all partner platforms?

--	This question helps rank the most popular previously purchased 
	(via platform import) products to reinforce to users.

	Addresses Business req b & d
*/

	SELECT DISTINCT p.Title AS Product_Name, COUNT(pr.ProductID) OVER (PARTITION BY pr.ProductID) AS Purchase_Count
	FROM tblProducts p
	JOIN tblPastPurchases pr ON p.ProductID = pr.ProductID
	ORDER BY Purchase_Count DESC;
-------------------------------------------------------------------------------------------	
	
/*
	Business Question 6:  What is the average rating for each product in the Beauty category?

--	This question helps display popular products in a specific catagory.
	
	Addresses Business req c
*/
​
	SELECT p.ProductID, AVG(rating) 'Average Rating' FROM tblReviews r
	JOIN tblPastPurchases p ON r.purchase_ID=p.purchase_ID
	JOIN tblProducts_ProductCategories pc ON p.ProductID=pc.ProductID
	JOIN tblProductCategories c ON pc.CatID=c.CatID
	WHERE SubCat = 'Beauty'
	GROUP BY p.ProductID;
-------------------------------------------------------------------------------------------

/*	
	Business Question 7:  Where are most users from?

--	This question can help marketing see where they are effective and where
	growth regions may be to do geo targeting.

	Addresses Business req e
*/
​
	SELECT Country, COUNT(Country) 'Number of Users' FROM tblUsers
	GROUP BY Country
	ORDER BY 'Number of Users' DESC;
-------------------------------------------------------------------------------------------

/*
	Business Question 8:  Which users are using VPNs or connecting from outside home country?

--	This question helps with compliance in legal situations that may differ from 
	Country to Country. This can also be used verify users and flag possible 
	account sign-ins for location mismatch.

	Addresses Business req e
*/
​
	SELECT u.user_ID, u.Country, s.ip_address FROM tblUsers u
	JOIN tblsessions s on u.user_ID = s.user_ID;
-------------------------------------------------------------------------------------------

/*
	Business Question 9:	Which product category has the highest average reviews? 

--	This question identifies the catagories that are currently being review most. 
	This  will aid in suggestions for future product reviews.

	Addresses Business req c & d
*/


	SELECT TOP 1 c.CatID, c.SubCat, AVG(rating) 'Average Rating'
	FROM tblReviews r
	JOIN tblPastPurchases p ON r.purchase_ID=p.purchase_ID
	JOIN tblProducts_ProductCategories pc ON p.ProductID=pc.ProductID
	JOIN tblProductCategories c ON pc.CatID=c.CatID
	GROUP BY c.CatID, c.SubCat
	ORDER BY 'Average Rating' DESC;
-------------------------------------------------------------------------------------------​

/*
	Business Question 10: How many products has a given customer reviewed?

--	This question will populate the number of reviews next to the user in their profile

	Addresses Business req d
*/

	SELECT u.Username, COUNT(p.ProductID) as Num_Reviews
	FROM tblReviews r
	JOIN tblPastPurchases p ON r.purchase_ID=p.purchase_ID
	JOIN tblUsers u ON p.user_ID=u.user_ID
	WHERE u.Username = 'fancyBuyer'
	Group by u.Username;
-------------------------------------------------------------------------------------------
/*
	Business Question 11: What is the percentage of discontinued Products?

--	This question will identify how up to date the past purchases table is and assit 
	in identifying when to purge old data stores.

	Addresses Business req a
*/

	SELECT (
	(SELECT COUNT(*) FROM tblProducts WHERE Discontinued  = 1) / (SELECT cast (COUNT(*) as float )From tblProducts)
			) as Discontinued_Products_Pct;

/*
	Business Question 12: What is the Buy to View percentage?

--	This is a key performance identifier of buy rate.
	
	Addresses Business req b
*/
	SELECT (
	(SELECT COUNT(*) FROM tblActions WHERE Action_name = 'Buy_product') / (SELECT cast(COUNT(*)as float) 
	From tblActions WHERE Action_name = 'View_product')
			) *100 as Buy_Conversion_rate;

/* xxxxxxxxxxxxxxxxxxxx END OF QUERIES xxxxxxxxxxxxxxxxxxxx */