module Web.View.Polls.Show where
import Web.View.Prelude

data ShowView = ShowView { poll :: Include "options" Poll, votes:: [Include "ranks" Vote]}

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={PollsAction}>Polls</a></li>
                <li class="breadcrumb-item active">Show Poll</li>
            </ol>
        </nav>
        <h1>{get #name poll}</h1>
        <p>{get #createdAt poll |> timeAgo}</p>
        {renderAddOption poll}
        {renderAddVote poll}
        <!-- <p>{forEach (get #ranks vote)}</p> -->
        <h3>options</h3>
        <div>{forEach (get #options poll) renderOption}</div>
        <h3>votes</h3>
        {renderVotes (get #options poll) votes}
        |] where renderOption option = [hsx| <p>{get #optionLabel option}</p>
    |]


renderAddOption poll = case get #isReleased poll of
    True -> [hsx||]
    False -> [hsx|<a href={NewOptionAction (get #id poll)}>Add option</a>|]

renderAddVote poll = case get #isReleased poll of
    True -> [hsx|<a href={NewVoteAction (get #id poll)}>Add vote</a>|]
    False -> [hsx||]


-- getOptionLabel :: (Eq a, Foldable t, HasField "id" model a,
--  HasField "optionLabel" (Maybe model) String) => t model -> a -> String
-- getOptionLabel options optionId = get #optionLabel (find (\option -> optionId == get #id option) options)
renderRank options rank = [hsx|<span>{(get #optionId rank)}---</span>|]

renderVote options vote = let ranks = get #ranks vote in [hsx| <div>{forEach ranks (renderRank options)}</div>|]

renderVotes options votes = [hsx| <div>{forEach votes (renderVote options)}</div>|]
