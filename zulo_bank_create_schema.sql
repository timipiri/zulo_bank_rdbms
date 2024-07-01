CREATE SCHEMA IF NOT EXISTS zulobankdb;
DROP TABLE IF EXISTS zulobankdb.transaction CASCADE;
DROP TABLE IF EXISTS zulobankdb.accounts CASCADE;
DROP TABLE IF EXISTS zulobankdb.customers CASCADE;
DROP TABLE IF EXISTS zulobankdb.date_dim CASCADE;
DROP TABLE IF EXISTS zulobankdb.loans CASCADE;
DROP TABLE IF EXISTS zulobankdb.zulo_fact_table CASCADE;
                            
CREATE TABLE IF NOT EXISTS zulobankdb.date_dim (
		date_id SERIAL PRIMARY KEY,
        date VARCHAR(255),
        Year INTEGER,
        Month INTEGER,
        Day INTEGER
);
                            
CREATE TABLE IF NOT EXISTS zulobankdb.transactions (
		transaction_id SERIAL PRIMARY KEY,
        TransactionType VARCHAR(255),
        Amount FLOAT,
        TransactionDate_ID INTEGER,
        FOREIGN KEY (TransactionDate_ID) REFERENCES zulobankdb.date_dim(date_id)
);
                            
CREATE TABLE IF NOT EXISTS zulobankdb.accounts (
		account_id SERIAL PRIMARY KEY,
        AccountType VARCHAR(255),
        Balance FLOAT,
        OpeningDate_ID INTEGER,
        FOREIGN KEY (OpeningDate_ID) REFERENCES zulobankdb.date_dim(date_id)
);
                            
CREATE TABLE IF NOT EXISTS zulobankdb.loans (
		loan_id SERIAL PRIMARY KEY,
        LoanAmount FLOAT,
        LoanType VARCHAR(255),
        StartDate_ID INTEGER,
        EndDate_ID INTEGER,
        InterestRate FLOAT,
        FOREIGN KEY (StartDate_ID) REFERENCES zulobankdb.date_dim(date_id),
        FOREIGN KEY (EndDate_ID) REFERENCES zulobankdb.date_dim(date_id)
);
                            
CREATE TABLE IF NOT EXISTS zulobankdb.customers (
		customer_id SERIAL PRIMARY KEY,
        first_name varchar(255),
        last_name VARCHAR(255),
        Email VARCHAR(255),
        Phone VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS zulobankdb.zulo_fact_table (
		customer_id INTEGER,
        account_id INTEGER,
        transaction_id INTEGER,
        loan_id INTEGER,
        FOREIGN KEY (customer_id) REFERENCES zulobankdb.customers(customer_id),
        FOREIGN KEY (account_id) REFERENCES zulobankdb.accounts(account_id),
        FOREIGN KEY (transaction_id) REFERENCES zulobankdb.transactions(transaction_id),
        FOREIGN KEY (loan_id) REFERENCES zulobankdb.loans(loan_id)
);