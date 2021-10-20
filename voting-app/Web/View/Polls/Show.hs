module Web.View.Polls.Show where
import Web.View.Prelude

data ShowView = ShowView { poll :: Include "options" Poll }

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
        <p>{poll}</p>
        <div>{forEach (get #options poll) renderOption}</div>
        |] where renderOption option = [hsx| <p>{get #optionLabel option}</p>
    |]


renderAddOption poll = case get #isReleased poll of
    True -> [hsx||]
    False -> [hsx|<a href={NewOptionAction (get #id poll)}>Add option</a>|]

renderAddVote poll = case get #isReleased poll of
    True -> [hsx|<a href={NewVoteAction (get #id poll)}>Add vote</a>|]
    False -> [hsx||]