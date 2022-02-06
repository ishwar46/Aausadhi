IF OBJECT_ID('SP_PRODUCTS') IS NOT NULL
DROP PROCEDURE SP_PRODUCTS
GO
CREATE PROCEDURE SP_PRODUCTS
(
	@FLAG CHAR,
	@ProductName NVARCHAR(1000)=NULL,
	@CategoryID NVARCHAR(1000)=NULL
)
AS
BEGIN
	IF @FLAG='S'-----for gridshow
	BEGIN
		SELECT  P.[NAME], Concat('Rs. ', FORMAT(SellPrice,'#,##0.00')) [SellPrice], P.[Icon], P.[ID]
		FROM Products P WITH(NOLOCK)
		WHERE 1= CASE 
					WHEN ISNULL(@ProductName, '')='' THEN 1
					WHEN P.Name LIKE '%'+@ProductName + '%' THEN 1
					ELSE 0
				END
			AND  1= CASE 
					WHEN ISNULL(@CategoryID, '')='' THEN 1
					WHEN P.CategoryID = @CategoryID THEN 1
					ELSE 0
				END
	END
END