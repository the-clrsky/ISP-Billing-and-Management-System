-- Create Tables --
--- Customers
CREATE TABLE customers (
cust_id NUMBER(10) CONSTRAINT customer_id_pk PRIMARY KEY,
cust_first_name VARCHAR2(100),
cust_last_name VARCHAR2(100),
cust_address VARCHAR2(100),
cust_phone VARCHAR2(100),
cust_email VARCHAR2(100),
deposit_amount NUMBER(10),
cust_start_date DATE);

--- Package_Master
CREATE TABLE package_master (
pkg_id NUMBER(10) CONSTRAINT package_id_pk PRIMARY KEY,
pkg_name VARCHAR2(100),
pkg_price NUMBER(10),
pkg_speed VARCHAR2(100),
pkg_type VARCHAR2(100));

--- Package_Details
CREATE TABLE package_details (
pkg_dtls_id NUMBER(10) CONSTRAINT package_details_id_pk PRIMARY KEY,
net_cost NUMBER(10),
service_charge NUMBER(10),
line_charge NUMBER(10),
peak_hour_start VARCHAR2(10),
peak_hour_end VARCHAR2(10),
off_peak_hour_start VARCHAR2(10),
off_peak_hour_end VARCHAR2(10),
connection_type VARCHAR2(100));

--- Offer_Master
CREATE TABLE offer_master (
offer_id NUMBER(10) CONSTRAINT offer_id_pk PRIMARY KEY,
offer_name VARCHAR2(100));

--- Offer_Details
CREATE TABLE offer_details (
offer_dtls_id NUMBER(10) CONSTRAINT offer_details_id_pk PRIMARY KEY,
conditions VARCHAR2(100),
validity_start DATE,
validity_stop DATE,
amount NUMBER(10));

--- Area_Master
CREATE TABLE area_master (
area_id NUMBER(10) CONSTRAINT area_id_pk PRIMARY KEY,
area_name VARCHAR2(100));

--- Area_Details
CREATE TABLE area_details (
area_dtls_id NUMBER(10) CONSTRAINT area_details_id_pk PRIMARY KEY,
division VARCHAR2(100),
city VARCHAR2(100),
city_corporation VARCHAR2(100),
thana VARCHAR2(100));

--- Pop
CREATE TABLE pop (
pop_id NUMBER(10) CONSTRAINT pop_id_pk PRIMARY KEY,
pop_name VARCHAR2(100),
pop_address VARCHAR2(100));

--- Payment_Master
CREATE TABLE payment_master (
payment_id NUMBER(10) CONSTRAINT payment_id_pk PRIMARY KEY,
payment_date DATE,
payment_amount NUMBER(10));

--- Payment_Details
CREATE TABLE payment_details (
payment_dtls_id NUMBER(10) CONSTRAINT payment_details_id_pk PRIMARY KEY,
payment_method VARCHAR2(100),
payment_processor VARCHAR2(100),
trx_id VARCHAR2(30),
service_charge NUMBER(10),
vat NUMBER(10));

--- Invoice
CREATE TABLE invoice (
invoice_id NUMBER(10) CONSTRAINT invoice_id_pk PRIMARY KEY,
cust_first_name VARCHAR2(100),
cust_last_name VARCHAR2(100),
total NUMBER(10),
invoice_date DATE,
billing_month VARCHAR2(100),
billing_month2 VARCHAR2(100),
billing_year VARCHAR2(100),
due_date DATE,
status VARCHAR2(100));

--- Usage
CREATE TABLE usage (
usage_id NUMBER(10) CONSTRAINT usage_id_pk PRIMARY KEY,
duration_start DATE,
duration_end DATE,
data_upload NUMBER(10),
data_download NUMBER(10));

--- Employees
CREATE TABLE employees (
emp_id NUMBER(10) CONSTRAINT employee_id_pk PRIMARY KEY,
emp_first_name VARCHAR2(100),
emp_last_name VARCHAR2(100),
emp_phone VARCHAR2(100),
emp_email VARCHAR2(100),
emp_address VARCHAR2(100),
job_title VARCHAR2(100),
hire_date DATE,
salary NUMBER(10));

--- Departments
CREATE TABLE departments (
dept_id NUMBER(10) CONSTRAINT department_id_pk PRIMARY KEY,
dept_name VARCHAR2(100),
manager_id NUMBER(10) CONSTRAINT manager_id_uk UNIQUE);

--- Users
CREATE TABLE users (
user_id NUMBER(10) CONSTRAINT user_id_pk PRIMARY KEY,
user_name VARCHAR2(100),
password VARCHAR2(100),
role VARCHAR2(100));

--- Support
CREATE TABLE support (
ticket_id NUMBER(10) CONSTRAINT support_ticket_id_pk PRIMARY KEY,
create_timestamp DATE,
end_timestamp DATE,
complaint VARCHAR2 (100),
ticket_status VARCHAR(100));

--- Maintenance
CREATE TABLE maintenance (
maint_id NUMBER(10) CONSTRAINT maintenance_id_pk PRIMARY KEY,
cost NUMBER(10),
create_timestamp DATE,
end_timestamp DATE,
status VARCHAR2(100));

--- Equipments
CREATE TABLE equipments (
eqpt_id NUMBER(10) CONSTRAINT equipment_id_pk PRIMARY KEY,
eqpt_type VARCHAR2(100),
eqpt_model VARCHAR2(100),
purchase_date DATE,
installation_date DATE,
status VARCHAR2(100),
comments VARCHAR2(100));

--- Extra_Services
CREATE TABLE extra_services (
ext_id NUMBER(10) CONSTRAINT ext_id_pk PRIMARY KEY,
service_name VARCHAR2(100),
service_type VARCHAR2(100),
service_price VARCHAR2(100));

--- Expense_Master
CREATE TABLE expense_master(
expense_id NUMBER(10) CONSTRAINT expense_id_pk PRIMARY KEY,
expense_Date DATE,
Total_Amount NUMBER(10,2));

--- Expense_Details
CREATE TABLE expense_details(
expense_id NUMBER,
expense_dtls_id NUMBER(10) CONSTRAINT expense_dtls_id_pk PRIMARY KEY,
emp_id NUMBER,
emp_name VARCHAR2(100),
Item_Name VARCHAR2(100),
Quantity NUMBER,
Unit_Type VARCHAR2(10),
Unit_Price NUMBER,
Subtotal NUMBER);

commit;

------ Add Foreign Key References ------
--- Customers
ALTER TABLE customers ADD (
pkg_id NUMBER(10),
area_id NUMBER(10),
pop_id NUMBER(10),
ext_id NUMBER(10),
cust_type VARCHAR2(100),
cust_status VARCHAR2(10),
CONSTRAINT cust_pkg_id_fk FOREIGN KEY (pkg_id) REFERENCES package_master(pkg_id),
CONSTRAINT cust_area_id_fk FOREIGN KEY (area_id) REFERENCES area_master(area_id),
CONSTRAINT cust_pop_id_fk FOREIGN KEY (pop_id) REFERENCES pop(pop_id),
CONSTRAINT cust_ext_id_fk FOREIGN KEY (ext_id) REFERENCES extra_services(ext_id));

