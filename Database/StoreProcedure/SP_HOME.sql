IF OBJECT_ID('SP_HOME') IS NOT NULL
DROP PROCEDURE SP_HOME
GO
CREATE PROCEDURE SP_HOME
(
	@FLAG CHAR
)
AS
BEGIN
	IF @FLAG='S'-----for gridshow
	BEGIN
		SELECT TOP 10  C.[Name], C.[Icon], C.[ID] FROM Category C WITH(NOLOCK) 

		SELECT TOP 10 P.[NAME], Concat('Rs. ', FORMAT(SellPrice,'#,##0.00')) [SellPrice], P.[Icon], P.[ID]
		FROM Products P WITH(NOLOCK)
	END
END