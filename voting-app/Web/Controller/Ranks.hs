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

    action NewRankAction = do
        let rank = newRecord
        render NewView { .. }

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
                Left rank -> render NewView { .. } 
                Right rank -> do
                    rank <- rank |> createRecord
                    setSuccessMessage "Rank created"
                    redirectTo RanksAction

    action DeleteRankAction { rankId } = do
        rank <- fetch rankId
        deleteRecord rank
        setSuccessMessage "Rank deleted"
        redirectTo RanksAction

buildRank rank = rank
    |> fill @["optionId","voteId","rank"]
