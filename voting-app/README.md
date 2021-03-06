# CPSC 312 Project

# Voting App

The voting app is a website where users can create polls, cast votes, and see the results of a poll. Results can be calculated using different algorithms such as FPTP, instant runoff, or condorcet method.


## Team Members

Our team is:

+ Audrey Lu (student # 41655101)
+ Yu Tian (student # 42474049)
+ Nancy Ye (student # 10906550)
+ Yuchen Rao  (student # 12101614): Eddie

We call ourselves: optional awesome team name.

## Product Pitch

Currently, a lot of voting systems are flawed because depending on how many options are available and how similar those options are to each other, voters end up voting for the option they least want due to vote splitting. Although in national elections, there are other ways of voting that don’t include voting for a candidate belonging to a party. For example, in some countries, voters cast points and the party with the least points wins. In Canada, the voting system is first past the post which means that the party that gets the most votes wins the election. This is regardless of the percentage of voters that did not vote for them. This means that the actual voter choice was not well captured in the election. This is further exacerbated by the issue of vote splitting.

We want to instead advocate for an Instant Run-off version of the ranked ballot system where voters rank their choices. The ranked choices of each voter is counted and starting from the first choice, if they make it past 50% of the total votes, they win. If not, then the party with the least votes gets eliminated and their first choice votes get reassigned to parties who are listed as the vote’s second choice. This process repeats until a party reaches past 50% of the total vote share, which means they have the majority.

Although this doesn’t tackle bigger issues to voting equality like gerrymandering, lobbying, campaign finance, etc. It is a process that can be fixed more easily due to it’s more technical nature of implementation (assuming that there is more social and political will to set that in motion). While each of the other issues are a Byzantine hydra that requires more capability than Haskell programming, a ranked voting system can be done through programming (albeit electronic, so that carries a whole new set of issues that we won’t be addressing here because we need a project to do).

We envision our full project will be a ranked ballot system where the user (voter) can rank the options in order from most to least wanted. They don’t have to fill out the entire ranked ballot. For example, if there are five options but a voter detests one of the options, then they can leave the fifth option blank.

## Minimal Viable Project

We will be using an IHP web framework to build a virtual polling web application. A user will be able to create polls, add options to the poll, and open up polling for other users, who will then be able to vote for their preferred options. The polling method we will use includes two methods of counting votes, the Condorcet method and the Borda Count method.

After users have finished voting, the Condorcet method ([implementation](https://github.students.cs.ubc.ca/tfoolery/CPSC-312-project/blob/abcadd78f532bd0b50ed7f00fe5707878ec0237f/voting-app/Web/Controller/Polls.hs#L85-L116)) will be applied to the collected votes. For this method, a winner is selected after analyzing all possible pairs of options. For example, if there are three options, A, B, and C, then the three possible pairs are (A,B), (B,C), and (A,C). If A is more popular than B, then we look at (B,C). If C is more popular than B, then C wins and B is eliminated. Finally, we look at the comparison between A and C to determine the overall winner.

In the case that the Condorcet method results in a tie, the Borda Count method([implementation](https://github.students.cs.ubc.ca/tfoolery/CPSC-312-project/blob/abcadd78f532bd0b50ed7f00fe5707878ec0237f/voting-app/Web/Controller/Polls.hs#L124-L141)) is used to pick the top two winners. Borda Count is a method where each ranked choice is assigned a number of points. For example, in a poll that has five options, a first ranked choice is given 0 points per vote, second is given 1 points, and so on and so forth so that last place is given 4 points per vote and options that are not ranked get 5 points per vote. For each option, the number of voters that gave it a particular rank is multiplied by the number of points that rank is worth. For example, if Option A has 5 first choice votes, 3 second choice votes, 10 third choice votes, 1 fourth choice vote, and 2 fifth choice votes, then it gets (0 points/vote * 5 votes)+(1 points/vote * 3 votes)+(2 points/vote * 10 votes)+(3 points/vote * 1 vote)+(4 point/vote * 2 votes) = 34 points for Option A. This process is repeated for all other options such that the option with the least number of points wins overall.

After top two Borda count winners are decided, a runoff ([implementation](https://github.students.cs.ubc.ca/tfoolery/CPSC-312-project/blob/abcadd78f532bd0b50ed7f00fe5707878ec0237f/voting-app/Web/Controller/Polls.hs#L118-L122)) between two winners is used to pick the final winner. To get the runoff winner, all options other than two Borda winners are removed from all votes. The option that gets more votes will be the winner.

We have decided to do Condorcet and Star voting (first Borda count/score then runoff) for our ranked voting system because Instant Run-off, as described in the product pitch, is too complex to implement for a minimal viable product. The Condorcet and Borda methods can be implemented and put in use much faster to create a ranked voting system.
 
While implementing MVP, We did some minor updates on Borda count implementation and added a final runoff to minimize the effect of strategic voting.
### Further reading: 
* [Condorcet Voting](https://www.opavote.com/methods/condorcet-voting)
* [Borda Count](https://www2.math.upenn.edu/~deturck/m170/wk10/lecture/vote2.html) 
* [Star voting](https://en.wikipedia.org/wiki/STAR_voting)

Haskell is great for data processing and web servers where most data structures are immutable and IHP is great framework for beginner. It is highly opinionated, teaches users how to write class/interface/data types, and also teaches the downside of lazy evaluation in web env. Additionally, it gives many interesting abstractions like piping and type application, and also utilizes hsx syntax. The framework also demonstrate how code generation is possible with Haskell.

[Piping |>](https://github.com/JimmyRowland/votingApp/blob/99454c306784af2721bd9e65d23c63170f635f65/voting-app/Web/Controller/Polls.hs#L24-L26)

[Immutable data structure set](https://github.com/JimmyRowland/votingApp/blob/99454c306784af2721bd9e65d23c63170f635f65/voting-app/Web/Controller/Ranks.hs#L15-L16)

[Bang operator !](https://github.com/JimmyRowland/votingApp/blob/99454c306784af2721bd9e65d23c63170f635f65/voting-app/Web/Types.hs#L15)

[Type application @](https://github.com/JimmyRowland/votingApp/blob/99454c306784af2721bd9e65d23c63170f635f65/voting-app/Web/Controller/Ranks.hs#L69-L70)

[HSX](https://github.com/JimmyRowland/votingApp/blob/99454c306784af2721bd9e65d23c63170f635f65/voting-app/Web/View/Polls/Show.hs#L6-L25)

## Proof of Concept

Click [Demo](https://onwnaiaphfjekhzifptgaqlfzzkdjsji.ihpapp.com/) to visit the app

The proof of concept focuses on poll creation and casting vote.

Here are some example actions created for the app

See inline comments for what we did

[poll controller](https://github.students.cs.ubc.ca/tfoolery/CPSC-312-project/blob/7d8cce64f5b58f1764af4af494950a0d2b8597eb/voting-app/Web/Controller/Polls.hs#L21-L32)

[rank controller](https://github.students.cs.ubc.ca/tfoolery/CPSC-312-project/blob/7d8cce64f5b58f1764af4af494950a0d2b8597eb/voting-app/Web/Controller/Ranks.hs#L10-L30)

Here are some views created for the app

[poll by id page](https://github.students.cs.ubc.ca/tfoolery/CPSC-312-project/blob/7d8cce64f5b58f1764af4af494950a0d2b8597eb/voting-app/Web/View/Polls/Show.hs#L6-L45)

[Create rank page](https://github.students.cs.ubc.ca/tfoolery/CPSC-312-project/blob/7d8cce64f5b58f1764af4af494950a0d2b8597eb/voting-app/Web/View/Ranks/New.hs#L1-L31)

The most difficult part of the app is to set up the web server, creating controllers, linking pages.
It's always difficult to understand haskell data structures and applicable interfaces.
Most of the minimum requirements and challenging parts are completed. To finish the MVP, we only need to parse the poll data structure, implement condorcet method / instant runoff, and display the result.
(Result is displayed as option id at the moment)

### How to test and run the code: Haskell

Browser:

Click [Demo](https://onwnaiaphfjekhzifptgaqlfzzkdjsji.ihpapp.com/) to visit the app

Ubuntu:

install curl

```
sudo apt install curl
```

install nix

```
curl -L https://nixos.org/nix/install | sh
```

run

```
nano ~/.bashrc
```

Add following at the bottom

```
. ~/.nix-profile/etc/profile.d/nix.sh
```

run following to set environment variables
```
. ~/.nix-profile/etc/profile.d/nix.sh
```

install ihp
```
nix-env -f https://downloads.digitallyinduced.com/ihp-new.tar.gz -i ihp-new
```

restart OS

Open terminal under disposable directory run

```
ihp-new blog
```

Choose y n y for the following questions.



Open terminal under voting-app dir and run
```
./start
```

[Go to http://localhost:8000/](http://localhost:8000/) to visit the app

Follow the instruction on front page to create polls

### Appendix
[Proposal readme](https://github.students.cs.ubc.ca/tfoolery/CPSC-312-project/tree/d35d7d4e5cbf3478b9782b3fdb5b63d28c4ec6e5/voting-app)
