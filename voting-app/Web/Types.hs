module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types

data WebApplication = WebApplication deriving (Eq, Show)


data StaticController = WelcomeAction deriving (Eq, Show, Data)

data PollsController
    = PollsAction
    | NewPollAction
    | ShowPollAction { pollId :: !(Id Poll) }
    | CreatePollAction
    | EditPollAction { pollId :: !(Id Poll) }
    | UpdatePollAction { pollId :: !(Id Poll) }
    | DeletePollAction { pollId :: !(Id Poll) }
    deriving (Eq, Show, Data)

data OptionsController
    = OptionsAction
    | NewOptionAction { pollId :: !(Id Poll) }
    | ShowOptionAction { optionId :: !(Id Option) }
    | CreateOptionAction
    | EditOptionAction { optionId :: !(Id Option) }
    | UpdateOptionAction { optionId :: !(Id Option) }
    | DeleteOptionAction { optionId :: !(Id Option) }
    deriving (Eq, Show, Data)

data VotesController
    = VotesAction
    | NewVoteAction
    | ShowVoteAction { voteId :: !(Id Vote) }
    | CreateVoteAction
    | EditVoteAction { voteId :: !(Id Vote) }
    | UpdateVoteAction { voteId :: !(Id Vote) }
    | DeleteVoteAction { voteId :: !(Id Vote) }
    deriving (Eq, Show, Data)

data RanksController
    = RanksAction
    | NewRankAction
    | ShowRankAction { rankId :: !(Id Rank) }
    | CreateRankAction
    | EditRankAction { rankId :: !(Id Rank) }
    | UpdateRankAction { rankId :: !(Id Rank) }
    | DeleteRankAction { rankId :: !(Id Rank) }
    deriving (Eq, Show, Data)