--- Package_Details
ALTER TABLE package_details ADD (
pkg_id NUMBER(10),
CONSTRAINT pkg_d_pkg_id_fk FOREIGN KEY (pkg_id) REFERENCES package_master(pkg_id));

--- Offer_Details
ALTER TABLE offer_details ADD (
area_id NUMBER(10),
offer_id NUMBER(10),
CONSTRAINT offer_d_area_id_fk FOREIGN KEY (area_id) REFERENCES area_master(area_id),
CONSTRAINT offer_d_offer_id_fk FOREIGN KEY (offer_id) REFERENCES offer_master(offer_id));

--- Area_Master
ALTER TABLE area_master ADD (
area_manager_id NUMBER(10),
CONSTRAINT area_d_area_manager_id FOREIGN KEY (area_manager_id) REFERENCES employees(emp_id));

--- Area_Details
ALTER TABLE area_details ADD (
area_id NUMBER(10),
CONSTRAINT area_d_area_id FOREIGN KEY (area_id) REFERENCES area_master(area_id));

--- Pop
ALTER TABLE pop ADD (
area_id NUMBER(10),
pop_manager_id NUMBER(10),
line_tech_id NUMBER(10),
network_eng_id NUMBER(10),
CONSTRAINT pop_area_id_fk FOREIGN KEY (area_id) REFERENCES area_master(area_id),
CONSTRAINT pop_pop_manager_id_fk FOREIGN KEY (pop_manager_id) REFERENCES employees(emp_id),
CONSTRAINT pop_line_tech_id_fk FOREIGN KEY (line_tech_id) REFERENCES employees(emp_id),
CONSTRAINT pop_network_eng_id_fk FOREIGN KEY (network_eng_id) REFERENCES employees(emp_id));

--- Payment_Master
ALTER TABLE payment_master
ADD (invoice_id NUMBER(10),
CONSTRAINT payment_m_invoice_id_fk FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id));

--- Payment_Details
ALTER TABLE payment_details ADD (
payment_id NUMBER(10),
CONSTRAINT payment_d_payment_id FOREIGN KEY (payment_id) REFERENCES payment_master(payment_id));

--- Usage
ALTER TABLE usage ADD (
cust_id NUMBER(10),
CONSTRAINT usage_cust_id_fk FOREIGN KEY (cust_id) REFERENCES customers(cust_id));

--- Invoice
ALTER TABLE invoice ADD (
cust_id NUMBER(10),
pkg_id NUMBER(10),
offer_id NUMBER(10),
area_id NUMBER(10),
pop_id NUMBER(10),
ext_id NUMBER(10),
usage_id NUMBER(10),
payment_id NUMBER(10),
CONSTRAINT invoice_cust_id_fk FOREIGN KEY (cust_id) REFERENCES customers(cust_id),
CONSTRAINT invoice_pkg_id_fk FOREIGN KEY (pkg_id) REFERENCES package_master(pkg_id),
CONSTRAINT invoice_offer_id_fk FOREIGN KEY (offer_id) REFERENCES offer_master(offer_id),
CONSTRAINT invoice_area_id_fk FOREIGN KEY (area_id) REFERENCES area_master(area_id),
CONSTRAINT invoice_pop_id_fk FOREIGN KEY (pop_id) REFERENCES pop(pop_id),
CONSTRAINT invoice_usage_id_fk FOREIGN KEY (usage_id) REFERENCES usage(usage_id),
CONSTRAINT invoice_ext_id_fk FOREIGN KEY (ext_id) REFERENCES extra_services(ext_id));

--- Employees
ALTER TABLE employees ADD (
dept_id NUMBER(10),
manager_id NUMBER(10),
CONSTRAINT employees_dept_id__fk FOREIGN KEY (dept_id) REFERENCES departments(dept_id),
CONSTRAINT employees_manager_id_fk FOREIGN KEY (manager_id) REFERENCES employees(emp_id));

--- Departments
ALTER TABLE departments ADD (
CONSTRAINT departments_manager_id_fk FOREIGN KEY (manager_id) REFERENCES employees(emp_id));

--- Users
ALTER TABLE users ADD (
emp_id NUMBER(10),
CONSTRAINT users_emp_id_fk FOREIGN KEY (emp_id) REFERENCES employees(emp_id));

--- Support
ALTER TABLE support ADD (
cust_id NUMBER(10),
csr_id NUMBER(10),
CONSTRAINT support_cust_id_fk FOREIGN KEY (cust_id) REFERENCES customers(cust_id),
CONSTRAINT support_csr_id_fk FOREIGN KEY (csr_id) REFERENCES employees(emp_id));

--- Equipments
ALTER TABLE equipments ADD (
area_id NUMBER(10),
pop_id NUMBER(10),
CONSTRAINT equipments_area_id_fk FOREIGN KEY (area_id) REFERENCES area_master(area_id),
CONSTRAINT equipments_pop_id_fk FOREIGN KEY (pop_id) REFERENCES pop(pop_id));

--- Maintenance
ALTER TABLE maintenance ADD (
ticket_id NUMBER(10),
network_eng_id NUMBER(10),
line_tech_id NUMBER(10),
eqpt_id NUMBER(10),
CONSTRAINT maintenance_ticket_id_fk FOREIGN KEY (ticket_id) REFERENCES support(ticket_id),
CONSTRAINT maintenance_network_eng_id_fk FOREIGN KEY (network_eng_id) REFERENCES employees(emp_id),
CONSTRAINT maintenance_line_tech_id_fk FOREIGN KEY (line_tech_id) REFERENCES employees(emp_id),
CONSTRAINT maintenance_eqpt_id_fk FOREIGN KEY (eqpt_id) REFERENCES equipments(eqpt_id));

--- Expense_Details
ALTER TABLE expense_details ADD(
CONSTRAINT expense_id_fk FOREIGN KEY (expense_id) REFERENCES expense_master(expense_id),
CONSTRAINT emp_id_fk FOREIGN KEY (emp_id) REFERENCES employees(emp_id));

COMMIT;

------ Sequences ------
--- Customer ID
CREATE SEQUENCE cust_id_seq
START WITH 1000
INCREMENT BY 1
MAXVALUE 99999
NOCACHE
NOCYCLE;

--- Package Details ID
CREATE SEQUENCE pkg_dtls_id_seq
START WITH 20000
INCREMENT BY 10
MAXVALUE 99999
NOCACHE
NOCYCLE;

--- Package ID
CREATE SEQUENCE pkg_id_seq
START WITH 200
INCREMENT BY 1
MAXVALUE 999
NOCACHE
NOCYCLE;

--- Offer Details ID
CREATE SEQUENCE ofr_dtls_id_seq
START WITH 30000
INCREMENT BY 10
MAXVALUE 99999
NOCACHE
NOCYCLE;

--- Offer ID
CREATE SEQUENCE ofr_id_seq
START WITH 300
INCREMENT BY 1
MAXVALUE 999
NOCACHE
NOCYCLE;

