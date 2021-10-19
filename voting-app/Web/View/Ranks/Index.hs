module Web.View.Ranks.Index where
import Web.View.Prelude

data IndexView = IndexView { ranks :: [Rank] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href={RanksAction}>Ranks</a></li>
            </ol>
        </nav>
        <h1>Index <a href={pathTo NewRankAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Rank</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach ranks renderRank}</tbody>
            </table>
        </div>
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
