## Loading the data

We just read the train.csv file. This contains a lot of data. We also
make some variables to describe the columns of the data set.

``` r
matches <- read.csv("matches_train.csv")
columns <- colnames(matches)
columns_for_game <- columns[grepl("[0-9]", columns) == FALSE]
columns_for_prev_game <- columns[grepl("[0-9]", columns) == TRUE]
unique_cols_for_prev <- unique(gsub("_[0-9]+", "", columns_for_prev_game))
```

## Definitions of Columns

### Per game

For each game, there is some data about the game itself.

``` r
library(tidyverse)
```

    ## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.1 ──

    ## ✓ ggplot2 3.3.5     ✓ purrr   0.3.4
    ## ✓ tibble  3.1.6     ✓ dplyr   1.0.8
    ## ✓ tidyr   1.2.0     ✓ stringr 1.4.0
    ## ✓ readr   2.1.2     ✓ forcats 0.5.1

    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
columns_for_game
```

    ##  [1] "X"                  "id"                 "target"            
    ##  [4] "home_team_name"     "away_team_name"     "match_date"        
    ##  [7] "league_name"        "league_id"          "is_cup"            
    ## [10] "home_team_coach_id" "away_team_coach_id"

#### id

Just a unique id for the game

``` r
head(matches["id"])
```

    ##         id
    ## 1 11906497
    ## 2 11983301
    ## 3 11983471
    ## 4 11883005
    ## 5 11974168
    ## 6 11974170

#### target

The variable you have to predict the probabilities only available in the
train set.

``` r
head(matches["target"])
```

    ##   target
    ## 1   away
    ## 2   draw
    ## 3   away
    ## 4   home
    ## 5   draw
    ## 6   home

#### home_team_name

Just a unique id for the game

``` r
head(matches["home_team_name"])
```

    ##       home_team_name
    ## 1  Newell's Old Boys
    ## 2              UPNFM
    ## 3               León
    ## 4     Cobán Imperial
    ## 5 Hawke's Bay United
    ## 6    Team Wellington

``` r
matches %>% count(home_team_name, sort=TRUE) %>% head()
```

    ##   home_team_name  n
    ## 1     Al Ittihad 81
    ## 2    River Plate 60
    ## 3        Rangers 53
    ## 4         Gorica 52
    ## 5       Juventus 52
    ## 6        Al Ahli 51

#### away_team_name

The name of the Away the team. Hidden in test set, see this discussion

``` r
head(matches["away_team_name"])
```

    ##      away_team_name
    ## 1       River Plate
    ## 2          Marathón
    ## 3           Morelia
    ## 4            Iztapa
    ## 5   Eastern Suburbs
    ## 6 Canterbury United

``` r
matches %>% count(away_team_name, sort=TRUE) %>% head()
```

    ##   away_team_name  n
    ## 1     Al Ittihad 71
    ## 2    River Plate 71
    ## 3      Liverpool 55
    ## 4        Olimpia 52
    ## 5        Rangers 52
    ## 6        Al Ahli 51

#### match_date

The match date (UTC).

``` r
head(matches["match_date"])
```

    ##            match_date
    ## 1 2019-12-01 00:45:00
    ## 2 2019-12-01 01:00:00
    ## 3 2019-12-01 01:00:00
    ## 4 2019-12-01 01:00:00
    ## 5 2019-12-01 01:00:00
    ## 6 2019-12-01 01:00:00

Use Lubridate to parse the dates from a string.

``` r
library(lubridate)
```

    ## 
    ## Attaching package: 'lubridate'

    ## The following objects are masked from 'package:base':
    ## 
    ##     date, intersect, setdiff, union

``` r
dates <- parse_date_time(matches$match_date, "ymdHMS")
sprintf("earliest date: %s", min(dates))
```

    ## [1] "earliest date: 2019-12-01 00:45:00"

``` r
sprintf("most recent date: %s", max(dates))
```

    ## [1] "most recent date: 2021-05-01"

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](summary_files/figure-markdown_github/unnamed-chunk-11-1.png)

#### league_name

The league name.

``` r
head(matches["league_name"])
```

    ##     league_name
    ## 1     Superliga
    ## 2 Liga Nacional
    ## 3       Liga MX
    ## 4 Liga Nacional
    ## 5   Premiership
    ## 6   Premiership

``` r
matches %>% count(league_name, sort=TRUE) %>% head()
```

    ##        league_name    n
    ## 1   Premier League 4711
    ## 2  Club Friendlies 3163
    ## 3 Primera Division 2020
    ## 4     Super League 1317
    ## 5          3. Liga 1118
    ## 6          Ligue 1 1019

#### league_id

The league id. Note that league names can be identical for two different
id.

``` r
head(matches["league_id"])
```

    ##   league_id
    ## 1       636
    ## 2       734
    ## 3       743
    ## 4       705
    ## 5      1055
    ## 6      1055

#### is_cup

If the value is 1 the match is played for a cup competition.

``` r
matches %>% count(is_cup, sort=TRUE)
```

    ##   is_cup     n
    ## 1  False 86590
    ## 2   True  7707
    ## 3            1

#### home_team_coach_id

The id of the Home team coach.

``` r
head(matches["home_team_coach_id"])
```

    ##   home_team_coach_id
    ## 1             468196
    ## 2            2510608
    ## 3            1552508
    ## 4             429958
    ## 5           37350025
    ## 6           37347427

#### away_team_coach_id

The id of the Away team coach.

``` r
head(matches["away_team_coach_id"])
```

    ##   away_team_coach_id
    ## 1             468200
    ## 2             456313
    ## 3             465797
    ## 4             426870
    ## 5           37350668
    ## 6           37348899

### History

For each game there is also data about the last 10 games for both the
home and away team. These are the same for both the home and away team,
so we’ll just look at them for the last game of the home team.

``` r
unique_cols_for_prev
```

    ##  [1] "home_team_history_match_date"      "home_team_history_is_play_home"   
    ##  [3] "home_team_history_is_cup"          "home_team_history_goal"           
    ##  [5] "home_team_history_opponent_goal"   "home_team_history_rating"         
    ##  [7] "home_team_history_opponent_rating" "home_team_history_coach"          
    ##  [9] "home_team_history_league_id"       "away_team_history_match_date"     
    ## [11] "away_team_history_is_play_home"    "away_team_history_is_cup"         
    ## [13] "away_team_history_goal"            "away_team_history_opponent_goal"  
    ## [15] "away_team_history_rating"          "away_team_history_opponent_rating"
    ## [17] "away_team_history_coach"           "away_team_history_league_id"

#### home_team_history_match_date_1

The date of the last match played by Home team.

``` r
head(matches["home_team_history_match_date_1"])
```

    ##   home_team_history_match_date_1
    ## 1            2019-11-26 00:10:00
    ## 2            2019-11-28 01:15:00
    ## 3            2019-11-28 01:00:00
    ## 4            2019-11-27 18:00:00
    ## 5            2019-11-24 01:00:00
    ## 6            2019-11-24 01:00:00

#### home_team_history_is_play_home_1

If 1, the Home team played home.

``` r
head(matches["home_team_history_is_play_home_1"])
```

    ##   home_team_history_is_play_home_1
    ## 1                                0
    ## 2                                0
    ## 3                                0
    ## 4                                0
    ## 5                                0
    ## 6                                0

#### home_team_history_is_cup_1

If 1, the match was a cup competition.

``` r
head(matches["home_team_history_is_cup_1"])
```

    ##   home_team_history_is_cup_1
    ## 1                          0
    ## 2                          0
    ## 3                          0
    ## 4                          0
    ## 5                          0
    ## 6                          0

#### home_team_history_goal_1

The number of goals scored by the Home team on its last match.

``` r
head(matches["home_team_history_goal_1"])
```

    ##   home_team_history_goal_1
    ## 1                        0
    ## 2                        3
    ## 3                        3
    ## 4                        1
    ## 5                        2
    ## 6                        0

#### home_team_history_opponent_goal_1

The number of goals conceded by the Home team on its last match.

``` r
head(matches["home_team_history_opponent_goal_1"])
```

    ##   home_team_history_opponent_goal_1
    ## 1                                 1
    ## 2                                 1
    ## 3                                 3
    ## 4                                 2
    ## 5                                 2
    ## 6                                 1

#### home_team_history_rating_1

The rating of the Home team on its last match (pre match rating).

``` r
head(matches["home_team_history_rating_1"])
```

    ##   home_team_history_rating_1
    ## 1                   3.856860
    ## 2                   5.736719
    ## 3                   5.998800
    ## 4                   6.295743
    ## 5                   6.936700
    ## 6                  11.160533

#### home_team_history_opponent_rating_1

The rating of the opponent team on Home team last match (pre match
rating).

``` r
head(matches["home_team_history_opponent_rating_1"])
```

    ##   home_team_history_opponent_rating_1
    ## 1                            5.199840
    ## 2                            6.825194
    ## 3                            5.998800
    ## 4                            5.535514
    ## 5                           11.379750
    ## 6                            3.613117

#### home_team_history_coach_1

The coach id of the Home team on its last match.

``` r
head(matches["home_team_history_coach_1"])
```

    ##   home_team_history_coach_1
    ## 1                    468196
    ## 2                   2510608
    ## 3                   1552508
    ## 4                    429958
    ## 5                  37350025
    ## 6                  37347427

#### home_team_history_league_id_1

The league name id by the Home team on its last match.

``` r
head(matches["home_team_history_league_id_1"])
```

    ##   home_team_history_league_id_1
    ## 1                           636
    ## 2                           734
    ## 3                           743
    ## 4                           705
    ## 5                          1055
    ## 6                          1055