--- Area Details ID
CREATE SEQUENCE area_dtls_id_seq
START WITH 4000
INCREMENT BY 100
MAXVALUE 9999
NOCACHE
NOCYCLE;

--- Area ID
CREATE SEQUENCE area_id_seq
START WITH 400
INCREMENT BY 1
MAXVALUE 999
NOCACHE
NOCYCLE;

--- Pop ID
CREATE SEQUENCE pop_id_seq
START WITH 40000
INCREMENT BY 10
MAXVALUE 99999
NOCACHE
NOCYCLE;

--- Payment Details ID
CREATE SEQUENCE payment_dtls_id_seq
START WITH 50000
INCREMENT BY 1
MAXVALUE 99999
NOCACHE
NOCYCLE;

--- Payment ID
CREATE SEQUENCE payment_id_seq
START WITH 500000
INCREMENT BY 1
MAXVALUE 999999
NOCACHE
NOCYCLE;

--- Invoice ID
CREATE SEQUENCE invoice_id_seq
START WITH 60000
INCREMENT BY 1
MAXVALUE 999999
NOCACHE
NOCYCLE;

--- Employee ID
CREATE SEQUENCE emp_id_seq
START WITH 100
INCREMENT BY 1
MAXVALUE 9999
NOCACHE
NOCYCLE;

--- Department ID
CREATE SEQUENCE dept_id_seq
START WITH 10
INCREMENT BY 10
MAXVALUE 999
NOCACHE
NOCYCLE;

--- User ID
CREATE SEQUENCE user_id_seq
START WITH 10000
INCREMENT BY 10
MAXVALUE 99999
NOCACHE
NOCYCLE;

--- Ticket ID
CREATE SEQUENCE ticket_id_seq
START WITH 70000
INCREMENT BY 10
MAXVALUE 99999
NOCACHE
NOCYCLE;

--- Maintenance ID
CREATE SEQUENCE maint_id_seq
START WITH 80000
INCREMENT BY 10
MAXVALUE 99999
NOCACHE
NOCYCLE;

--- Equipment ID
CREATE SEQUENCE eqpt_id_seq
START WITH 90000
INCREMENT BY 10
MAXVALUE 99999
NOCACHE
NOCYCLE;

--- Usage ID
CREATE SEQUENCE usage_id_seq
START WITH 1000
INCREMENT BY 1
MAXVALUE 9999999
NOCACHE
NOCYCLE;

--- Extra_Services
CREATE SEQUENCE extra_services_seq
START WITH 1000
INCREMENT BY 10
MAXVALUE 9999999
NOCACHE
NOCYCLE;

--- Expense_ID
CREATE SEQUENCE expense_id_seq
START WITH 1000
INCREMENT BY 10
MAXVALUE 9999999
NOCACHE
NOCYCLE;

--- Expense_Dtls_ID
CREATE SEQUENCE expense_dtls_id_seq
START WITH 1000
INCREMENT BY 10
MAXVALUE 9999999
NOCACHE
NOCYCLE;

COMMIT;

--- Triggers

-- Invoice ID
CREATE OR REPLACE TRIGGER generate_invoice_id
BEFORE INSERT ON INVOICE
FOR EACH ROW
BEGIN
    IF :NEW.invoice_id IS NULL THEN
        SELECT INVOICE_ID_SEQ.NEXTVAL INTO :NEW.invoice_id FROM dual;
    END IF;
END;
/

-- Payment Details ID
CREATE OR REPLACE TRIGGER generate_pkg_dtls_id
BEFORE INSERT ON package_details
FOR EACH ROW
BEGIN
    IF :NEW.pkg_dtls_id IS NULL THEN
        SELECT pkg_dtls_id_seq.NEXTVAL INTO :NEW.pkg_dtls_id FROM dual;
    END IF;
END;
/

-- Area Details ID
CREATE OR REPLACE TRIGGER generate_area_dtls_id
BEFORE INSERT ON area_details
FOR EACH ROW
BEGIN
    IF :NEW.area_dtls_id IS NULL THEN
        SELECT area_dtls_id_seq.NEXTVAL INTO :NEW.area_dtls_id FROM dual;
    END IF;
END;
/

-- Offer Details ID
CREATE OR REPLACE TRIGGER generate_offer_dtls_id
BEFORE INSERT ON offer_details
FOR EACH ROW
BEGIN
    IF :NEW.offer_dtls_id IS NULL THEN
        SELECT ofr_dtls_id_seq.NEXTVAL INTO :NEW.offer_dtls_id FROM dual;
    END IF;
END;
/

-- Payment Details ID
CREATE OR REPLACE TRIGGER generate_payment_dtls_id
BEFORE INSERT ON payment_details
FOR EACH ROW
BEGIN
    IF :NEW.PAYMENT_DTLS_ID IS NULL THEN
        SELECT payment_dtls_id_seq.NEXTVAL INTO :NEW.PAYMENT_DTLS_ID FROM dual;
    END IF;
END;
/

-- Expense_Details_ID
CREATE OR REPLACE TRIGGER generate_expense_dtls_id
BEFORE INSERT ON expense_details
FOR EACH ROW
BEGIN
    IF :NEW.expense_dtls_id IS NULL THEN
        SELECT expense_dtls_id_seq.NEXTVAL INTO :NEW.expense_dtls_id FROM dual;
    END IF;
END;
/

COMMIT;

-- Views


-- Unpaid Invoices

CREATE OR REPLACE VIEW UNPAID_INVOICES AS
    SELECT INVOICE_ID,
           CUST_ID,
           CUST_FIRST_NAME,
           CUST_LAST_NAME,
           PKG_ID,
           INVOICE_DATE,
           BILLING_MONTH,
           BILLING_YEAR,
           DUE_DATE,
           TOTAL,
           STATUS
      FROM invoice
     WHERE STATUS = 'Unpaid';
/

-- Inactive Customers

CREATE OR REPLACE VIEW INACTIVE_CUSTOMERS AS
    SELECT CUST_ID,
           CUST_FIRST_NAME || ' ' || CUST_LAST_NAME     NAME,
           CUST_PHONE,
           PKG_ID,
           AREA_ID,
           POP_ID,
           EXT_ID,
           CUST_TYPE
      FROM customers
     WHERE CUST_STATUS = 'Inactive';
/

-- Open Tickets

CREATE OR REPLACE VIEW OPEN_TICKETS AS
    SELECT TICKET_ID,
           CUST_ID,
           CSR_ID,
           CREATE_TIMESTAMP,
           END_TIMESTAMP,
           COMPLAINT,
           TICKET_STATUS
      FROM support
     WHERE TICKET_STATUS = 'Open';
/

-- Active Maintenances

CREATE OR REPLACE VIEW ACTIVE_MAINTENANCES AS
    SELECT MAINT_ID,
           TICKET_ID,
           EQPT_ID,
           NETWORK_ENG_ID,
           LINE_TECH_ID,
           CREATE_TIMESTAMP,
           END_TIMESTAMP,
           COST,
           STATUS
      FROM maintenance
     WHERE STATUS = 'In Progress';
