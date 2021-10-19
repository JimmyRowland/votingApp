module Web.View.Options.Index where
import Web.View.Prelude

data IndexView = IndexView { options :: [Option] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href={OptionsAction}>Options</a></li>
            </ol>
        </nav>
        <h1>Index <a href={pathTo NewOptionAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Option</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach options renderOption}</tbody>
            </table>
        </div>
    |]


renderOption :: Option -> Html
renderOption option = [hsx|
    <tr>
        <td>{option}</td>
        <td><a href={ShowOptionAction (get #id option)}>Show</a></td>
        <td><a href={EditOptionAction (get #id option)} class="text-muted">Edit</a></td>
        <td><a href={DeleteOptionAction (get #id option)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
