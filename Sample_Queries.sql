/* Reconstruct the episode table to perform Python data manipulation */
SELECT
    Episode.id,
    season,
    episode,
    title,
    release_date,
    length_min,
    my_rating,
    imdb_rating,
    timeframe.name,
    network.name,
    director.name,
    description
FROM Episode
JOIN TimeFrame ON TimeFrame.id = Episode.timeframe_id
JOIN Network ON Network.id = Episode.network_id
JOIN Director ON Director.id = Episode.director_id
ORDER BY 1;

/* Average ratings by season */
SELECT season,
    AVG(my_rating) AS avg_my_rating,
    AVG(imdb_rating) AS avg_imdb_rating
FROM Episode
GROUP BY 1
ORDER BY 1;

/* Find number of episodes per season */
SELECT season, COUNT(*) AS num_of_eps
FROM Episode
GROUP BY 1
ORDER BY 1;

/* Average ratings Channel 4 vs. Netflix */
SELECT Network.name, 
    AVG(my_rating) AS avg_my_rating,
    AVG(imdb_rating) AS avg_imdb_rating
FROM Episode
JOIN Network ON Episode.network_id = Network.id
GROUP BY 1;

/* Average length of episodes per season */
SELECT season, 
    AVG(length_min) AS avg_length
FROM Episode
GROUP BY 1
ORDER BY 1;

/* Find the actors who have played more than one character in the Black Mirror universe */
SELECT Actor.name, COUNT(*)
FROM EpisodeActor
JOIN Actor ON Actor.id = EpisodeActor.actor_id
GROUP BY 1
HAVING COUNT(*) > 1;

/* Find the top 4 directors by number of episodes directed */
SELECT Director.name,
    COUNT(*)
FROM Episode
JOIN Director ON Episode.director_id = Director.id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 4;

/* Find the number of credited actors per episode, ordered by more actors to less actors */
SELECT Episode.title,
    COUNT(EpisodeActor.actor_id)
FROM Episode
JOIN EpisodeActor ON EpisodeActor.episode_id = Episode.id
GROUP BY 1
ORDER BY 2 DESC;

/* Find number of episodes taking place in the future */
SELECT
    COUNT(*)
FROM Episode
WHERE timeframe_id = 
    (SELECT timeframe.id FROM timeframe WHERE timeframe.name = 'future');