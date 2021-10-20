module Web.View.Votes.Index where
import Web.View.Prelude

data IndexView = IndexView { votes :: [Vote] }

instance View IndexView where
    html IndexView { .. } = [hsx||]


renderVote :: Vote -> Html
renderVote vote = [hsx|
    <tr>
        <td>{vote}</td>
        <td><a href={ShowVoteAction (get #id vote)}>Show</a></td>
        <td><a href={EditVoteAction (get #id vote)} class="text-muted">Edit</a></td>
        <td><a href={DeleteVoteAction (get #id vote)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
