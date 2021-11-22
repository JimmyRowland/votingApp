module Web.Controller.Ranks where

import Web.Controller.Prelude
import Web.View.Ranks.Index
import Web.View.Ranks.New
import Web.View.Ranks.Edit
import Web.View.Ranks.Show

instance Controller RanksController where
    action RanksAction = do
        ranks <- query @Rank |> fetch
        render IndexView { .. }
    
    -- Create a record for a single ranked option and go to the next rank creation page or poll by id page
    action NewRankAction {voteId} = do
        let rank = newRecord
                |> set #voteId voteId
        vote <- fetch voteId
            >>= fetchRelated #ranks
        poll <- fetch (get #pollId vote)
            >>= fetchRelated #options

        -- Filter out ranked options
        let options = getRemainingOptions (get #ranks vote) (get #options poll)
        
        let isLastOption = length (get #ranks vote) == length (get #options poll)

        if isLastOption
            then (redirectTo ShowPollAction {pollId = (get #pollId vote)})
            else render NewView { .. }

    action ShowRankAction { rankId } = do
        rank <- fetch rankId
        render ShowView { .. }

    action EditRankAction { rankId } = do
        rank <- fetch rankId
        render EditView { .. }

    action UpdateRankAction { rankId } = do
        rank <- fetch rankId
        rank
            |> buildRank
            |> ifValid \case
                Left rank -> render EditView { .. }
                Right rank -> do
                    rank <- rank |> updateRecord
                    setSuccessMessage "Rank updated"
                    redirectTo EditRankAction { .. }

    action CreateRankAction = do
        let rank = newRecord @Rank
        rank
            |> buildRank
            |> ifValid \case
                Left rank -> do 
                    vote <- fetch (get #voteId rank)
                    redirectTo ShowPollAction {pollId = (get #pollId vote)}  
                Right rank -> do
                    vote <- fetch (get #voteId rank)
                        >>= fetchRelated #ranks
                    rank <- rank |> set #rank (length (get #ranks vote)) |> createRecord
                    setSuccessMessage "Rank created"
                    redirectTo NewRankAction {voteId= (get #voteId rank) }

    action DeleteRankAction { rankId } = do
        rank <- fetch rankId
        deleteRecord rank
        setSuccessMessage "Rank deleted"
        redirectTo RanksAction

buildRank rank = rank
    |> fill @["optionId","voteId","rank"]
    |> validateField #optionId nonEmpty

getRemainingOptions ranks = filter (not. (contains ranks))

contains [] option = False
contains (rank:ranks) option = (get #id option == get #optionId rank) || contains ranks option