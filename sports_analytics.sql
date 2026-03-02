-- =====================================================
-- ⚽ SPORTS ANALYTICS SQL PROJECT
-- By: Thejas Sharma (thejasrhoades-speed)
-- Topic: Football / Soccer League Analytics
-- Level: Intermediate + Advanced
-- =====================================================

-- =====================================================
-- 📦 DATABASE SETUP
-- =====================================================

CREATE DATABASE sports_analytics;
USE sports_analytics;

-- Players Table
CREATE TABLE players (
    player_id INT PRIMARY KEY AUTO_INCREMENT,
    player_name VARCHAR(100),
    age INT,
    nationality VARCHAR(50),
    position VARCHAR(30),
    club_id INT,
    market_value_millions DECIMAL(10,2),
    joined_date DATE
);

-- Clubs Table
CREATE TABLE clubs (
    club_id INT PRIMARY KEY AUTO_INCREMENT,
    club_name VARCHAR(100),
    league VARCHAR(50),
    country VARCHAR(50),
    stadium VARCHAR(100),
    founded_year INT
);

-- Matches Table
CREATE TABLE matches (
    match_id INT PRIMARY KEY AUTO_INCREMENT,
    home_club_id INT,
    away_club_id INT,
    home_goals INT,
    away_goals INT,
    match_date DATE,
    season VARCHAR(10),
    stadium VARCHAR(100)
);

-- Player Stats Table
CREATE TABLE player_stats (
    stat_id INT PRIMARY KEY AUTO_INCREMENT,
    player_id INT,
    match_id INT,
    goals INT DEFAULT 0,
    assists INT DEFAULT 0,
    minutes_played INT DEFAULT 0,
    yellow_cards INT DEFAULT 0,
    red_cards INT DEFAULT 0,
    shots INT DEFAULT 0,
    passes INT DEFAULT 0,
    pass_accuracy DECIMAL(5,2)
);

-- Transfers Table
CREATE TABLE transfers (
    transfer_id INT PRIMARY KEY AUTO_INCREMENT,
    player_id INT,
    from_club_id INT,
    to_club_id INT,
    transfer_fee_millions DECIMAL(10,2),
    transfer_date DATE,
    transfer_type VARCHAR(20) -- 'permanent', 'loan'
);

-- =====================================================
-- 🌱 SAMPLE DATA
-- =====================================================

INSERT INTO clubs VALUES
(1, 'Manchester City', 'Premier League', 'England', 'Etihad Stadium', 1880),
(2, 'Arsenal', 'Premier League', 'England', 'Emirates Stadium', 1886),
(3, 'Real Madrid', 'La Liga', 'Spain', 'Bernabeu', 1902),
(4, 'Barcelona', 'La Liga', 'Spain', 'Camp Nou', 1899),
(5, 'Bayern Munich', 'Bundesliga', 'Germany', 'Allianz Arena', 1900),
(6, 'PSG', 'Ligue 1', 'France', 'Parc des Princes', 1970),
(7, 'Juventus', 'Serie A', 'Italy', 'Allianz Stadium', 1897),
(8, 'Liverpool', 'Premier League', 'England', 'Anfield', 1892);

INSERT INTO players VALUES
(1, 'Erling Haaland', 23, 'Norwegian', 'Forward', 1, 180.00, '2022-07-01'),
(2, 'Bukayo Saka', 22, 'English', 'Winger', 2, 120.00, '2018-07-01'),
(3, 'Vinicius Jr', 23, 'Brazilian', 'Winger', 3, 150.00, '2018-07-01'),
(4, 'Pedri', 21, 'Spanish', 'Midfielder', 4, 110.00, '2020-07-01'),
(5, 'Jamal Musiala', 21, 'German', 'Midfielder', 5, 130.00, '2019-07-01'),
(6, 'Kylian Mbappe', 25, 'French', 'Forward', 3, 200.00, '2024-07-01'),
(7, 'Rodri', 27, 'Spanish', 'Midfielder', 1, 120.00, '2019-07-01'),
(8, 'Mohamed Salah', 31, 'Egyptian', 'Winger', 8, 80.00, '2017-07-01');

INSERT INTO matches VALUES
(1, 1, 2, 3, 1, '2024-09-22', '2024/25', 'Etihad Stadium'),
(2, 3, 4, 2, 1, '2024-10-26', '2024/25', 'Bernabeu'),
(3, 2, 8, 2, 2, '2024-11-02', '2024/25', 'Emirates Stadium'),
(4, 5, 6, 4, 2, '2024-11-09', '2024/25', 'Allianz Arena'),
(5, 1, 3, 1, 1, '2024-11-20', '2024/25', 'Etihad Stadium'),
(6, 4, 7, 3, 0, '2024-12-01', '2024/25', 'Camp Nou'),
(7, 8, 1, 1, 2, '2024-12-14', '2024/25', 'Anfield'),
(8, 2, 3, 0, 1, '2025-01-07', '2024/25', 'Emirates Stadium');

