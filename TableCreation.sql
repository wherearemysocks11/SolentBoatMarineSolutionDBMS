CREATE TABLE customer_details(
  customer_id SERIAL PRIMARY KEY,
  customer_type ENUM NOT NULL,
  business_name VARCHAR(50),
  customer_fname VARCHAR(40),
  customer_lname VARCHAR(40),
  dob DATE,
  country VARCHAR(40) NOT NULL,
  address1 VARCHAR(60) NOT NULL,
  address2 VARCHAR(50),
  town VARCHAR(60) NOT NULL,
  postcode VARCHAR(15) NOT NULL,
  emailaddress VARCHAR(100),
  mobile_number CHAR(15) NOT NULL,
  landline_number CHAR(15)
);

CREATE TABLE emergency_contact(
  emergency_contact_id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customer_details(customer_id) NOT NULL,
  contact_fname VARCHAR(50) NOT NULL,
  contact_lname  VARCHAR(50) NOT NULL,
  contact_mobile  CHAR(15) NOT NULL,
  contact_landline CHAR(15),
  contact_emailaddress  VARCHAR (100)
);

CREATE TABLE boatyard_details(
  boatyard_id SERIA PRIMARY KEY,
  boatyard_name VARCHAR(100) NOT NULL,
  country VARCHAR(40) NOT NULL,
  address1 VARCHAR(60) NOT NULL,
  address2  VARCHAR(60),
  postcode/zip CHAR(15),
  indoor_storage_capcity SMALLINT NOT NULL
);

CREATE TABLE facilities(
  facility_id SERIAL PRIMARY KEY,
  facility_name VARCHAR(40) NOT NULL
);

CREATE TABLE boatyard_facilities(
  boatyard_id INT REFERENCES boatyard_details(boatyard_id) NOT NULL,
  facility_id SMALLINT REFERENCES facilities(facility_id) NOT NULL
);

CREATE TABLE dock_details(
  dock_id SERIAL PRIMARY KEY,
  boatyard_id INT REFERENCES boatyard_details(boatyard_id) NOT NULL,
  dock_allowed_boat_size ENUM NOT NULL,
  wet_slips_max_capcity SMALLINT NOT NULL,
  dry_slips_max_capacity SMALLINT NOT NULL
);

CREATE TABLE 
    staff_details(
        staff_id SERIAL PRIMARY KEY,
        boatyard_id INT NOT NULL REFERENCES boatyard_details (boatyard_id),
        staff_fname VARCHAR(40) NOT NULL,
        staff_lname  VARCHAR(40) NOT NULL,
        dob DATE NOT NULL,
        address1 VARCHAR (60) NOT NULL,
        address2 VARCHAR (50),
        town VARCHAR(60) NOT NULL,
        postcode CHAR (15) NOT NULL,
        mobile_number  CHAR(15) NOT NULL,
        landline_number CHAR(15),
        personal_emailaddress VARCHAR(100),
        work_emailaddress VARCHAR(100) NOT NULL
);

CREATE TABLE 
    roles(
        role_id SERIAL PRIMARY KEY,
        role_name VARCHAR (30) NOT NULL
    );

CREATE TABLE
    staff_roles(
        staff_id INT REFERENCES staff_details (staff_id),
        role_id SMALLINT REFERENCES roles (role_id)
    );

CREATE TYPE storageType AS ENUM ('Wet Slip', 'Dry Slip', 'Indoors');
CREATE TYPE boatSize AS ENUM ('Small', 'Medium', 'Large');
CREATE TYPE boatType AS ENUM ('Commercial', 'Private');

CREATE TABLE
    boats(
        boat_id SERIAL PRIMARY KEY,
        customer_id INTEGER NOT NULL REFERENCES customer_details (customer_id),
        boat_yard_id INTEGER NOT NULL REFERENCES boatyard_details ( boatyard_id),
        dock_id INTEGER NOT NULL REFERENCES dock_details (dock_id),
        boat_storage_type storageType NOT NULL,
        boat_size_class boatSize NOT NULL,
        boat_type boatType NOT NULL,
        boat_name VARCHAR (80) NOT NULL,
        model VARCHAR (40) NOT NULL,
        build_date DATE,
        length_overall VARCHAR (20) NOT NULL,
        beam VARCHAR (20) NOT NULL,
        draft VARCHAR (20) NOT NULL,
        cargo/tankers_capacity VARCHAR (15) NOT NULL
    );

CREATE TABLE
    classes(
        class_id SERIAL PRIMARY KEY,
        class_name VARCHAR (40) NOT NULL
    );

CREATE TABLE
    boat_classes(
        boat_id INT NOT NULL REFERENCES boat_details (boat_id),
        class_id INT NOT NULL REFERENCES classes (class_id)
    );