/

-- Day old Support Tickets

CREATE OR REPLACE VIEW DAY_OLD_TICKETS AS
SELECT s.TICKET_ID, s.CSR_ID, e.EMP_FIRST_NAME, s.COMPLAINT
FROM support s JOIN employees e
ON s.CSR_ID = e.EMP_ID
WHERE TICKET_STATUS = 'Open'
AND CREATE_TIMESTAMP < SYSDATE - INTERVAL '1' DAY;
/

COMMIT;

------ Input Demo Data ------

--- Package_Master
INSERT INTO package_master
VALUES (pkg_id_seq.NEXTVAL, 'Bronze', 600, '25 Mbps', 'Home');

INSERT INTO package_master
VALUES (pkg_id_seq.NEXTVAL, 'Silver', 800, '35 Mbps', 'Home');

INSERT INTO package_master
VALUES (pkg_id_seq.NEXTVAL, 'Gold', 1000, '50 Mbps', 'Home');

INSERT INTO package_master
VALUES (pkg_id_seq.NEXTVAL, 'Diamond', 1200, '70 Mbps', 'Home');

INSERT INTO package_master
VALUES (pkg_id_seq.NEXTVAL, 'Platinum', 1500, '100 Mbps', 'Home');

INSERT INTO package_master
VALUES (pkg_id_seq.NEXTVAL, 'SME Cloud', 1500, '50 Mbps', 'Corporate');

INSERT INTO package_master
VALUES (pkg_id_seq.NEXTVAL, 'SME Sky', 2500, '85 Mbps', 'Corporate');

INSERT INTO package_master
VALUES (pkg_id_seq.NEXTVAL, 'SME Star', 3000, '120 Mbps', 'Corporate');

INSERT INTO package_master
VALUES (pkg_id_seq.NEXTVAL, 'Business Silver', 3500, '150 Mbps', 'Corporate');

INSERT INTO package_master
VALUES (pkg_id_seq.NEXTVAL, 'Business Gold', 4000, '200 Mbps', 'Corporate');

commit;

--- Package_Details
INSERT INTO  package_details
VALUES (pkg_dtls_id_seq.NEXTVAL, 300, 100, 1000, '8:00 PM', '1:59 AM', '2:00 AM', '7:59 PM', 'Shared', 200);

INSERT INTO  package_details
VALUES (pkg_dtls_id_seq.NEXTVAL, 500, 100, 1000, '8:00 PM', '1:59 AM', '2:00 AM', '7:59 PM', 'Shared', 201);

INSERT INTO  package_details
VALUES (pkg_dtls_id_seq.NEXTVAL, 600, 100, 1000, '8:00 PM', '1:59 AM', '2:00 AM', '7:59 PM', 'Shared', 202);

INSERT INTO  package_details
VALUES (pkg_dtls_id_seq.NEXTVAL, 700, 100, 1000, '8:00 PM', '1:59 AM', '2:00 AM', '7:59 PM', 'Shared', 203);

INSERT INTO  package_details
VALUES (pkg_dtls_id_seq.NEXTVAL, 800, 100, 1000, '8:00 PM', '1:59 AM', '2:00 AM', '7:59 PM', 'Shared', 204);

INSERT INTO  package_details
VALUES (pkg_dtls_id_seq.NEXTVAL, 1000, 100, 1000, null, null, null, null, 'Dedicated', 205);

INSERT INTO  package_details
VALUES (pkg_dtls_id_seq.NEXTVAL, 2000, 100, 1000, null, null, null, null, 'Dedicated', 206);

INSERT INTO  package_details
VALUES (pkg_dtls_id_seq.NEXTVAL, 2500, 100, 1000, null, null, null, null, 'Dedicated', 207);

INSERT INTO  package_details
VALUES (pkg_dtls_id_seq.NEXTVAL, 3000, 100, 1000, null, null, null, null, 'Dedicated', 208);

INSERT INTO  package_details
VALUES (pkg_dtls_id_seq.NEXTVAL, 3500, 100, 1000, null, null, null, null, 'Dedicated', 209);

commit;

--- Departments
INSERT INTO departments
VALUES (dept_id_seq.NEXTVAL, 'Administration', null);

INSERT INTO departments
VALUES (dept_id_seq.NEXTVAL, 'Marketing', null);

INSERT INTO departments
VALUES (dept_id_seq.NEXTVAL, 'Purchasing', null);

INSERT INTO departments
VALUES (dept_id_seq.NEXTVAL, 'Network Engineering', null);

INSERT INTO departments
VALUES (dept_id_seq.NEXTVAL, 'Customer Service', null);

INSERT INTO departments
VALUES (dept_id_seq.NEXTVAL, 'Location Management', null);

INSERT INTO departments
VALUES (dept_id_seq.NEXTVAL, 'Field Operation', null);

INSERT INTO departments
VALUES (dept_id_seq.NEXTVAL, 'Accounting', null);

commit;

--- Employees
INSERT INTO employees
VALUES (emp_id_seq.NEXTVAL, 'Jawed', 'Karim', '01719255000', 'jawed@bdisp.com', '500/1 Monipur, Mirpur', 'President', '20/May/2023', 55000, 10, null);

INSERT INTO employees
VALUES (emp_id_seq.NEXTVAL, 'Jamal', 'Islam', '01719255002', 'jamal@bdisp.com', '50/1 Monipur, Mirpur', 'Marketing Manager', '22/Jun/2023', 45000, 20, null);

INSERT INTO employees
VALUES (emp_id_seq.NEXTVAL, 'Serajul', 'Choudhury', '01719255004', 'serajul@bdisp.com', '23/4 Monipur - 1', 'Purchase Manager', '20/Aug/2023', 35000, 30, null);

INSERT INTO employees
VALUES (emp_id_seq.NEXTVAL, 'Salman', 'Khan', '01719255005', 'salman@bdisp.com', '511 Monipur, Mirpur', 'Network Manager', '21/Jul/2023', 40000, 40, null);

INSERT INTO employees
VALUES (emp_id_seq.NEXTVAL, 'Nasima', 'Akhter', '01719255008', 'nasima@bdisp.com', '856 Monipur, Mirpur', 'Customer Service Manager', '20/Jul/2023', 35000, 50, null);

INSERT INTO employees
VALUES (emp_id_seq.NEXTVAL, 'Sayed', 'Khokhon', '01719255012', 'sayed@bdisp.com', '44 West Kafrul', 'Location Manager', '28/Jun/2023', 45000, 60, null);

INSERT INTO employees
VALUES (emp_id_seq.NEXTVAL, 'Partha', 'Majumder', '01719255017', 'partha@bdisp.com', '191/4 Shewrapara', 'Field Manager', '20/Sep/2023', 35000, 70, null);

INSERT INTO employees
VALUES (emp_id_seq.NEXTVAL, 'Ayub', 'Bachchu', '01719255022', 'ayub@bdisp.com', '10/A Senpara', 'Sr. Accountant', '4/Jan/2024', 35000, 80, null);

commit;

