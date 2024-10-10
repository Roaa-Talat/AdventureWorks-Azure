USE gold_db;
GO

CREATE OR ALTER PROC CreateSQLServerlessView_gold @ViewName NVARCHAR(100)
AS
BEGIN
    DECLARE @statement NVARCHAR(MAX);  -- Declare the variable

    SET @statement = N'CREATE OR ALTER VIEW ' + QUOTENAME(LTRIM(RTRIM(@ViewName))) + ' AS
        SELECT *
        FROM 
            OPENROWSET(
                BULK ''https://datalakestoragegen2acc.dfs.core.windows.net/gold/SalesLT/' + LTRIM(RTRIM(@ViewName)) + '/'',
                FORMAT = ''DELTA''
            ) AS [result]';

    PRINT @statement;  -- Print the statement for debugging
    EXEC (@statement); -- Execute the dynamic SQL
END
GO
