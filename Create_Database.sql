/* Create reference tables */
CREATE TABLE Actor (
    id SERIAL,
    name VARCHAR(45) UNIQUE,
    PRIMARY KEY(id)
);

CREATE TABLE TimeFrame (
    id SERIAL,
    name VARCHAR(45) UNIQUE,
    PRIMARY KEY(id)
);

CREATE TABLE Network (
    id SERIAL,
    name VARCHAR(45) UNIQUE,
    PRIMARY KEY(id)
);

CREATE TABLE Director (
    id SERIAL,
    name VARCHAR(45) UNIQUE,
    PRIMARY KEY(id)
);

/* Tables to import CSV files into */
CREATE TABLE EpisodeActorRaw ( --will be dropped later
    episode_id INT, --starts empty
    episode_title VARCHAR(45), --will be dropped
    actor_id INT, --starts empty
    actor_name VARCHAR(45), --will be dropped
    character_name VARCHAR(45),
    credit_order INT
);

CREATE TABLE Episode (
    id SERIAL, --automatically generated
    season INT,
    episode INT,
    title VARCHAR(45) UNIQUE,
    release_date DATE,
    length_min INT,
    my_rating FLOAT,
    imdb_rating FLOAT,
    timeframe_name VARCHAR(45), --will be dropped
    timeframe_id INT REFERENCES TimeFrame(id) ON DELETE CASCADE, --starts empty
    network_name VARCHAR(45), --will be dropped
    network_id INT REFERENCES Network(id) ON DELETE CASCADE, --starts empty
    director_name VARCHAR(45), --will be dropped
    director_id INT REFERENCES Director(id) ON DELETE CASCADE, --starts empty
    description TEXT UNIQUE,
    PRIMARY KEY(id)
);

/* Create final EpisodeActor table */
CREATE TABLE EpisodeActor (
    episode_id INT REFERENCES Episode(id) ON DELETE CASCADE,
    actor_id INT REFERENCES Actor(id) ON DELETE CASCADE,
    character_name VARCHAR(45),
    credit_order INT,
    PRIMARY KEY (episode_id, actor_id)
);


/* Filling in reference tables */
INSERT INTO Actor(name)
SELECT DISTINCT EpisodeActorRaw.actor_name
FROM EpisodeActorRaw;

INSERT INTO TimeFrame(name)
SELECT DISTINCT Episode.timeframe_name
FROM Episode;

INSERT INTO Network(name)
SELECT DISTINCT Episode.network_name
FROM Episode;

INSERT INTO Director(name)
SELECT DISTINCT Episode.director_name
FROM Episode;

/* Filling in currently empty id fields in EpisodeActor table */
UPDATE EpisodeActorRaw
SET episode_id = (SELECT Episode.id FROM Episode WHERE Episode.title = EpisodeActorRaw.episode_title);

UPDATE EpisodeActorRaw
SET actor_id = (SELECT Actor.id FROM Actor WHERE Actor.name = EpisodeActorRaw.actor_name);

/* Filling in currently empty id fields in Episode table */
UPDATE Episode
SET timeframe_id = (SELECT TimeFrame.id FROM TimeFrame WHERE TimeFrame.name = Episode.timeframe_name);

UPDATE Episode
SET network_id = (SELECT Network.id FROM Network WHERE Network.name = Episode.network_name);

UPDATE Episode
SET director_id = (SELECT Director.id FROM Director WHERE Director.name = Episode.director_name);

/* Dropping unnecessary text columns in Episode table */
ALTER TABLE Episode DROP COLUMN timeframe_name;
ALTER TABLE Episode DROP COLUMN network_name;
ALTER TABLE Episode DROP COLUMN director_name;

/* Inserting data into the final version of EpisodeActor table and dropping raw table */
INSERT INTO EpisodeActor (episode_id, actor_id, character_name, credit_order)
SELECT episode_id, actor_id, character_name, credit_order FROM EpisodeActorRaw;

DROP TABLE EpisodeActorRaw;