INSERT INTO employees
VALUES (emp_id_seq.NEXTVAL, 'Fazlur', 'Rahman', '01719255001', 'fazlur@bdisp.com', '526 Monipur, Mirpur', 'Administration Assistant', '22/Jun/2023', 40000, 10, 100);

INSERT INTO employees
VALUES (emp_id_seq.NEXTVAL, 'Omar', 'Ishrak', '01719255003', 'omar@bdisp.com', '254 Monipur, Mirpur', 'Marketing Analyst', '26/Aug/2023', 35000, 20, 101);

INSERT INTO employees
VALUES (emp_id_seq.NEXTVAL, 'Abul', 'Kashem', '01719255006', 'abul@bdisp.com', '756 Monipur, Mirpur', 'Network Engineer', '24/Aug/2023', 40000, 40, 103);

INSERT INTO employees
VALUES (emp_id_seq.NEXTVAL, 'Jamilur', 'Reza', '01719255007', 'jamilur@bdisp.com', '552 Monipur, Mirpur', 'Network Engineer', '25/Aug/2023', 30000, 40, 103);

INSERT INTO employees
VALUES (emp_id_seq.NEXTVAL, 'Arun', 'Kumar', '01719255009', 'arun@bdisp.com', '921 Monipur, Mirpur', 'Customer Service Representative', '26/Jul/2023', 30000, 50, 104);

INSERT INTO employees
VALUES (emp_id_seq.NEXTVAL, 'Chitta', 'Ranjan', '01719255010', 'chitta@bdisp.com', '52 Mirpur 11', 'Customer Service Representative', '22/Jul/2023', 30000, 50, 104);

INSERT INTO employees
VALUES (emp_id_seq.NEXTVAL, 'Sikdar', 'Haq', '01719255011', 'sikdar@bdisp.com', '426/1 East Monipur', 'Customer Service Representative', '22/Jul/2023', 30000, 50, 104);

INSERT INTO employees
VALUES (emp_id_seq.NEXTVAL, 'Rafi', 'Hasan', '01719255013', 'rafi@bdisp.com', '46 West Kafrul', 'Area Manager', '28/Jun/2023', 40000, 60, 105);

INSERT INTO employees
VALUES (emp_id_seq.NEXTVAL, 'Jahanara', 'Imam', '01719255014', 'jahanara@bdisp.com', '89 South Monipur', 'Area Manager', '28/Jun/2023', 40000, 60, 105);

INSERT INTO employees
VALUES (emp_id_seq.NEXTVAL, 'Firoz', 'Mahmud', '01719255015', 'firoz@bdisp.com', '12/5 Kazipara', 'POP Manager', '11/Jul/2023', 30000, 60, 105);

INSERT INTO employees
VALUES (emp_id_seq.NEXTVAL, 'Ghulam', 'Murshid', '01719255016', 'ghulam@bdisp.com', '17/4 Kazipara', 'POP Manager', '20/Jul/2023', 30000, 60, 105);

INSERT INTO employees
VALUES (emp_id_seq.NEXTVAL, 'Raja', 'Chanda', '01719255018', 'raja@bdisp.com', '196 Pallabi', 'Line Technician', '27/Sep/2023', 30000, 70, 106);

INSERT INTO employees
VALUES (emp_id_seq.NEXTVAL, 'Tareque', 'Masud', '01719255019', 'tareque@bdisp.com', '38/2 Senpara', 'Line Technician', '27/Sep/2023', 30000, 70, 106);

INSERT INTO employees
VALUES (emp_id_seq.NEXTVAL, 'Kaushik', 'Taposh', '01719255020', 'kaushik@bdisp.com', '45/2 Senpara', 'Line Technician', '27/Sep/2023', 30000, 70, 106);

INSERT INTO employees
VALUES (emp_id_seq.NEXTVAL, 'Zahid', 'Hasan', '01719255021', 'zahid@bdisp.com', '8/2 Senpara', 'Line Technician', '02/Jan/2024', 30000, 70, 106);

commit;

--- Add Manager ID to Departments Table
UPDATE departments
SET manager_id = 100
WHERE dept_id = 10;

UPDATE departments
SET manager_id = 101
WHERE dept_id = 20;

UPDATE departments
SET manager_id = 102
WHERE dept_id = 30;

UPDATE departments
SET manager_id = 103
WHERE dept_id = 40;

UPDATE departments
SET manager_id = 104
WHERE dept_id = 50;

UPDATE departments
SET manager_id = 105
WHERE dept_id = 60;

UPDATE departments
SET manager_id = 106
WHERE dept_id = 70;

commit;

