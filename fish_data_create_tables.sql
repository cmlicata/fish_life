-- SETTING UP ALL OF THE TABLES THAT WILL BE NEEDED TO COMPLETE THE INSERT/UPLOAD

-- PRIMARY TABLE OF THE DATABASE CONTAINING SPECIES OF FISH
-- (NOTE: the 'name' column that you can see in the temporary tables
-- is the natural key that we created to easily map from csv files to the tables
-- as well as perform joins between tables). It is the title case Genus and lower
-- case species name for a given species (e.g. Umbra pygmae)
CREATE TABLE IF NOT EXISTS `species` (
  `spec_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `species` varchar(128) DEFAULT NULL,
  `genus` varchar(128) DEFAULT NULL,
  `order` varchar(128) DEFAULT NULL,
  `family` varchar(128) DEFAULT NULL,
  `gallery_id` int(11) DEFAULT NULL,
  `transcriptome` varchar(128) DEFAULT NULL,
  `genome` varchar(128) DEFAULT NULL,
  `is_fossil` tinyint(1) DEFAULT '0',
  `has_morphology` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`spec_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- TISSUES TABLE
-- (NOTE: the 'tissue_label' column that you can see in the temporary tables
-- is the natural key that we created to easily map from csv files to the tables
-- as well as perform joins between tables). It is the title case Genus and lower
-- case species name for a given species and the associated collection name,
-- all separated by an underscore.  Finally append the catalog_num to the end of
-- the string without any whitespace or delimiters. (e.g. Achirus_achirus_UMNSH16683)
CREATE TABLE IF NOT EXISTS `tissues` (
  `tissue_id` int(11) NOT NULL AUTO_INCREMENT,
  `spec_id` int(11) unsigned DEFAULT NULL,
  `tissue_label` varchar(200) DEFAULT NULL,
  `catalog_num` varchar(128) DEFAULT NULL,
  `collection_id` int(11) unsigned DEFAULT NULL,
  `box_num` int(11) DEFAULT NULL,
  `is_exhausted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`tissue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- TEMPORARY TISSUES TABLE
-- (NOTE: the 'tissue_label' column that you can see in the temporary tables
-- is the natural key that we created to easily map from csv files to the tables
-- as well as perform joins between tables). It is the title case Genus and lower
-- case species name for a given species and the associated collection name,
-- all separated by an underscore.  Finally append the catalog_num to the end of
-- the string without any whitespace or delimiters. (e.g. Achirus_achirus_UMNSH16683)
-- The other natural key we see here is 'collection' which is simply the collection_name
-- from the `collections` table. This is used to update the values of the `collection_id`.
-- The other nautural key that we see here is 'name', which is the title case Genus and lower
-- case species name for a given species.
CREATE TABLE IF NOT EXISTS `temp_tissues_insert` (
  `tissue_id` int(11) DEFAULT NULL,
  `spec_id` int(11) DEFAULT NULL,
  `name` varchar(128) DEFAULT NULL,
  `tissue_label` varchar(200) DEFAULT NULL,
  `collection_id` int(11) DEFAULT NULL,
  `catalog_num` varchar(128) DEFAULT NULL,
  `collection` varchar(128) DEFAULT NULL,
  `box_num` varchar(128) DEFAULT NULL,
  `is_exhausted` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- COLLECTIONS TABLE
-- (NOTE: the 'tissue_label' variable that you can see in the temporary tables
-- is the natural key that we created to easily map from csv files to the tables
-- as well as perform joins between tables). It is the title case Genus and lower
-- case species name for a given species and the associated collection name,
-- all separated by an underscore.  Finally append the catalog_num to the end of
-- the string without any whitespace or delimiters. (e.g. Achirus_achirus_UMNSH16683)
CREATE TABLE IF NOT EXISTS `collections` (
  `collection_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `collection_acronym` varchar(11) DEFAULT NULL,
  `collection_name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`collection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- GALLERY TABLE
-- This is where the paths to all of the photos for a particular species are stored.
CREATE TABLE IF NOT EXISTS `gallery` (
  `gallery_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `spec_id` int(11) DEFAULT NULL,
  `catalog_nums` varchar(200) DEFAULT NULL,
  `observations` text,
  `photo_path` varchar(200) DEFAULT NULL,
  `num_fish` int(20) DEFAULT NULL,
  `photo_dir` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`gallery_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- TEMPORARY GALLERY TABLE
-- This is where the paths to all of the photos for a particular species are stored.
-- The natural key that we see here is 'name', which is the title case Genus and lower
-- case species name for a given species (e.g. Umbra pygmae).
CREATE TABLE IF NOT EXISTS `temp_gallery_insert` (
  `gallery_id` int(11) DEFAULT NULL,
  `spec_id` int(11) DEFAULT NULL,
  `name` varchar(130) DEFAULT NULL,
  `catalog_nums` varchar(200) DEFAULT NULL,
  `observations` text,
  `photo_path` varchar(200) DEFAULT NULL,
  `num_fish` int(20) DEFAULT NULL,
  `photo_dir` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- dna_extractions TABLE
CREATE TABLE IF NOT EXISTS `dna_extractions` (
  `extraction_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `dna_extraction_label` varchar(128) DEFAULT NULL,
  `spec_id` int(11) unsigned DEFAULT NULL,
  `ext_plt_id` int(11) unsigned DEFAULT NULL,
  `ext_well_loc` varchar(30) DEFAULT NULL,
  `splate_id` int(11) unsigned DEFAULT NULL,
  `swell_loc` varchar(128) DEFAULT NULL,
  `tissue_id` int(128) unsigned DEFAULT NULL,
  `dna_concentration` int(11) DEFAULT NULL,
  `dna_integrity` decimal(2,1) DEFAULT NULL,
  `barcode` text,
  `is_verified` tinyint(1) DEFAULT '0',
  `is_suspect` tinyint(1) DEFAULT '0',
  `extracted_by` varchar(128) DEFAULT NULL,
  `comment` text,
  `gel_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`extraction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- TEMPORARY dna_extractions TABLE
-- (NOTE: the dna_extraction_label column that you can see in this table is the
--  title case Genus and lower case species name for a given species separated
-- by an underscore and then the ext_plt_name and ext_well_loc is appended
-- (e.g. Achirus_achirusEPLATE_01_A01). the 'tissue_label' column that you can see in
-- the temporary tables is the natural key that we created to easily map from csv files
-- to the tables as well as perform joins between tables). It is the title case
-- Genus and lower  case species name for a given species and the associated collection name,
-- all separated by an underscore.  Finally append the catalog_num to the end of
-- the string without any whitespace or delimiters. (e.g. Achirus_achirus_UMNSH16683)
-- The other natural key we see here is 'collection' which is simply the collection_name
-- from the `collections` table. This is used to update the values of the `collection_id`.
-- The other natural key that we see here is 'name', which is the title case Genus and lower
-- case species name for a given species (e.g. Umbra pygmae). `splate_name` is another
-- natural key that is simply SPLATE_[0-9]+ it corresponds to the splate_name column in
-- the `splate` table.`ext_plt_name` is another natural key that is simply EPLATE_[0-9]+
-- it corresponds to the ext_plt_name column in the `extraction_plate` table.
CREATE TABLE IF NOT EXISTS `temp_dna_extractions_insert` (
  `extraction_id` int(11) unsigned DEFAULT NULL,
  `dna_extraction_label` varchar(128) DEFAULT NULL,
  `spec_id` int(11) unsigned DEFAULT NULL,
  `name` varchar(128) DEFAULT NULL,
  `ext_plt_id` int(11) unsigned DEFAULT NULL,
  `ext_plt_name` varchar(128) DEFAULT NULL,
  `ext_well_loc` varchar(30) DEFAULT NULL,
  `splate_id` int(11) unsigned DEFAULT NULL,
  `splate_name` varchar(128) DEFAULT NULL,
  `swell_loc` varchar(128) DEFAULT NULL,
  `tissue_id` int(128) unsigned DEFAULT NULL,
  `tissue_label` varchar(200) DEFAULT NULL,
  `dna_concentration` int(11) DEFAULT NULL,
  `dna_integrity` decimal(2,1) DEFAULT NULL,
  `barcode` text,
  `is_verified` tinyint(1) DEFAULT '0',
  `is_suspect` tinyint(1) DEFAULT '0',
  `extracted_by` varchar(128) DEFAULT NULL,
  `comment` text,
  `gel_id` int(11) unsigned DEFAULT NULL,
  `gel_number` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- extraction_plate TABLE
-- These are the plates in which the dna of the fish is actually extracted.
CREATE TABLE IF NOT EXISTS `extraction_plate` (
  `ext_plt_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ext_plt_name` varchar(140) DEFAULT NULL,
  PRIMARY KEY (`ext_plt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- shipping_plate TABLE
-- These are the plates that are sent of to other facilities to get sequences back.
CREATE TABLE IF NOT EXISTS`splate` (
  `splate_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `splate_name` varchar(120) DEFAULT NULL,
  `shp_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`splate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- gels TABLE
CREATE TABLE IF NOT EXISTS `gels` (
  `gel_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `gel_number` varchar(128) DEFAULT NULL,
  `gel_url` varchar(200) DEFAULT NULL,
  `extraction_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`gel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- temporary gels TABLE
CREATE TABLE IF NOT EXISTS `temp_gels_insert` (
  `gel_id` int(11) unsigned DEFAULT NULL,
  `gel_number` varchar(128) DEFAULT NULL,
  `gel_url` varchar(200) DEFAULT NULL,
  `extraction_id` int(11) unsigned DEFAULT NULL,
  `dna_extraction_label` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- sequence table
CREATE TABLE IF NOT EXISTS `sequence` (
  `seq_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sequence_label` varchar(128) DEFAULT NULL,
  `extraction_id` int(11) DEFAULT NULL,
  `data_size` decimal(2,1) DEFAULT NULL,
  `num_targets` int(11) DEFAULT NULL,
  `genome` tinyint(1) DEFAULT NULL,
  `transcriptome` tinyint(1) DEFAULT NULL,
  `my_barcode` text,
  `my_barcode_verified` tinyint(1) DEFAULT NULL,
  `my_barcode_suspect` tinyint(1) DEFAULT NULL,
  `comment` text,
  PRIMARY KEY (`seq_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- temporary sequence table
-- the dna_extraction_label column that you can see in this table is the
--  title case Genus and lower case species name for a given species separated
-- by an underscore and then the ext_plt_name and ext_well_loc is appended
-- (e.g. Achirus_achirusEPLATE_01_A01). The sequence_label is pretty much the same thing
-- but you have to add the splate_name and swell_loc swell_loc
-- (e.g. Dactylopterus_volitansEPLATE_01_A09_SPLATE_01_A1)
CREATE TABLE IF NOT EXISTS `temp_sequence_insert` (
  `seq_id` int(11) unsigned DEFAULT NULL,
  `sequence_label` varchar(128) DEFAULT NULL,
  `extraction_id` int(11) DEFAULT NULL,
  `dna_extraction_label` varchar(128) DEFAULT NULL,
  `data_size` decimal(2,1) DEFAULT NULL,
  `num_targets` int(11) DEFAULT NULL,
  `genome` tinyint(1) DEFAULT NULL,
  `transcriptome` tinyint(1) DEFAULT NULL,
  `my_barcode` text,
  `my_barcode_verified` tinyint(1) DEFAULT NULL,
  `my_barcode_suspect` tinyint(1) DEFAULT NULL,
  `comment` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- seq_folder TABLE
CREATE TABLE IF NOT EXISTS `seq_folder` (
  `seq_folder_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `seq_folder_name` varchar(128) DEFAULT NULL,
  `seq_storage_path` varchar(200) DEFAULT NULL,
  `seq_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`seq_folder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- temp_seq_folder_insert TABLE
-- The sequence_label is pretty much the same thing as the dna_extraction_label
-- but you have to add the splate_name and swell_loc swell_loc
-- (e.g. Dactylopterus_volitansEPLATE_01_A09_SPLATE_01_A1)
CREATE TABLE IF NOT EXISTS `temp_seq_folder_insert` (
  `seq_folder_id` int(11) unsigned DEFAULT NULL,
  `seq_folder_name` varchar(128) DEFAULT NULL,
  `seq_storage_path` varchar(200) DEFAULT NULL,
  `seq_id` int(11) unsigned DEFAULT NULL,
  `seq_label` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