INSERT INTO player_stats VALUES
(1, 1, 1, 2, 0, 90, 0, 0, 5, 30, 85.50),
(2, 2, 1, 0, 1, 90, 1, 0, 2, 45, 88.00),
(3, 3, 2, 1, 1, 90, 0, 0, 4, 38, 82.00),
(4, 6, 2, 1, 0, 90, 0, 0, 3, 25, 79.00),
(5, 1, 7, 1, 0, 90, 0, 0, 4, 28, 84.00),
(6, 7, 1, 0, 2, 90, 0, 0, 1, 88, 94.50),
(7, 8, 3, 1, 1, 90, 0, 0, 3, 42, 86.00),
(8, 5, 4, 2, 1, 90, 0, 0, 4, 55, 91.00),
(9, 6, 5, 1, 0, 85, 1, 0, 3, 22, 77.00),
(10, 2, 3, 1, 0, 90, 0, 0, 3, 50, 89.00);

INSERT INTO transfers VALUES
(1, 6, 6, 3, 0.00, '2024-07-01', 'permanent'),
(2, 1, 7, 1, 51.00, '2022-07-01', 'permanent'),
(3, 3, 7, 3, 45.00, '2018-07-01', 'permanent'),
(4, 7, 4, 1, 70.00, '2019-07-01', 'permanent');

-- =====================================================
-- 🟡 INTERMEDIATE QUERIES
-- =====================================================

-- 1. Top 5 scorers across all matches
SELECT 
    p.player_name,
    c.club_name,
    SUM(ps.goals) AS total_goals,
    SUM(ps.assists) AS total_assists,
    SUM(ps.goals) + SUM(ps.assists) AS goal_contributions
FROM player_stats ps
JOIN players p ON ps.player_id = p.player_id
JOIN clubs c ON p.club_id = c.club_id
GROUP BY p.player_name, c.club_name
ORDER BY total_goals DESC
LIMIT 5;

-- 2. Club win/draw/loss record
SELECT 
    c.club_name,
    COUNT(CASE WHEN m.home_club_id = c.club_id AND m.home_goals > m.away_goals THEN 1
               WHEN m.away_club_id = c.club_id AND m.away_goals > m.home_goals THEN 1 END) AS wins,
    COUNT(CASE WHEN m.home_goals = m.away_goals THEN 1 END) AS draws,
    COUNT(CASE WHEN m.home_club_id = c.club_id AND m.home_goals < m.away_goals THEN 1
               WHEN m.away_club_id = c.club_id AND m.away_goals < m.home_goals THEN 1 END) AS losses,
    COUNT(CASE WHEN m.home_club_id = c.club_id AND m.home_goals > m.away_goals THEN 1
               WHEN m.away_club_id = c.club_id AND m.away_goals > m.home_goals THEN 1 END) * 3 +
    COUNT(CASE WHEN m.home_goals = m.away_goals THEN 1 END) AS points
FROM clubs c
LEFT JOIN matches m ON c.club_id = m.home_club_id OR c.club_id = m.away_club_id
GROUP BY c.club_name
ORDER BY points DESC;

-- 3. Average pass accuracy by position
SELECT 
    p.position,
    ROUND(AVG(ps.pass_accuracy), 2) AS avg_pass_accuracy,
    ROUND(AVG(ps.passes), 0) AS avg_passes_per_game
FROM player_stats ps
JOIN players p ON ps.player_id = p.player_id
GROUP BY p.position
ORDER BY avg_pass_accuracy DESC;

-- 4. Players with most yellow cards
SELECT 
    p.player_name,
    p.nationality,
    c.club_name,
    SUM(ps.yellow_cards) AS total_yellows,
    SUM(ps.red_cards) AS total_reds
FROM player_stats ps
JOIN players p ON ps.player_id = p.player_id
JOIN clubs c ON p.club_id = c.club_id
GROUP BY p.player_name, p.nationality, c.club_name
HAVING total_yellows > 0
ORDER BY total_yellows DESC;

-- 5. Goals scored per league
SELECT 
    c.league,
    SUM(m.home_goals + m.away_goals) AS total_goals,
    COUNT(m.match_id) AS total_matches,
    ROUND(SUM(m.home_goals + m.away_goals) / COUNT(m.match_id), 2) AS avg_goals_per_match
FROM matches m
JOIN clubs c ON m.home_club_id = c.club_id
GROUP BY c.league
ORDER BY avg_goals_per_match DESC;

-- =====================================================
-- 🔴 ADVANCED QUERIES
-- =====================================================

-- 6. Rank players by goals using WINDOW FUNCTION
SELECT 
    p.player_name,
    c.club_name,
    p.position,
    SUM(ps.goals) AS total_goals,
    RANK() OVER (PARTITION BY p.position ORDER BY SUM(ps.goals) DESC) AS rank_in_position,
    DENSE_RANK() OVER (ORDER BY SUM(ps.goals) DESC) AS overall_rank
