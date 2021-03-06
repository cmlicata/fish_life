# fish_life

Database insertion script for all genomic data related to the NSF-funded fish-life project.

License
----

MIT

## Prerequisites

- You need to install [sequelpro](https://sequelpro.com/download), a fast, easy-to-use Mac database management application for working with MySQL databases.  You can, however, use any MySQL DB management application to work with the database, but the instructions detailed below **only applies to sequelpro**.  

- You need to get the [connection details](https://sequelpro.com/docs/get-started/get-connected/remote) for the remote MySQL server that is, presumably hosted in a cloud service provider (e.g. [AWS](https://aws.amazon.com/), [Azure](https://azure.microsoft.com/en-us/overview/what-is-azure/), [Google App Engine](https://cloud.google.com/appengine/)).

## Database setup instructions

1. Open sequelpro.

2. Enter your connection details in the form below.

    - **NOTE: YOU SHOULD NOT CHANGE THE PORT AS PORT `3306` IS THE DEFAULT PORT FOR MySQL DBs**

    - Here is an example: ![sequelpro database connection details example](images/sequelpro_db_connection_example.png)

3. Click ``"Add to Favorites"`` to save the connection for use next time you open Sequel Pro. Passwords are stored in the Keychain. To re-order favorites click the pencil in the bottom left of the connection window, (or choose `"Preferences" > "Favorites"` from the [Sequelpro](htt menu) then drag the favorites in the list.

4. Execute the `fish_data_create_tables.sql` file on the database:

    - If you would like to use the mysql cli to import the table creation script to your database, you will need to install the  [MySQL cli](https://dev.mysql.com/downloads/utilities/) and the [MySQL community server](https://dev.mysql.com/downloads/mysql/). There are two options:

         - If you would like to type your password at the command prompt execute the following on your machine using the Terminal:
         `mysql -h <hostname> -u <db_username> <db_name> < <file_to_import_to_db.sql>`

         - If you would like to add your password to the cli command execute the following on your machine using the Terminal:
         `mysql -h <hostname> -u <db_username> -p <db_password> < <file_to_import_to_db.sql>`

    - If you would rather use sequelpro's built-in MySQL query executor:

        - Copy the contents of the `fish_data_create_tables.sql` file into the textbox that appears when you click `Query` in the top navigation bar of the application window.

        - Click the down-arrow next to ``"Run Selection"``, which is immediately below the textbox area, to the right, and click ``"Run All Queries"``.

            - ![sequelpro run all queries example](images/sequelpro_run_all_queries_example.png)

    - Validate that all of the tables and temporary tables have been created with the appropriate schemas.

And that is it! You are now completely set up with [Sequelpro](https://sequelpro.com) and MySQL.

## Data Insertion Instructions

#### Advisory!!!

**This section is useless if your data files (i.e. your csv files with the fish_life data are incorrect).  Also, this section is written in a particular order for a reason.  This is why we [RTFM](https://en.wikipedia.org/wiki/RTFM).**

### Insert data into the `species` Table  

   - First, open [sequelpro](https://sequelpro.com).

   - Next, locate the `.csv` file that you would like to upload to your database.

   - Once you have your file, in the top left-hand corner of the screen, navigate to `"File" >> "Import"...`

       - ![sequelpro import csv example](images/import_csv_top_menu.png)


   - Now, select the correct table from the top drop-down menu

       - ![sequelpro import csv mapping example part 1](images/import_species_file_csv_mapping_p1.png)


   - Now, configure your CSV mapping (i.e. which fields/columns you would like to import and which ones you would rather not).  **NOTE: Unlike the rest of the tables, this insert template does not contain a column for `spec_id`, therefore, [sequelpro](https://sequelpro.com) will automatically set and increment the [primary key](https://www.w3schools.com/sql/sql_primarykey.asp) `spec_id`**

       - ![sequelpro import csv mapping example part 2](images/import_species_file_csv_mapping_p2.png)


   - Click `"Import"` and Volila! You now have all your (new) data in the species table!

      - ![sequelpro post csv import for species table](images/post_import_species_table.png)


  - Validate that all of data was imported correctly.

### Insert data into the `collections` Table

  - First, open [sequelpro](https://sequelpro.com).

  - Next, locate the `.csv` file that you would like to upload to your database.

  - Once you have your **collections_insert** file, in the top left-hand corner of the screen, navigate to `File >> "Import"...`

      - ![sequelpro import csv example](images/import_csv_top_menu.png)


  - Now, select the correct table from the top drop-down menu

      - ![sequelpro import collections csv mapping example part 1](images/import_collections_file_csv_mapping_p1.png)


  - Now, because you do not want to set the [foreign key](https://www.w3schools.com/sql/sql_foreignkey.asp) of `collection_id` to be set to `NULL`, upon import, you need to ignore the `collection_id` field that exists in the insert template by navigating to `1. collection_id >> Ignore Field`

      - ![sequelpro import collections csv mapping example part 2](images/import_collections_file_csv_mapping_p2.png)


  - Now, you can see that we will only be importing the `collection_acronym` and `collection_name` fields/columns from the CSV file into the `collections` table.

      - ![sequelpro import collections csv mapping example part 3](images/import_collections_file_csv_mapping_p3.png)


  - Click `"Import"` and Volila! You now have all your (new) data in the `collections` table!


  - Validate that all of data was imported correctly.

      - ![sequelpro post csv import for collections table](images/post_import_collections_table.png)

### Insert data into the `temp_gallery_insert` table

  - First, open [sequelpro](https://sequelpro.com).

  - Next, locate the `.csv` file that you would like to upload to your database.

  - Once you have your **temp_gallery_insert** file, in the top left-hand corner of the screen, navigate to `File >> "Import"...`

      - ![sequelpro import csv example](images/import_csv_top_menu.png)


  - Now, select the correct table from the top drop-down menu

      - ![sequelpro import temp_gallery_insert csv mapping example part 1](images/import_gallery_file_csv_mapping_p1.png)


  - Now, because this is a temporary table you do not need to import the [primary key](https://www.w3schools.com/sql/sql_primarykey.asp) of `gallery_id`. Upon import, you need to ignore the `gallery_id` field that exists in the insert template by navigating to `1. gallery_id >> Ignore Field`

      - ![sequelpro import temp_gallery_insert csv mapping example part 2](images/import_gallery_file_csv_mapping_p2.png)


  - Again, because this is a temporary table you do not need to import the [foreign key](https://www.w3schools.com/sql/sql_foreignkey.asp) of `spec_id`. Upon import, you need to ignore the `spec_id` field that exists in the insert template by navigating to `2. spec_id >> Ignore Field`

      - ![sequelpro import temp_gallery_insert csv mapping example part 3](images/import_gallery_file_csv_mapping_p3.png)


  - Now, you can see that we will only be importing the fields/columns shown below in lines `3` to `8`  from the CSV file into the `temp_gallery_insert` table.

      - ![sequelpro import temp_gallery_insert csv mapping example part 4](images/import_gallery_file_csv_mapping_p4.png)


  - Click `"Import"` and Volila! You now have all your (new) data in the `temp_gallery_insert` table!


  - Validate that all of data was imported correctly.

    - ![sequelpro post csv import for temp_gallery_insert table](images/post_import_temp_gallery_insert_table.png)


### Update unpopulated `spec_id` data in the `temp_gallery_insert` table

  - First, open [sequelpro](https://sequelpro.com).

  - Next, open the `Query` console by clicking Query, which is in the middle of the screen here:

      - ![sequelpro run all queries example](images/sequelpro_run_update_temp_gallery_insert_table_example.png)


  - **Copy the following query into the textbox that appears when you click `Query` in the top navigation bar of the application window AFTER you delete the contents of the textbox.**

    ```sql
      UPDATE temp_gallery_insert temp
      INNER JOIN species s
        ON temp.name = s.name
      SET temp.spec_id = s.spec_id
    ```
      - For more info on what this query is doing, look at [this page](http://stackoverflow.com/questions/11709043/mysql-update-column-with-value-from-another-table)


  - Click the down-arrow next to `"Run Selection"`, which is immediately below the textbox area, to the right, and click `"Run All Queries"`.

  - Validate that all of data was updated correctly.

     - ![sequelpro post update temp_gallery_insert table](images/post_update_temp_gallery_insert_table.png)

### Insert Updated Data in the `temp_gallery_insert` table to the  `gallery` table

  - **Next, copy the following query into the textbox that appears when you click `Query` in the top navigation bar of the application window AFTER you delete the contents of the textbox.**
  ```sql
    INSERT INTO gallery (`spec_id`,`catalog_nums`, `observations`, `photo_path`, `num_fish`, `photo_dir`)
      SELECT `spec_id`,`catalog_nums`, `observations`, `photo_path`, `num_fish`, `photo_dir`
    FROM temp_gallery_insert;
  ```
      - For more info on what this query is doing, look at [this page](http://stackoverflow.com/questions/1267427/sql-insert-all-records-from-one-table-to-another-table-without-specific-the-col)


  - Click the down-arrow next to `"Run Selection"`, which is immediately below the textbox area, to the right, and click `"Run All Queries"`.
      - ![sequelpro run all queries example](images/sequelpro_run_temp_gallery_insert_to_gallery_table_example.png)

  - Volila! You now have all your (new) data in the `gallery` table!

  - Validate that all of data was inserted into the `gallery` from the `temp_gallery_insert` table correctly.

    - ![sequelpro post insert of correctly updated temp_gallery_insert table data into gallery table](images/post_insert_gallery_table.png)


  - **Lastly, copy the following query into the textbox that appears when you click `Query` in the top navigation bar of the application window AFTER you delete the contents of the textbox.**
    ```sql
    TRUNCATE TABLE temp_gallery_insert;
    ```
      - For more info on what this query is doing, look at [this page](http://notes.jerzygangi.com/how-to-delete-all-rows-in-a-mysql-or-oracle-table/)


  - Validate that all of data was deleted from the `temp_gallery_insert` table  correctly.

      - ![sequelpro post truncate of correctly updated temp_gallery_insert table data ](images/truncate_temp_gallery_insert_table.png)

### Update unpopulated `gallery_id` data in the `species` table

  - **Copy the following query into the textbox that appears when you click `Query` in the top navigation bar of the application window AFTER you delete the contents of the textbox.**
    ```sql
      UPDATE species s
       INNER JOIN gallery g
        ON s.`spec_id` = g.`spec_id`
       SET s.`gallery_id` = g.`gallery_id`;
    ```

      - For more info on what this query is doing, look at [this page](http://stackoverflow.com/questions/11709043/mysql-update-column-with-value-from-another-table)


  - Click the down-arrow next to `"Run Selection"`, which is immediately below the textbox area, to the right, and click `"Run All Queries"`.

      - ![sequelpro run all queries example](images/sequelpro_run_update_gallery_info_in_species_table_example.png)


  - Volila! You now have all your (new) data in the `gallery` table!

  - Validate that all of data was inserted into the `species` from the `gallery` table correctly.

    - ![sequelpro post insert of correctly updated gallery table data into species table](images/post_update_species_table.png)


### Insert data into the `temp_tissues_insert` table

  - First, open [sequelpro](https://sequelpro.com).

  - Next, locate the `.csv` file that you would like to upload to your database.

  - Once you have your **temp_tissues_insert** file, in the top left-hand corner of the screen, navigate to `File >> "Import"...`

      - ![sequelpro import csv example](images/import_csv_top_menu.png)


  - Now, select the correct table from the top drop-down menu

      - ![sequelpro import temp_tissues_insert csv mapping example part 1](images/import_tissues_file_csv_mapping_p1.png)


  - Now, because this is a temporary table you do not need to import the [primary key](https://www.w3schools.com/sql/sql_primarykey.asp) of `tissue_id`. Upon import, you need to ignore the `tissue_id` field that exists in the insert template by navigating to `1. tissue_id >> Ignore Field`

      - ![sequelpro import temp_tissues_insert csv mapping example part 2](images/import_tissues_file_csv_mapping_p2.png)


  - Again, because this is a temporary table you do not need to import the [foreign key](https://www.w3schools.com/sql/sql_foreignkey.asp) of `spec_id`. Upon import, you need to ignore the `spec_id` field that exists in the insert template by navigating to `2. spec_id >> Ignore Field`

      - ![sequelpro import temp_tissues_insert csv mapping example part 3](images/import_tissues_file_csv_mapping_p3.png)


  - Again, because this is a temporary table you do not need to import the [foreign key](https://www.w3schools.com/sql/sql_foreignkey.asp) of `collection_id`. Upon import, you need to ignore the `collection_id` field that exists in the insert template by navigating to `5. collection_id >> Ignore Field`

      - ![sequelpro import temp_tissues_insert csv mapping example part 4](images/import_tissues_file_csv_mapping_p4.png)


  - Now, you can see that we will only be importing the fields/columns shown below in lines `3`, `4`, and `6` to `9`  from the CSV file into the `temp_tissues_insert` table.

      - ![sequelpro import temp_tissues_insert csv mapping example part 5](images/import_tissues_file_csv_mapping_p5.png)


  - Click `"Import"` and Volila! You now have all your (new) data in the `temp_tissues_insert` table!


  - Validate that all of data was imported correctly.

    - ![sequelpro post csv import for temp_tissues_insert table](images/post_import_temp_tissues_insert_table.png)

### Update unpopulated `spec_id` and `collection_id` data in the `temp_tissues_insert` table

- First, open [sequelpro](https://sequelpro.com).

- Next, open the `Query` console by clicking Query, which is in the middle of the screen here:

    - ![sequelpro run all queries example](images/sequelpro_run_update_temp_tissues_insert_table_example.png)


- **Copy the following query into the textbox that appears when you click `Query` in the top navigation bar of the application window AFTER you delete the contents of the textbox.**

  ```sql
  UPDATE temp_tissues_insert t
  JOIN collections c
    ON TRIM(t.`collection`) = TRIM(c.`collection_acronym`)
  JOIN species s
    ON TRIM(t.`name`) = TRIM(s.`name`)
  SET t.`collection_id` = c.`collection_id`,
      t.`spec_id` = s.`spec_id`;
  ```
    - For more info on what this query is doing, look at [this page](http://stackoverflow.com/questions/11709043/mysql-update-column-with-value-from-another-table) and [this page](http://stackoverflow.com/questions/6858143/how-to-remove-leading-and-trailing-whitespace-in-a-mysql-field)


- Click the down-arrow next to `"Run Selection"`, which is immediately below the textbox area, to the right, and click `"Run All Queries"`.

- Validate that all of data was updated correctly.

    - ![sequelpro post update temp_tissues_insert table](images/post_update_temp_tissues_insert_table.png)

### Insert Updated Data in the `temp_tissues_insert` table into the `tissues` table

  - **Next, copy the following query into the textbox that appears when you click `Query` in the top navigation bar of the application window AFTER you delete the contents of the textbox.**

    ```sql
    INSERT INTO tissues (`spec_id`,`tissue_label`,`catalog_num`, `collection_id`, `box_num`, `is_exhausted`)
    SELECT `spec_id`,`catalog_num`, `tissue_label`,`collection_id`, `box_num`, `is_exhausted`
    FROM temp_tissues_insert;
    ```
      - For more info on what this query is doing, look at [this page](http://stackoverflow.com/questions/1267427/sql-insert-all-records-from-one-table-to-another-table-without-specific-the-col)


  - Click the down-arrow next to `"Run Selection"`, which is immediately below the textbox area, to the right, and click `"Run All Queries"`.

    -  ![sequelpro run all queries example](images/sequelpro_run_temp_tissues_insert_to_tissues_table_example.png)


  - Volila! You now have all your (new) data in the `tissues` table!

  - Validate that all of data was inserted into the `tissues` from the `temp_tissues_insert` table correctly.

    - ![sequelpro post insert of correctly updated temp_gallery_insert table data into tissues table](images/post_insert_tissues_table.png)


  - **Lastly, copy the following query into the textbox that appears when you click `Query` in the top navigation bar of the application window AFTER you delete the contents of the textbox.**
    ```sql
    TRUNCATE TABLE temp_tissues_insert;
    ```
      - For more info on what this query is doing, look at [this page](http://notes.jerzygangi.com/how-to-delete-all-rows-in-a-mysql-or-oracle-table/)


  - Validate that all of data was deleted from the `temp_tissues_insert` table correctly.

      - ![sequelpro post truncate of correctly updated temp_tissues_insert table data ](images/truncate_temp_tissues_insert_table.png)

### Insert data into the `splate` table


  - First, open [sequelpro](https://sequelpro.com).

  - Next, locate the `.csv` file that you would like to upload to your database.

  - Once you have your **splate** file, in the top left-hand corner of the screen, navigate to `File >> "Import"...`

      - ![sequelpro import csv example](images/import_csv_top_menu.png)


  - Now, select the correct table from the top drop-down menu

      - ![sequelpro import splate csv mapping example](images/import_splate_file_csv_mapping_p1.png)


  - Now, because you do not want to set the [primary key](https://www.w3schools.com/sql/sql_primarykey.asp) of `splate_id` to be set to `NULL`, upon import, you need to ignore the `splate_id` field that exists in the insert template by navigating to `1. splate_id >> Ignore Field`

      - ![sequelpro import splate csv mapping example part 2](images/import_splate_file_csv_mapping_p2.png)


  - **The value for the `shp_date` of a splate will automatically default to `0000-00-00 00:00:00` if your insert template file `splate_insert_template_p1.csv` (i.e. your csv file with the splate data) does not contain a value for `shp_date` in the form of `yyyy-mm-dd hh:mm:ss` (e.g. `2010-01-03 04:30:43`). If you would like the `shp_date` to default to [`CURRENT_TIMESTAMP`](https://dev.mysql.com/doc/refman/5.7/en/timestamp-initialization.html), then you need to also ignore the `shp_date`field/column that exists in the insert template by navigating to `2. shp_date  >> Ignore Field`.**
      - ![sequelpro import splate csv mapping example part 3](images/import_splate_file_csv_mapping_p3.png)


  - Now, you can see that we will only be importing the fields/columns shown below in lines `2` and `3` from the CSV file into the `splate` table.  **NOTE: if you were to ignore the `shp_date` column as discussed above, the CSV Import Field Mapping window may look a little different from what you see below.**
      - ![sequelpro import splate csv mapping example part 4](images/import_splate_file_csv_mapping_p4.png)


  - Click `"Import"` and Volila! You now have all your (new) data in the `splate` table!

  - Validate that all of data was imported correctly.

      - ![sequelpro post insert splate table data into tissues table](images/post_insert_splate_table.png)


### Insert data into the `extraction_plate` table


  - First, open [sequelpro](https://sequelpro.com).

  - Next, locate the `.csv` file that you would like to upload to your database.

  - Once you have your **extraction_plate** file, in the top left-hand corner of the screen, navigate to `File >> "Import"...`

      - ![sequelpro import csv example](images/import_csv_top_menu.png)


  - Now, select the correct table from the top drop-down menu

      - ![sequelpro import splate csv mapping example](images/import_extraction_plate_file_csv_mapping_p1.png)


  - Now, because you do not want to set the [primary key](https://www.w3schools.com/sql/sql_primarykey.asp) of `ext_plt_id` to be set to `NULL`, upon import, you need to ignore the `ext_plt_id` field that exists in the insert template by navigating to `1. ext_plt_id >> Ignore Field`

      - ![sequelpro import splate csv mapping example part 2](images/import_extraction_plate_file_csv_mapping_p2.png)


  - Now, you can see that we will only be importing the field/column shown below in line `2` from the CSV file into the `extraction_plate` table.  

      - ![sequelpro import extraction_plate csv mapping example part 3](images/import_extraction_plate_file_csv_mapping_p3.png)


  - Validate that all of data was imported correctly.

      - ![sequelpro post insert splate table data into tissues table](images/post_insert_extraction_plate_table.png)
