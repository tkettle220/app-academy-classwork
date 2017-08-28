# Go Fish

**Do not share this repo or post it publicly. We will take violations
very seriously.**

## Rules

* Rename this directory `first_name_last_name`.
* Do not use the Internet or any prior notes.

* You have **1 hour** for the assessment. Do not worry if you do not
  complete the entire assessment; finish as much as you can.
* Descriptions of each method to implement are written into the `lib/`
  files. For each `lib/` file, there is a corresponding `spec/` file.
* Run the specs as you solve the assessment. Solve the assessment in
  this order:

```
bundle exec rspec spec/card_spec.rb
bundle exec rspec spec/deck_spec.rb
bundle exec rspec spec/hand_spec.rb
bundle exec rspec spec/player_spec.rb
bundle exec rspec spec/game_spec.rb
bundle exec rspec spec
```

* Wait until you finish to run `bundle exec rspec spec`, which will
  run all the tests. Do this as a final check that you have them all
  passing.
* To run one specific spec, add `:line_number` at the end.  For example,
  `bundle exec rspec spec/hand_spec.rb:30`.
* If a failing spec confuses you, look at the spec file to see if you
  can discern what it is asking of you. There are sometimes comments
  in the spec files to help you.
* Please ask your TAs any questions. If you get stuck or don't know
  why something is failing; ask. TAs will let you know whether they
  can answer your question, so ask anything.
* To submit:
  * ZIP it (you can use OS X's built in zip functionality)
  * Use `.zip`; no boutique formats please :-)
  * Upload to progress tracker (http://progress.appacademy.io/).

## Game Rules

* Each player has a hand of cards.
* The goal is to have the most "books" (sets of 4-of-a-kind) at the end
  of the game.
* Play goes around in turns. On each turn:
  * The current player asks a target player for a card by value.
  * If the target player has any cards matching the requested value:
    * The current player takes those cards, and then takes another turn.
  * Otherwise:
    * The current player draws from the deck ("goes fish"), and the turn
      passes to the next player.
  * At the end of a player's turn, she removes any books from her hand
    and counts them toward her score.

Further game rules are described on [Wikipedia][go-fish-rules], but the
above is the limit of what you need to implement.

[go-fish-rules]: https://en.wikipedia.org/wiki/Go_Fish

**Copyright App Academy, please do not post online**