FROM player_stats ps
JOIN players p ON ps.player_id = p.player_id
JOIN clubs c ON p.club_id = c.club_id
GROUP BY p.player_name, c.club_name, p.position;

-- 7. Running total of goals per club over time (CTE + Window)
WITH club_goals AS (
    SELECT 
        c.club_name,
        m.match_date,
        CASE WHEN m.home_club_id = c.club_id THEN m.home_goals
             ELSE m.away_goals END AS goals_scored
    FROM matches m
    JOIN clubs c ON c.club_id = m.home_club_id OR c.club_id = m.away_club_id
)
SELECT 
    club_name,
    match_date,
    goals_scored,
    SUM(goals_scored) OVER (PARTITION BY club_name ORDER BY match_date) AS running_total_goals
FROM club_goals
ORDER BY club_name, match_date;

-- 8. Players performing above their club average (Subquery)
SELECT 
    p.player_name,
    c.club_name,
    SUM(ps.goals) AS player_goals,
    club_avg.avg_club_goals
FROM player_stats ps
JOIN players p ON ps.player_id = p.player_id
JOIN clubs c ON p.club_id = c.club_id
JOIN (
    SELECT 
        p2.club_id,
        AVG(ps2.goals) AS avg_club_goals
    FROM player_stats ps2
    JOIN players p2 ON ps2.player_id = p2.player_id
    GROUP BY p2.club_id
) club_avg ON p.club_id = club_avg.club_id
GROUP BY p.player_name, c.club_name, club_avg.avg_club_goals
HAVING player_goals > club_avg.avg_club_goals
ORDER BY player_goals DESC;

-- 9. Transfer market analysis with ROI (CTE)
WITH transfer_analysis AS (
    SELECT 
        p.player_name,
        p.market_value_millions AS current_value,
        t.transfer_fee_millions AS bought_for,
        c_from.club_name AS from_club,
        c_to.club_name AS to_club,
        t.transfer_date,
        ROUND(p.market_value_millions - t.transfer_fee_millions, 2) AS value_change,
        ROUND(((p.market_value_millions - t.transfer_fee_millions) / NULLIF(t.transfer_fee_millions, 0)) * 100, 2) AS roi_percentage
    FROM transfers t
    JOIN players p ON t.player_id = p.player_id
    JOIN clubs c_from ON t.from_club_id = c_from.club_id
    JOIN clubs c_to ON t.to_club_id = c_to.club_id
)
SELECT * FROM transfer_analysis
ORDER BY roi_percentage DESC;

-- 10. Head-to-head record between any two clubs
SELECT 
    c1.club_name AS home_team,
    c2.club_name AS away_team,
    SUM(m.home_goals) AS home_goals_total,
    SUM(m.away_goals) AS away_goals_total,
    COUNT(CASE WHEN m.home_goals > m.away_goals THEN 1 END) AS home_wins,
    COUNT(CASE WHEN m.home_goals = m.away_goals THEN 1 END) AS draws,
    COUNT(CASE WHEN m.home_goals < m.away_goals THEN 1 END) AS away_wins
FROM matches m
JOIN clubs c1 ON m.home_club_id = c1.club_id
JOIN clubs c2 ON m.away_club_id = c2.club_id
WHERE (m.home_club_id = 1 AND m.away_club_id = 3)
   OR (m.home_club_id = 3 AND m.away_club_id = 1)
GROUP BY c1.club_name, c2.club_name;

-- 11. PIVOT-style: Goals per player per match using CASE
SELECT 
    p.player_name,
    MAX(CASE WHEN ps.match_id = 1 THEN ps.goals ELSE 0 END) AS match_1_goals,
    MAX(CASE WHEN ps.match_id = 2 THEN ps.goals ELSE 0 END) AS match_2_goals,
    MAX(CASE WHEN ps.match_id = 3 THEN ps.goals ELSE 0 END) AS match_3_goals,
    MAX(CASE WHEN ps.match_id = 7 THEN ps.goals ELSE 0 END) AS match_7_goals,
    SUM(ps.goals) AS total_goals
FROM player_stats ps
JOIN players p ON ps.player_id = p.player_id
GROUP BY p.player_name
ORDER BY total_goals DESC;

-- 12. Find clubs with highest scoring home advantage
SELECT 
    c.club_name,
    ROUND(AVG(m.home_goals), 2) AS avg_home_goals,
    ROUND(AVG(m.away_goals), 2) AS avg_away_goals,
    ROUND(AVG(m.home_goals) - AVG(m.away_goals), 2) AS home_advantage_score
FROM matches m
JOIN clubs c ON m.home_club_id = c.club_id
GROUP BY c.club_name
ORDER BY home_advantage_score DESC;
