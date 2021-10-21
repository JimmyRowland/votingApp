module Web.View.Ranks.Index where
import Web.View.Prelude

data IndexView = IndexView { ranks :: [Rank] }

instance View IndexView where
    html IndexView { .. } = [hsx|
    |]


renderRank :: Rank -> Html
renderRank rank = [hsx|
    <tr>
        <td>{rank}</td>
        <td><a href={ShowRankAction (get #id rank)}>Show</a></td>
        <td><a href={EditRankAction (get #id rank)} class="text-muted">Edit</a></td>
        <td><a href={DeleteRankAction (get #id rank)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
