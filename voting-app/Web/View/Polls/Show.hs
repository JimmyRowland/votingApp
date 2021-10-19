module Web.View.Polls.Show where
import Web.View.Prelude

data ShowView = ShowView { poll :: Poll }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={PollsAction}>Polls</a></li>
                <li class="breadcrumb-item active">Show Poll</li>
            </ol>
        </nav>
        <h1>Show Poll</h1>
        <p>{poll}</p>
    |]
