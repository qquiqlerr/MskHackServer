CREATE TABLE if not exists zones (
                         id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
                         name TEXT,
                         stress float DEFAULT 0.0
);

CREATE TABLE if not exists routes (
                          id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
                          zone_id int,
                          name TEXT,
                          description TEXT,
                          length_hours float,
                          stress float DEFAULT 0.0
);

CREATE TABLE if not exists feature_types (
                                 id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
                                 name TEXT
);

CREATE TABLE if not exists route_features (
                                  route_id int,
                                  feature_id int,
                                  PRIMARY KEY (route_id, feature_id)
);

CREATE TABLE if not exists visit_permits (
                                 id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
                                 status int,
                                 requested_at timestamp without time zone,
                                 route_id int,
                                 visit_date date,
                                 group_id int,
                                 visit_reason int,
                                 visit_format int,
                                 first_name TEXT,
                                 last_name TEXT,
                                 middle_name TEXT,
                                 citizenship TEXT,
                                 registration_region TEXT,
                                 is_male boolean,
                                 passport TEXT,
                                 email TEXT,
                                 phone TEXT,
                                 date_of_birth TEXT
);

CREATE TABLE if not exists permit_statuses (
                                   id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
                                   name TEXT
);

CREATE TABLE if not exists visit_reasons (
                                 id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
                                 name TEXT
);

CREATE TABLE if not exists photo_types (
                               id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
                               name TEXT
);

CREATE TABLE if not exists visit_format (
                                id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
                                name TEXT
);

CREATE TABLE if not exists group_permits (
                                 id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY
);

CREATE TABLE if not exists reports (
                           id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
                           sent_at timestamp without time zone,
                           reported_at timestamp without time zone,
                           location TEXT,
                           type integer,
                           photo bytea,
                           comment TEXT,
                           email TEXT,
                           phone TEXT,
                           statusID integer
);

CREATE TABLE IF NOT EXISTS reports_statuses(
    id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name text
);

CREATE TABLE IF NOT EXISTS type_of_reports(
    id integer generated by default as identity primary key,
    name text
);

CREATE TABLE if not exists visit_permits_photo_types (
                                           visit_permit_id INT,
                                           photo_type_id INT,
                                           PRIMARY KEY (visit_permit_id, photo_type_id),
                                           FOREIGN KEY (visit_permit_id) REFERENCES visit_permits(id),
                                           FOREIGN KEY (photo_type_id) REFERENCES photo_types(id)
);
ALTER TABLE routes ADD FOREIGN KEY (zone_id) REFERENCES zones (id);
ALTER TABLE route_features ADD FOREIGN KEY (route_id) REFERENCES feature_types (id);
ALTER TABLE route_features ADD FOREIGN KEY (feature_id) REFERENCES routes (id);
ALTER TABLE visit_permits ADD FOREIGN KEY (status) REFERENCES permit_statuses (id);
ALTER TABLE visit_permits ADD FOREIGN KEY (route_id) REFERENCES routes (id);
ALTER TABLE visit_permits ADD FOREIGN KEY (group_id) REFERENCES group_permits (id);
ALTER TABLE visit_permits ADD FOREIGN KEY (visit_reason) REFERENCES visit_reasons (id);
ALTER TABLE visit_permits ADD FOREIGN KEY (visit_format) REFERENCES visit_format (id);
ALTER TABLE reports ADD FOREIGN KEY (type) REFERENCES type_of_reports(id);
ALTER TABLE reports ADD FOREIGN KEY (statusID) REFERENCES reports_statuses(id);

