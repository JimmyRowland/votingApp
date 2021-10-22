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

We want to instead advocate for a ranked ballot system where voters rank their choices. The ranked choices of each voter is counted and starting from the first choice, if they make it past 50% of the total votes, they win. If not, then the party with the least votes gets eliminated and their first choice votes get reassigned to parties who are listed as the vote’s second choice. This process repeats until a party reaches past 50% of the total vote share, which means they have the majority.

Although this doesn’t tackle bigger issues to voting equality like gerrymandering, lobbying, campaign finance, etc. It is a process that can be fixed more easily due to it’s more technical nature of implementation (assuming that there is more social and political will to set that in motion). While each of the other issues are a Byzantine hydra that requires more capability than Haskell programming, a ranked voting system can be done through programming (albeit electronic, so that carries a whole new set of issues that we won’t be addressing here because we need a project to do).

We envision our full project will be a ranked ballot system where the user (voter) can rank the options in order from most to least wanted. They don’t have to fill out the entire ranked ballot. For example, if there are five options but a voter detests one of the options, then they can leave the fifth option blank.

## Minimal Viable Project

On the voting app, users will be able to create polls, add options to a poll, release a poll for voting, and rank options of a poll. When a user finishes voting, the user will see the condorcet/instant runoff/borda count winner.
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

[poll controller](https://github.com/JimmyRowland/votingApp/blob/99454c306784af2721bd9e65d23c63170f635f65/voting-app/Web/Controller/Polls.hs#L20-L29)

[rank controller](https://github.com/JimmyRowland/votingApp/blob/99454c306784af2721bd9e65d23c63170f635f65/voting-app/Web/Controller/Ranks.hs#L9-L29)

Here are some views created for the app

[poll by id page](https://github.com/JimmyRowland/votingApp/blob/99454c306784af2721bd9e65d23c63170f635f65/voting-app/Web/View/Polls/Show.hs#L6-L43)

[Create rank page](https://github.com/JimmyRowland/votingApp/blob/99454c306784af2721bd9e65d23c63170f635f65/voting-app/Web/View/Ranks/New.hs#L6-L29)

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

### How to test and run the code: Prolog

Replace this section with instructions to us for how to test and run your code.

Instructions coming soon, but we expect you'll use the [Prolog Unit Testing](https://www.swi-prolog.org/pldoc/doc_for?object=section(%27packages/plunit.html%27)) library for testing and that we'll be able to run your code with `swipl`.

