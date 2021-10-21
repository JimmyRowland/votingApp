module Web.View.Static.Welcome where
import Web.View.Prelude

data WelcomeView = WelcomeView

instance View WelcomeView where
    html WelcomeView = [hsx|
           <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={PollsAction}>Polls</a></li>
            </ol>
        </nav>
        <div class="guide">
        <h1>Voting app</h1>
        <h2>Guide</h2>
        <p>1. Click poll at the top</p>
        <p>2. Click + New to create a new poll</p>
        <img src="/images/Screenshot from 2021-10-20 19-12-04.png">
        <p>3. Fill in poll name and click create poll</p>
        <img src="/images/Screenshot from 2021-10-20 19-12-42.png">
        <p>4. Click show link next to the poll you just created</p>
        <img src="/images/Screenshot from 2021-10-20 19-13-02.png">
        <p>5. Click add option</p>
        <img src="/images/Screenshot from 2021-10-20 19-13-18.png">
        <p>6. Add a few options</p>
        <img src="/images/Screenshot from 2021-10-20 19-13-38.png">
        <p>7. After you add enough options, click polls on header</p>
        <img src="/images/Screenshot from 2021-10-20 19-15-03.png">
        <p>8. Click edit link next the poll you created</p>
        <img src="/images/Screenshot from 2021-10-20 19-13-02.png">
        <p>9. check is released checkbox and click save poll</p>
        <img src="/images/Screenshot from 2021-10-20 19-15-30.png">
        <p>10. Click show link next to the poll you just created</p>
        <img src="/images/Screenshot from 2021-10-20 19-13-02.png">
        <p>11. click add vote link</p>
        <img src="/images/Screenshot from 2021-10-20 19-15-50.png">
        <p>12. Send the url to voters. Click create vote to start voting</p>
        <img src="/images/Screenshot from 2021-10-20 19-16-14.png">
        <p>13. select a candidate and click create rank to cast vote</p>
        <img src="/images/Screenshot from 2021-10-20 19-16-32.png">
        <p>14. you will see result on show poll page</p>
        <img src="/images/Screenshot from 2021-10-20 19-16-52.png">
        </div>


        
|]