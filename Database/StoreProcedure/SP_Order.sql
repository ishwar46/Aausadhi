IF OBJECT_ID('SP_Order') IS NOT NULL
DROP PROCEDURE SP_Order
GO
CREATE PROCEDURE SP_Order
(
	@FLAG CHAR,
	@UserID NVARCHAR(1000)=NULL
)
AS
BEGIN
	DECLARE @MSG NVARCHAR(MAX)
	IF @FLAG='I'----FOR SAVE	
	BEGIN
	BEGIN TRY
	BEGIN TRAN
		DECLARE @ProductID Table(ID INT)
		IF EXISTS (
			SELECT '' FROM CartItems CI WITH(NOLOCK)
			JOIN Users U WITH(NOLOCK) ON CI.CartId=U.UserName
			WHERE U.ID=@UserID
		)
		BEGIN
			;WITH CTE AS(
				SELECT Quantity, ProductId, P.SellPrice, CAST(P.SellPrice * Quantity AS DECIMAL(18, 2)) Total 
				FROM CartItems CI WITH(NOLOCK)
				JOIN Users U WITH(NOLOCK) ON CI.CartId=U.UserName
				JOIN Products P WITH(NOLOCK) ON P.ID=CI.ProductId
				WHERE U.ID=@UserID
			), TOTAL AS(
				SELECT SUM(Total) TOTAL FROM CTE
			)
			INSERT INTO Orders(UserID, PaidMethod, Total, Tax, Discount, DeliveryCharge, GrandTotal, StatusID, OrderedDate, IsPaid, PaidDate, DeliveryDate)
			Output inserted.ID into @ProductID
			SELECT @UserID, NULL, (SELECT TOTAL FROM TOTAL), CAST(0.13 * (SELECT TOTAL FROM TOTAL) AS DECIMAL(18, 2)), 0, 0, 
				(SELECT TOTAL FROM TOTAL) + CAST(0.13 * (SELECT TOTAL FROM TOTAL) AS DECIMAL(18, 2)), 1, GETDATE(), 0, null, null

			INSERT INTO OrderDetails(OrderID, ProductID, Quantity, Rate, Discount, Total)
			SELECT (SELECT TOP 1 ID FROM @ProductID),ProductId, Quantity, P.SellPrice, 0, CAST(P.SellPrice * Quantity AS DECIMAL(18, 2)) Total 
			FROM CartItems CI WITH(NOLOCK)
			JOIN Users U WITH(NOLOCK) ON CI.CartId=U.UserName
			JOIN Products P WITH(NOLOCK) ON P.ID=CI.ProductId
			WHERE U.ID=@UserID
		END
	COMMIT TRAN
	SELECT  'ORDER PLACED SUCCESSFULLY.' MSG
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN 
		SET @MSG= CONCAT('Log Line: ', CAST(SCOPE_IDENTITY() AS NVARCHAR(10)), ', Error Line: ' , CAST(ERROR_LINE() AS NVARCHAR(10)), ', MSG: ', ERROR_MESSAGE())
		;THROW 51002, @MSG, 1;
		RETURN
	END CATCH
	END
END