--- Area_Master
INSERT INTO area_master
VALUES (area_id_seq.NEXTVAL, 'Mirpur Model',
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Rafi'));

INSERT INTO area_master
VALUES (area_id_seq.NEXTVAL, 'Pallabi',
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Rafi'));

INSERT INTO area_master
VALUES (area_id_seq.NEXTVAL, 'Darussalam',
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Rafi'));

INSERT INTO area_master
VALUES (area_id_seq.NEXTVAL, 'Mohammadpur',
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Rafi'));

INSERT INTO area_master
VALUES (area_id_seq.NEXTVAL, 'Sher-E-Bangla Nagar',
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Rafi'));

INSERT INTO area_master
VALUES (area_id_seq.NEXTVAL, 'Rupnagar',
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Jahanara'));

INSERT INTO area_master
VALUES (area_id_seq.NEXTVAL, 'Shah Ali',
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Jahanara'));

INSERT INTO area_master
VALUES (area_id_seq.NEXTVAL, 'Kafrul',
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Jahanara'));

INSERT INTO area_master
VALUES (area_id_seq.NEXTVAL, 'Kalabagan',
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Jahanara'));

INSERT INTO area_master
VALUES (area_id_seq.NEXTVAL, 'Dhanmondi',
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Jahanara'));

commit;

--- Area_Details
INSERT INTO area_details
VALUES (area_dtls_id_seq.NEXTVAL, 'Dhaka', 'Dhaka', 'Dhaka North', 'Mirpur Model', 400);

INSERT INTO area_details
VALUES (area_dtls_id_seq.NEXTVAL, 'Dhaka', 'Dhaka', 'Dhaka North', 'Pallabi', 401);

INSERT INTO area_details
VALUES (area_dtls_id_seq.NEXTVAL, 'Dhaka', 'Dhaka', 'Dhaka North', 'Darussalam', 402);

INSERT INTO area_details
VALUES (area_dtls_id_seq.NEXTVAL, 'Dhaka', 'Dhaka', 'Dhaka North', 'Mohammadpur', 403);

INSERT INTO area_details
VALUES (area_dtls_id_seq.NEXTVAL, 'Dhaka', 'Dhaka', 'Dhaka North', 'Sher-E-Bangla Nagar', 404);

INSERT INTO area_details
VALUES (area_dtls_id_seq.NEXTVAL, 'Dhaka', 'Dhaka', 'Dhaka North', 'Rupnagar', 405);

INSERT INTO area_details
VALUES (area_dtls_id_seq.NEXTVAL, 'Dhaka', 'Dhaka', 'Dhaka North', 'Shah Ali', 406);

INSERT INTO area_details
VALUES (area_dtls_id_seq.NEXTVAL, 'Dhaka', 'Dhaka', 'Dhaka North', 'Kafrul', 407);

INSERT INTO area_details
VALUES (area_dtls_id_seq.NEXTVAL, 'Dhaka', 'Dhaka', 'Dhaka South', 'Kalabagan', 408);

INSERT INTO area_details
VALUES (area_dtls_id_seq.NEXTVAL, 'Dhaka', 'Dhaka', 'Dhaka South', 'Dhanmondi', 409);

commit;

--- pop
INSERT INTO pop
VALUES (pop_id_seq.NEXTVAL, 'Mirpur - 2', '24/1, Barek Mollar Mor',
(SELECT area_id FROM area_master WHERE area_name LIKE 'Mirpur Model'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Firoz'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Raja'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Abul'));

INSERT INTO pop
VALUES (pop_id_seq.NEXTVAL, 'Shewrapara', '422/1, East Shewrapara',
(SELECT area_id FROM area_master WHERE area_name LIKE 'Mirpur Model'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Firoz'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Raja'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Abul'));

INSERT INTO pop
VALUES (pop_id_seq.NEXTVAL, 'Mirpur - 10', '45/2, Mirpur 10',
(SELECT area_id FROM area_master WHERE area_name LIKE 'Shah Ali'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Firoz'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Tareque'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Abul'));

INSERT INTO pop
VALUES (pop_id_seq.NEXTVAL, 'Pallabi', '25/B, Pallabi',
(SELECT area_id FROM area_master WHERE area_name LIKE 'Pallabi'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Firoz'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Tareque'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Abul'));

INSERT INTO pop
VALUES (pop_id_seq.NEXTVAL, 'Rupnagar', '27/1, Mirpur - 14',
(SELECT area_id FROM area_master WHERE area_name LIKE 'Rupnagar'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Firoz'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Tareque'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Abul'));

INSERT INTO pop
VALUES (pop_id_seq.NEXTVAL, 'Bijoy Sarani', '45, Bijoy Sarani',
(SELECT area_id FROM area_master WHERE area_name LIKE 'Sher-E-Bangla Nagar'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Firoz'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Kaushik'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Abul'));

INSERT INTO pop
VALUES (pop_id_seq.NEXTVAL, 'Khamar Bari', '251, Khamar Bari',
(SELECT area_id FROM area_master WHERE area_name LIKE 'Sher-E-Bangla Nagar'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Ghulam'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Kaushik'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Jamilur'));

INSERT INTO pop
VALUES (pop_id_seq.NEXTVAL, 'Kalabagan', '42/1, Kalabagan Mor',
(SELECT area_id FROM area_master WHERE area_name LIKE 'Kalabagan'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Ghulam'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Kaushik'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Jamilur'));

INSERT INTO pop
VALUES (pop_id_seq.NEXTVAL, 'Darussalam', '26/B, Darussalam Mor',
(SELECT area_id FROM area_master WHERE area_name LIKE 'Darussalam'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Ghulam'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Zahid'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Abul'));

INSERT INTO pop
VALUES (pop_id_seq.NEXTVAL, 'Mohammadpur', 'Mohammadpur R/A, Road 1',
(SELECT area_id FROM area_master WHERE area_name LIKE 'Mohammadpur'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Firoz'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Tareque'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Jamilur'));

INSERT INTO pop
VALUES (pop_id_seq.NEXTVAL, 'Dhanmondi', 'Dhanmondi 27 Mor',
(SELECT area_id FROM area_master WHERE area_name LIKE 'Dhanmondi'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Ghulam'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Zahid'),
(SELECT emp_id FROM employees WHERE emp_first_name LIKE 'Raja'));

commit;

--- Offer_Master
INSERT INTO offer_master
VALUES (ofr_id_seq.NEXTVAL, 'No Connection Charge');

INSERT INTO offer_master
VALUES (ofr_id_seq.NEXTVAL, 'One Month Free');

commit;

--- Offer_Details
INSERT INTO offer_details
VALUES (ofr_dtls_id_seq.NEXTVAL, 'New User', '01/Jan/2024', '31/Dec/2024', 1000, 400, 300);

INSERT INTO offer_details
VALUES (ofr_dtls_id_seq.NEXTVAL, 'New User', '01/Jan/2024', '31/Dec/2024', 1000, 401, 300);

INSERT INTO offer_details
VALUES (ofr_dtls_id_seq.NEXTVAL, 'New User', '01/Jan/2024', '31/Dec/2024', 1000, 402, 300);

INSERT INTO offer_details
VALUES (ofr_dtls_id_seq.NEXTVAL, 'New User', '01/Jan/2024', '31/Dec/2024', 1000, 403, 300);

INSERT INTO offer_details
VALUES (ofr_dtls_id_seq.NEXTVAL, 'New User', '01/Jan/2024', '31/Dec/2024', 1000, 404, 300);

INSERT INTO offer_details
VALUES (ofr_dtls_id_seq.NEXTVAL, 'New User', '01/Jan/2024', '31/Dec/2024', 1000, 405, 300);

INSERT INTO offer_details
VALUES (ofr_dtls_id_seq.NEXTVAL, 'New User', '01/Jan/2024', '31/Dec/2024', 1000, 406, 300);

INSERT INTO offer_details
VALUES (ofr_dtls_id_seq.NEXTVAL, 'New User', '01/Jan/2024', '31/Dec/2024', 1000, 408, 300);

INSERT INTO offer_details
VALUES (ofr_dtls_id_seq.NEXTVAL, 'New User', '01/Jan/2024', '31/Dec/2024', 1000, 409, 300);

INSERT INTO offer_details
VALUES (ofr_dtls_id_seq.NEXTVAL, 'One Month Free for 3 Months Advance Bill', '01/Jan/2024', '31/Dec/2024', null, 400, 301);

INSERT INTO offer_details
VALUES (ofr_dtls_id_seq.NEXTVAL, 'One Month Free for 3 Months Advance Bill', '01/Jan/2024', '31/Dec/2024', null, 401, 301);

INSERT INTO offer_details
VALUES (ofr_dtls_id_seq.NEXTVAL, 'One Month Free for 3 Months Advance Bill', '01/Jan/2024', '31/Dec/2024', null, 402, 301);

COMMIT;

--- Extra_Services
INSERT INTO extra_services
VALUES (extra_services_seq.NEXTVAL, 'Real IP', 'Monthly', 300);

INSERT INTO extra_services
VALUES (extra_services_seq.NEXTVAL, 'IP TV', 'Monthly', 300);

COMMIT;

--- Customers
INSERT INTO customers
VALUES (cust_id_seq.NEXTVAL, 'Samantha', 'Bird', null, 01956250001, 'bird@mail.com', 500, '01/Jun/2023', 202, 400, 40000, 1000, 'Home', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Brad', 'Arellano', null, '01956250002', 'arellano@mail.com', 500, '01/Jun/2023', 203, 400, 40010, 1010, 'Home', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Ashley', 'Gutierrez', null, '01956250003', 'gutierrez@mail.com', 500, '01/Jul/2023', 200, 406, 40020, 1000, 'Home', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Michelle', 'Miller', null, '01956250004', 'miller@mail.com', 500, '01/Jun/2023', 202, 401, 40030, 1010, 'Home', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Jessica', 'Nolan', null, '01956250005', 'nolan@mail.com', 500, '01/Aug/2023', 204, 401, 40030, null, 'Home', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Stephanie', 'Harris', null, '01956250006', 'harris@mail.com', 500, '01/Jun/2023', 200, 405, 40040, 1000, 'Home', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Angela', 'Chang', null, '01956250007', 'chang@mail.com', 500, '01/Sep/2023', 202, 408, 40070, 1010, 'Home', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Caroline', 'Dawson', null, '01956250008', 'dawson@mail.com', 500, '01/Oct/2023', 205, 400, 40000, 1000, 'Corporate', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Natalie', 'Foster', null, '01956250009', 'foster@mail.com', 500, '01/Jul/2023', 207, 400, 40010, null, 'Corporate', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'John', 'Fisher', null, '01956250010', 'fisher@mail.com', 500, '01/Jan/2024', 203, 400, 40000, 1010, 'Home', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Marie', 'Calderon', null, '01956250011', 'calderon@mail.com', 500, '01/Sep/2023', 206, 404, 40050, 1000, 'Corporate', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Jody', 'Hampton', null, '01956250012', 'hampton@mail.com', 500, '01/Nov/2023', 207, 404, 40060, null, 'Corporate', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Elizabeth', 'Harris', null, '01956250013', 'harris@mail.com', 500, '01/Aug/2023', 208, 408, 40070, 1000, 'Corporate', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Luis', 'Nelson', null, '01956250014', 'nelson@mail.com', 500, '01/Sep/2023', 209, 402, 40080, null, 'Corporate', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Mary', 'Garner', null, '01956250015', 'garner@mail.com', 500, '01/Jul/2023', 207, 400, 40000, 1000, 'Corporate', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Jack', 'Terrell', null, '01956250016', 'terrell@mail.com', 500, '01/Sep/2023', 203, 400, 40010, null, 'Home', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Emily', 'Mckinney', null, '01956250017', 'mckinney@mail.com', 500, '01/Jun/2023', 202, 404, 40050, 1010, 'Home', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Robert', 'Sullivan', null, '01956250019', 'sullivan@mail.com', 500, '1/Jun/2023', 202, 400, 40000, null, 'Home', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Anne', 'Hart', null, '01956250037', 'hart@mail.com', 500, '1/Oct/2023', 209, 402, 40080, null, 'Corporate', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Jessica', 'Lee', null, '01956250038', 'lee@mail.com', 500, '1/Nov/2023', 209, 402, 40080, null, 'Corporate', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Matthew', 'Reed', null, '01956250039', 'reed@mail.com', 500, '1/Sep/2023', 209, 402, 40080, null, 'Corporate', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Crystal', 'Weaver', null, '01956250037', 'weaver@mail.com', 500, '1/Nov/2023', 208, 404, 40050, null, 'Corporate', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Dana', 'Montoya', null, '01956250038', 'montoya@mail.com', 500, '1/Dec/2023', 208, 404, 40050, null, 'Corporate', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Nicole', 'Fleming', null, '01956250039', 'fleming@mail.com', 500, '1/Oct/2023', 208, 404, 40050, null, 'Corporate', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Tim', 'Herring', null, '01956250021', 'herring@mail.com', 500, '1/Jun/2023', 202, 406, 40020, null, 'Home', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Craig', 'Gilbert', null, '01956250022', 'gilbert@mail.com', 500, '1/Jun/2023', 202, 406, 40020, null, 'Home', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Maureen', 'Oconnor', null, '01956250023', 'oconnor@mail.com', 500, '1/Jun/2023', 202, 406, 40020, null, 'Home', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Thomas', 'Robertson', null, '01956250025', 'robertson@mail.com', 500, '1/Sep/2023', 203, 408, 40070, null, 'Home', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'David', 'Kerr', null, '01956250026', 'kerr@mail.com', 500, '1/Sep/2023', 203, 408, 40070, null, 'Home', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Heidi', 'Martinez', null, '01956250027', 'martinez@mail.com', 500, '1/Sep/2023', 200, 408, 40070, null, 'Home', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Amber', 'Harper', null, '01956250029', 'harper@mail.com', 500, '1/Oct/2023', 203, 403, 40090, null, 'Home', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Charles', 'Page', null, '01956250030', 'page@mail.com', 500, '1/Nov/2023', 204, 403, 40090, null, 'Home', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Karen', 'Mercer', null, '01956250031', 'mercer@mail.com', 500, '1/Dec/2023', 204, 403, 40090, null, 'Home', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Kelly', 'Chapman', null, '01956250033', 'chapman@mail.com', 500, '1/Nov/2023', 204, 409, 40100, null, 'Home', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Leslie', 'Daniels', null, '01956250034', 'daniels@mail.com', 500, '1/Dec/2023', 204, 409, 40100, null, 'Home', 'Active');

INSERT INTO customers 
VALUES (cust_id_seq.NEXTVAL, 'Charlotte', 'Hayes', null, '01956250035', 'hayes@mail.com', 500, '1/Nov/2023', 204, 409, 40100, 1010, 'Home', 'Active');

COMMIT;

--- Usage
INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 800, 1025, 1000);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 855, 1190, 1001);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 910, 1355, 1002);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 965, 1520, 1003);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 1020, 1685, 1004);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 1075, 1850, 1005);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 1130, 2015, 1006);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 1185, 2180, 1007);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 1240, 2345, 1008);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 1350, 2675, 1010);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 1405, 2840, 1011);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 1460, 3005, 1012);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 1515, 3170, 1013);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 1570, 3335, 1014);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 1625, 3500, 1015);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 1680, 3665, 1016);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 1735, 3830, 1017);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 1790, 3995, 1018);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 1845, 4160, 1019);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 1900, 4325, 1020);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 1955, 4490, 1021);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 2065, 4820, 1023);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 2120, 4985, 1024);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 2175, 5150, 1025);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 2230, 5315, 1026);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 2285, 5480, 1027);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 2340, 5645, 1028);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 2395, 5810, 1029);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 2450, 5975, 1030);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 2505, 6140, 1031);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 2615, 6470, 1033);

