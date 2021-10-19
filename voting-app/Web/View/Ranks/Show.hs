module Web.View.Ranks.Show where
import Web.View.Prelude

data ShowView = ShowView { rank :: Rank }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={RanksAction}>Ranks</a></li>
                <li class="breadcrumb-item active">Show Rank</li>
            </ol>
        </nav>
        <h1>Show Rank</h1>
        <p>{rank}</p>
    |]
