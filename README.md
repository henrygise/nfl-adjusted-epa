# Adjusted EPA/Play and EPA/Play Over Expected

Expected points added (EPA) puts into context each play in terms of points, so that we can better understand the true value of a given play. It can tell us how each team’s offense and defense performed through the 2021 season.

What EPA doesn’t capture is the quality of a team’s opponent. In 2021, a game with **0.3 EPA/Play** against Jacksonville was less impressive than one vs., say, Buffalo.

To account for this, we can find adjusted EPA values for each team using [Bud Davis’s ridge regression technique](https://blog.collegefootballdata.com/opponent-adjusted-stats-ridge-regression/). Essentially, each team’s true offensive and defensive performance is re-calculated in terms of EPA per play.

We'll use Ben Baldwin's EPA Model, which is visualized [here](https://rbsdm.com/stats/stats/) and detailed [here](https://www.opensourcefootball.com/posts/2020-09-28-nflfastr-ep-wp-and-cp-models/).

Shown below are **raw** (faded) and **adjusted** EPA/Play values from the 2021 NFL Season.

![all_teams_adjEPA](/../main/plot_images/adjEPA_all.png)

It’s evident that, especially throughout a full season, strength of schedule is somewhat consistent in the NFL (at least relative to the college level). That’s why we don’t see a ton of shifting from raw to adjusted.

The above values will allow us to look at game-level performance from an adjusted EPA standpoint.

Basically, we can assign each team’s adjusted defensive EPA/play to be the expectation (i.e., how we expect an average offense to perform against them). From there, we can say that any performance above/below this value is performance above/below **expectation** (or above/below **average**).

This puts into context a team’s offensive and defensive performance in each game and allows us to further control for opponent strength in team evaluation.

I want to note that a team’s average *EPA/Play over expected* and its *adjusted EPA/Play* are strongly correlated (r-squared = 0.85). This means that, in contextualizing these individual game performances, we’re not messing with season-long performances.

Let’s look at the Raiders’ offensive EPA/Play over expected for each game in 2021.

![lv_epa_plot](/../main/plot_images/plot_lv_ind.png)

With green lines representing performances above expectation and red being the opposite, Las Vegas’s huge bye-week drop-off jumps out. They only performed like an above-average team twice in the last 10 weeks of the season– week 12 in Dallas and week 17 in Indy.

Even in putting up 35 against the Chargers, they failed to exceed expectation.

Further, we can check out cumulative performance over expectation. In this case, we’ll look at the Raiders relative to every other playoff team.

![lv_epa_plot](/../main/plot_images/plot_lv_playoff.png)

We’re not only seeing where Vegas stands in relation to its playoff peers but how it got there. This method takes out any sort of “bad part of the schedule” arguments because it controls for a team’s schedule. It establishes, based on the opponent, how we would expect an average team would perform and uses this to determine true performance.

The same method can be applied to defense.

Let’s look at the Steelers’ defensive performance over expectation.

![stillers_ind](/../main/plot_images/plot_pit_def_ind.png)

We can see they closed out their playoff chase with their two best performances of the season, which actually might be better visualized if we look at it cumulatively.

![stillers playoff def](/../main/plot_images/plot_stillers_def_playoff.png)

Three of Pittsburgh’s last four games were well-above-average showings, which sort of (if you try hard enough) justifies their appearance in this year’s playoffs. In reality, nothing quite overshadows their horrendous offense.

![stillers off playoff](/../main/plot_images/plot_stillers_off_playoff.png)

By controlling for opponent strength, we get a better look at individual game performance and, in turn, a high-level view of the progression of each team’s season.