INSERT INTO usage 
VALUES (USAGE_ID_SEQ.NEXTVAL, '1/Dec/2023', '31/Dec/2023', 2725, 6800, 1035);

COMMIT;

--- Equipments
INSERT INTO equipments
VALUES (EQPT_ID_SEQ.NEXTVAL, 'ONU', 'Huawei', '10/Oct/2023', null, 'Not in Use', null, null, null);

INSERT INTO equipments
VALUES (EQPT_ID_SEQ.NEXTVAL, 'ONU', 'Huawei', '10/Oct/2023', null, 'Not in Use', null, null, null);

INSERT INTO equipments
VALUES (EQPT_ID_SEQ.NEXTVAL, 'Switch', 'TP-Link', '10/Oct/2023', null, 'Not in Use', null, null, null);

INSERT INTO equipments
VALUES (EQPT_ID_SEQ.NEXTVAL, 'Cat-6 Cable', 'D-Link', '10/Oct/2023', null, 'Not in Use', null, null, null);

INSERT INTO equipments
VALUES (EQPT_ID_SEQ.NEXTVAL, 'Router', 'TP-Link', '10/Oct/2023', null, 'Not in Use', null, null, null);

INSERT INTO equipments
VALUES (EQPT_ID_SEQ.NEXTVAL, 'Switch', 'Mikrotik', '10/Oct/2023', null, 'Not in Use', null, null, null);

