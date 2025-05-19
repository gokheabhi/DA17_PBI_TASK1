CREATE TABLE TECHM (
    Date VARCHAR(50),                          -- Store date in standard date format
    series VARCHAR(50),
    OPEN NUMERIC(10, 2),
    HIGH NUMERIC(10, 2),
    LOW NUMERIC(10, 2),
    PREV_CLOSE NUMERIC(10, 2),
    ltp NUMERIC(10, 2),
    close NUMERIC(10, 2),
    vwap NUMERIC(10, 2),
    "52W_H" NUMERIC(10, 2),
    "52W_L" NUMERIC(10, 2),
    VOLUME INTEGER,
    VALUE NUMERIC(15, 2),
    "No_of_trades" INTEGER
);

select * from techm

call add_and_update_stock_name('techm')

CREATE OR REPLACE PROCEDURE add_and_update_stock_name(table_name VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Dynamically add the column 'stock_name' if it doesn't exist
    BEGIN
        EXECUTE format('ALTER TABLE %I ADD COLUMN stock_name VARCHAR(50)', table_name);
    EXCEPTION
        WHEN duplicate_column THEN
            -- Do nothing if the column already exists
            NULL;
    END;

    -- Dynamically update the 'stock_name' column where it is NULL
    EXECUTE format('UPDATE %I SET stock_name = ''%s'' WHERE stock_name IS NULL', table_name, table_name);
END;
$$;