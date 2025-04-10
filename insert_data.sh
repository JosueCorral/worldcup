#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT W_G O_G
do
  if [[ $YEAR != "year" ]]
  then
    # find if Winner exist
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
  
    #validate if exist
    if [[ -z $TEAM_ID ]]
    then
      #insert
      INSERT_TEAM=$($PSQL "INSERT INTO teams(name) VALUES ('$WINNER');")
      if [[ $INSERT_TEAM == "INSERT 0 1" ]]
      then
      echo "$INSERT_TEAM"
      fi
    fi
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
  
    #validate if exist
    if [[ -z $TEAM_ID ]]
    then
      #insert
      INSERT_TEAM=$($PSQL "INSERT INTO teams(name) VALUES ('$OPPONENT');")
      if [[ $INSERT_TEAM == "INSERT 0 1" ]]
      then
      echo "$INSERT_TEAM"
      fi
    fi 

    #INSERT in games
    W_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    O_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
        
      #insert
      INSERT_GAME=$($PSQL "INSERT INTO games(year, winner_id, opponent_id, winner_goals, opponent_goals, round) VALUES ('$YEAR','$W_ID','$O_ID','$W_G','$O_G','$ROUND');")
      if [[ $INSERT_GAME == "INSERT 0 1" ]]
      then
      echo "$INSERT_GAME"
      fi

  fi
done



#INSERT 0 1