INSERT INTO equipments
VALUES (EQPT_ID_SEQ.NEXTVAL, 'ONU', 'TP-Link', '10/Oct/2023', null, 'Not in Use', null, null, null);

INSERT INTO equipments
VALUES (EQPT_ID_SEQ.NEXTVAL, 'Switch', 'Cisco', '10/Oct/2023', null, 'Not in Use', null, null, null);

INSERT INTO equipments
VALUES (EQPT_ID_SEQ.NEXTVAL, 'Cat-5E Cable', 'D-Link', '10/Oct/2023', null, 'Not in Use', null, null, null);

INSERT INTO equipments
VALUES (EQPT_ID_SEQ.NEXTVAL, 'Router', 'D-Link', '10/Oct/2023', null, 'Not in Use', null, null, null);

INSERT INTO equipments
VALUES (EQPT_ID_SEQ.NEXTVAL, 'Switch', 'D-Link', '10/Oct/2023', null, 'Not in Use', null, null, null);

INSERT INTO equipments
VALUES (EQPT_ID_SEQ.NEXTVAL, 'ONU', 'Huawei', '15/Jul/2023', null, 'Not in Use', null, null, null);

INSERT INTO equipments
VALUES (EQPT_ID_SEQ.NEXTVAL, 'Switch', 'TP-Link', '15/Jul/2023', null, 'Not in Use', null, null, null);

INSERT INTO equipments
VALUES (EQPT_ID_SEQ.NEXTVAL, 'Cat-6 Cable', 'D-Link', '15/Jul/2023', null, 'Not in Use', null, null, null);

INSERT INTO equipments
VALUES (EQPT_ID_SEQ.NEXTVAL, 'Router', 'TP-Link', '15/Jul/2023', null, 'Not in Use', null, null, null);

INSERT INTO equipments
VALUES (EQPT_ID_SEQ.NEXTVAL, 'Switch', 'Mikrotik', '15/Jul/2023', '19/Aug/2023', 'In Use', null, 404, 40060);

INSERT INTO equipments
VALUES (EQPT_ID_SEQ.NEXTVAL, 'ONU', 'TP-Link', '15/Jul/2023', '19/Aug/2023', 'In Use', null, 405, 40040);

INSERT INTO equipments
VALUES (EQPT_ID_SEQ.NEXTVAL, 'Switch', 'Cisco', '15/Jul/2023', '19/Aug/2023', 'In Use', null, 401, 40030);

INSERT INTO equipments
VALUES (EQPT_ID_SEQ.NEXTVAL, 'Cat-5E Cable', 'D-Link', '15/Jul/2023', '19/Aug/2023', 'In Use', null, 406, 40020);

INSERT INTO equipments
VALUES (EQPT_ID_SEQ.NEXTVAL, 'Router', 'D-Link', '15/Jul/2023', '19/Aug/2023', 'In Use', null, 400, 40000);

INSERT INTO equipments
VALUES (EQPT_ID_SEQ.NEXTVAL, 'Switch', 'D-Link', '15/Jul/2023', '19/Aug/2023', 'Not in Use', 'Faulty', 400, 40000);

COMMIT;

--- Support
INSERT INTO support
VALUES (TICKET_ID_SEQ.NEXTVAL, TO_TIMESTAMP('28/Jul/2024 10:37:45 AM', 'DD/Mon/YYYY HH:MI:SS AM'),
TO_TIMESTAMP('28/Jul/2024 1:37:45 PM', 'DD/Mon/YYYY HH:MI:SS PM'),
'Customer connection down', 'Closed', 1001, 112);

INSERT INTO support
VALUES (TICKET_ID_SEQ.NEXTVAL, TO_TIMESTAMP('25/Sep/2024 11:37:45 AM', 'DD/Mon/YYYY HH:MI:SS AM'),
TO_TIMESTAMP('25/Sep/2024 12:55:45 PM', 'DD/Mon/YYYY HH:MI:SS PM'),
'Customer connection down', 'Closed', 1014, 113);

INSERT INTO support
VALUES (TICKET_ID_SEQ.NEXTVAL, TO_TIMESTAMP('23/Oct/2024 3:48:45 PM', 'DD/Mon/YYYY HH:MI:SS PM'),
TO_TIMESTAMP('23/Oct/2024 4:37:45 PM', 'DD/Mon/YYYY HH:MI:SS PM'),
'Customer connection down', 'Closed', 1020, 114);

COMMIT;

--- Maintenance

INSERT INTO maintenance
VALUES (MAINT_ID_SEQ.NEXTVAL, 1000, TO_TIMESTAMP('28/Jul/2024 10:40:45 AM', 'DD/Mon/YYYY HH:MI:SS AM'),
TO_TIMESTAMP('28/Jul/2024 12:37:45 PM', 'DD/Mon/YYYY HH:MI:SS PM'),
'Completed', 70000, 110, 119, 90160);

INSERT INTO maintenance
VALUES (MAINT_ID_SEQ.NEXTVAL, 500, TO_TIMESTAMP('25/Sep/2024 10:40:45 AM', 'DD/Mon/YYYY HH:MI:SS AM'),
TO_TIMESTAMP('25/Sep/2024 12:37:45 PM', 'DD/Mon/YYYY HH:MI:SS PM'),
'Completed', 70010, 110, 119, 90170);

COMMIT;

--- Users
INSERT INTO users
VALUES (USER_ID_SEQ.NEXTVAL, 'Jawed', 'Jawed123', 'Admin', 100);

INSERT INTO users
VALUES (USER_ID_SEQ.NEXTVAL, 'Salman', 'Salman123', 'DBA', 103);

INSERT INTO users
VALUES (USER_ID_SEQ.NEXTVAL, 'Arun', 'Arun123', 'CSR', 112);

INSERT INTO users
VALUES (USER_ID_SEQ.NEXTVAL, 'Chitta', 'Chitta123', 'CSR', 113);

INSERT INTO users
VALUES (USER_ID_SEQ.NEXTVAL, 'Sikdar', 'Sikdar123', 'CSR', 114);

INSERT INTO users
VALUES (1, 'Bishal', 1, 'Admin', null);

INSERT INTO users
VALUES (2, 'Bishal', 2, 'CSR', null);

COMMIT;


------ Setup Complete ------