module Web.View.Polls.Index where
import Web.View.Prelude

data IndexView = IndexView { polls :: [Poll] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href={PollsAction}>Polls</a></li>
            </ol>
        </nav>
        <h1>Index <a href={pathTo NewPollAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Poll</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach polls renderPoll}</tbody>
            </table>
        </div>
    |]


renderPoll :: Poll -> Html
renderPoll poll = [hsx|
    <tr>
        <td>{poll}</td>
        <td><a href={ShowPollAction (get #id poll)}>Show</a></td>
        <td><a href={EditPollAction (get #id poll)} class="text-muted">Edit</a></td>
        <td><a href={DeletePollAction (get #id poll)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
