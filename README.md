# ⚽ Sports Analytics — SQL Project

**By:** Thejas Sharma | [thejasrhoades-speed](https://github.com/thejasrhoades-speed)  
**Tools:** MySQL · Advanced SQL · Window Functions · CTEs  
**Level:** Intermediate + Advanced  

---

## 📌 Project Overview

An end-to-end **Football Analytics SQL project** that models a real-world sports database covering players, clubs, matches, stats, and transfers. Uses advanced SQL techniques to extract deep performance insights.

---

## 🗄️ Database Schema

```
players ──────┐
clubs ─────────┼──── player_stats
matches ───────┘
transfers
```

| Table | Description |
|-------|-------------|
| `players` | Player profiles, nationality, market value |
| `clubs` | Club info, league, country, stadium |
| `matches` | Match results, scores, dates |
| `player_stats` | Goals, assists, passes, cards per match |
| `transfers` | Transfer fees, clubs, dates |

---

## 🟡 Intermediate Queries

| # | Query | Technique |
|---|-------|-----------|
| 1 | Top 5 goal scorers | GROUP BY, ORDER BY |
| 2 | Club win/draw/loss record | CASE WHEN, Aggregation |
| 3 | Avg pass accuracy by position | GROUP BY, ROUND |
| 4 | Most carded players | HAVING, SUM |
| 5 | Goals per league | JOIN, AVG |

---

## 🔴 Advanced Queries

| # | Query | Technique |
|---|-------|-----------|
| 6 | Rank players by goals per position | WINDOW FUNCTIONS (RANK, DENSE_RANK) |
| 7 | Running total goals per club | CTE + SUM OVER |
| 8 | Players above club average | Correlated Subquery |
| 9 | Transfer ROI analysis | CTE, NULLIF, ROI formula |
| 10 | Head-to-head club record | Multi-condition JOIN |
| 11 | Goals pivot per match | PIVOT with CASE WHEN |
| 12 | Home advantage analysis | AVG, GROUP BY |

---

## 💡 Key Insights

- 🏆 **Erling Haaland** leads scoring charts with highest goal contributions
- 🏠 **Home advantage** is strongest at Etihad Stadium
- 💰 **Kylian Mbappe** joined Real Madrid as the highest value transfer
- 🎯 **Midfielders** show highest pass accuracy across all positions

---

## 🚀 How to Run

```sql
-- 1. Run the full script in MySQL Workbench or any SQL client
-- 2. Execute queries section by section
-- 3. Modify WHERE clauses to explore different clubs/players
```

---

![SQL](https://img.shields.io/badge/SQL-Intermediate%20%2B%20Advanced-c9a84c?style=for-the-badge&logo=mysql&logoColor=white)
![Status](https://img.shields.io/badge/Status-Complete-green?style=for-the-badge)
