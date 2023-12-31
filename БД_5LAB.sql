{\rtf1\ansi\ansicpg1251\deff0\nouicompat\deflang1049{\fonttbl{\f0\fnil\fcharset0 Courier New;}{\f1\fnil\fcharset204 Courier New;}}
{\*\generator Riched20 10.0.19041}\viewkind4\uc1 
\pard\sa200\sl276\slmult1\f0\fs22\lang9 --- log action\par
CREATE OR REPLACE PROCEDURE journal_log_proc(id INT, action_id INT)\par
LANGUAGE 'plpgsql' AS\par
$$\par
BEGIN\par
\tab INSERT INTO journal (users_id, journal.date, action_type_id)\par
\tab VALUES (id, current_timestamp, action_id);\par
END;\par
$$;\par
\par
--- insert new employee to "employee" table\par
CREATE OR REPLACE PROCEDURE employee_insert_proc(new_id INT)\par
LANGUAGE 'plpgsql' AS\par
$$\par
BEGIN\par
\tab INSERT INTO employee (users_id, stores_id,age,experience)\par
\tab VALUES (new_id, 1, 18, 1);\par
END;\par
$$;\par
\par
---insert new customer to "customer" table\par
CREATE OR REPLACE PROCEDURE customer_insert_proc(new_id INT)\par
LANGUAGE 'plpgsql' AS\par
$$\par
BEGIN\par
\tab INSERT INTO employee (users_id)\par
\tab VALUES (new_id);\par
END;\par
$$;\par
\par
-------------------------------------\par
\f1\lang1049\'d2\'f0\'e8\'e3\'e3\'e5\'f0\'ed\'e0\'ff \'f4\'f3\'ed\'ea\'f6\'e8\'ff \'e4\'eb\'ff \'e2\'f1\'f2\'e0\'e2\'ea\'e8 \'ef\'ee\'eb\'fc\'e7\'ee\'e2\'e0\'f2\'e5\'eb\'ff\par
CREATE OR REPLACE FUNCTION users_insert_trigger_func()\par
RETURNS TRIGGER\par
\par
AS $$\par
BEGIN\par
\tab IF NEW.is_staff = false AND NEW.is_superuser = false THEN\par
\tab\tab CALL customer_insert_proc(NEW.id);\par
\tab\tab CALL journal_log_proc(NEW.id, 4);\par
\tab ELSEIF NEW.is_staff = true AND NEW.is_superuser = false THEN\par
\tab\tab CALL employee_insert_proc(NEW.id);\par
\tab\tab CALL journal_log_proc(NEW.id, 5);\par
\tab ELSE\par
\tab\tab CALL journal_log_proc(NEW.id, 6);\par
\tab END IF;\par
\tab RETURN NEW;\par
END;\par
$$\par
LANGUAGE 'plpgsql';\par
\par
\par
CREATE TRIGGER users_insert_trigger\par
AFTER INSERT\par
ON "users"\par
FOR EACH ROW\par
EXECUTE PROCEDURE users_insert_trigger_func();\par
\par
\'c8\'f1\'ea\'eb\'fe\'f7\'e5\'ed\'e8\'ff \'e4\'eb\'ff \'f1\'eb\'f3\'f7\'e0\'ff is_stuff = true and superuser = true\par
CREATE OR REPLACE FUNCTION users_forbidden_insert_trigger_func()\par
RETURNS TRIGGER \par
AS $$\par
BEGIN\par
\tab IF NEW.is_satff = true and NEW.is_superuser = true THEN\par
\tab\tab RAISE EXCEPTION 'Insertion is not allowed for is_staff = true and is_superuser = true';\par
\tab END IF;\par
\tab RETURN NEW;\par
END;\par
$$\par
LANGUAGE 'plpgsql';\par
\par
\par
CREATE TRIGGER users_forbidden_insert_trigger\par
BEFORE INSERT\par
ON "users"\par
FOR EACH ROW\par
EXECUTE PROCEDURE users_forbidden_insert_trigger_func()\par
\par
\par
-----------------------------\par
-- Insert example: insert into users (first_name, last_name, username, password, email, is_staff, is_superuser) values ('Anton', 'Vorontsov', 'Andreevich', 'uO1(!ssu6&e84\\', 'sviridov6@gmail.com', false, false);\par
-- ************************************************************************************************************************************************************************************************************************************************\par
\par
\par
\'d3\'e4\'e0\'eb\'e5\'ed\'e8\'e5 \'f0\'e0\'e1\'ee\'f2\'ed\'e8\'ea\'e0 \par
CREATE OR REPLACE PROCEDURE employee_delete_proc(old_id INT)\par
LANGUAGE 'plpgsql'\par
AS $$\par
BEGIN\par
\tab DELETE FROM employee WHERE users_id = old_id;\par
END;\par
$$\par
\par
CREATE OR REPLACE FUNCTION users_update_to_add_superuser_func()\par
RETURNS TRIGGER AS\par
$$\par
BEGIN\par
\tab NEW.is_staff = false;\par
\tab CALL journal_log_proc(NEW.id,7);\par
\tab RETURN NEW;\par
END;\par
$$\par
LANGUAGE 'plpgsql';\par
\par
CREATE OR REPLACE TRIGGER users_update_to_add_superuser_trigger\par
BEFORE UPDATE\par
ON "users"\par
FOR EACH ROW\par
WHEN (OLD.is_staff = true AND OLD.is_superuser = false AND NEW.is_staff = true AND NEW.is_superuser = true)\par
EXECUTE PROCEDURE users_update_to_add_superuser_func();\par
\par
-- ************************************************************************************************************************************************************************************************************************************************\par
\par
\'d3\'e4\'e0\'eb\'ff\'e5\'ec \'ef\'ee\'eb\'fc\'e7\'ee\'e2\'e0\'f2\'e5\'eb\'ff \'e8\'e7 \'f2\'e0\'e1\'eb\'e8\'f6\'fb "users" \'e5\'f1\'eb\'e8 \'ee\'ed \'e1\'fb\'eb \'f3\'e4\'e0\'eb\'e5\'ed \'e8\'e7 \'f2\'e0\'e1\'eb\'e8\'f6\'fb "customer"\par
CREATE OR REPLACE PROCEDURE users_delete_proc(old_id INT)\par
LANGUAGE 'plpgsql'\par
AS $$\par
BEGIN\par
\tab DELETE FROM users WHERE id = old_id;\par
END;\par
$$\par
\par
CREATE OR REPLACE FUNCTION customer_delete_proc_wrapper()\par
RETURNS TRIGGER AS\par
$$\par
BEGIN\par
    CALL journal_log_proc(OLD.users_id, 8);\par
    CALL users_delete_proc(OLD.users_id);\par
    RETURN OLD;\par
END;\par
$$\par
LANGUAGE 'plpgsql';\par
\par
CREATE TRIGGER customer_delete_trigger\par
AFTER DELETE\par
ON "customer"\par
FOR EACH ROW\par
EXECUTE PROCEDURE customer_delete_proc_wrapper();\par
\par
\par
CREATE OR REPLACE FUNCTION employee_delete_proc_wrapper()\par
RETURNS TRIGGER AS\par
$$\par
BEGIN\par
\par
    CALL journal_log_proc(OLD.users_id, 9);\par
    CALL users_delete_proc(OLD.users_id);\par
\par
    RETURN OLD;\par
END;\par
$$\par
LANGUAGE 'plpgsql';\par
\par
CREATE TRIGGER employee_delete_trigger\par
AFTER DELETE\par
ON "employee"\par
FOR EACH ROW\par
EXECUTE PROCEDURE employee_delete_proc_wrapper();\f0\lang9\par
}
 