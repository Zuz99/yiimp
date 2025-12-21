<?php
$algo = user()->getState('yaamp-algo');

JavascriptFile("/extensions/jqplot/jquery.jqplot.js");
JavascriptFile("/extensions/jqplot/plugins/jqplot.dateAxisRenderer.js");
JavascriptFile("/extensions/jqplot/plugins/jqplot.barRenderer.js");
JavascriptFile("/extensions/jqplot/plugins/jqplot.highlighter.js");
JavascriptFile("/extensions/jqplot/plugins/jqplot.cursor.js");
JavascriptFile('/yaamp/ui/js/auto_refresh.js');

$height = '240px';

$min_payout = floatval(YAAMP_PAYMENTS_MINI);
$min_sunday = $min_payout / 10;

$payout_freq = (YAAMP_PAYMENTS_FREQ / 3600) . " hours";
?>

<div id='resume_update_button' class="alert alert-warning text-center mx-3 my-3" style="display:none; cursor:pointer;" onclick='auto_page_resume();'><strong>Auto refresh is paused</strong> — click to resume.</div>

<div class="container-xxl py-3">
  <div class="row g-4">
    <div class="col-lg-6">

    <div class="row g-3 mb-3">
      <div class="col-md-6">
        <div class="card yiimp-card h-100">
          <div class="card-body">
            <div class="d-flex align-items-center justify-content-between">
              <div>
                <div class="text-body-secondary small">Payout Frequency</div>
                <div class="fs-5 fw-semibold"><?= $payout_freq ?></div>
              </div>
              <div class="yiimp-metric-icon"><i class="bi bi-hourglass-split"></i></div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-md-6">
        <div class="card yiimp-card h-100">
          <div class="card-body">
            <div class="d-flex align-items-center justify-content-between">
              <div>
                <div class="text-body-secondary small">Minimum Payout</div>
                <div class="fs-5 fw-semibold"><?= $min_payout ?></div>
              </div>
              <div class="yiimp-metric-icon"><i class="bi bi-cash-coin"></i></div>
            </div>
          </div>
        </div>
      </div>
    </div>


<!--  -->

<div class="main-left-box">
<div class="main-left-title"><?=YAAMP_SITE_URL?></div>
<div class="main-left-inner">

<ul>

<li>Welcome to <?=YAAMP_SITE_URL?>! </li>
<li>This fork was based on the yaamp source code and is now an open source project.</li>
<li>No registration is required, we do payouts in the currency you mine. Use your wallet address as the username.</li>
<li>Payouts are made automatically every <?= $payout_freq ?> for all balances above <b><?= $min_payout ?></b>, or <b><?= $min_sunday ?></b> on Sunday.</li>
<li>For some coins, there is an initial delay before the first payout, please wait at least 6 hours before asking for support.</li>
<li>Blocks are distributed proportionally among valid submitted shares.</li>

<br/>

</ul>
</div></div>
<br/>

<!-- Stratum Auto generation code, will automatically add coins when they are enabled and auto ready -->

<div class="main-left-box">
<div class="main-left-title">How to mine with <?=YAAMP_SITE_URL?></div>
<div class="main-left-inner">

<div class="table-responsive"><table class="table table-sm align-middle">
	<thead>
		<tr>
			<th>Stratum Location</th>
			<th>Choose Coin</th>
			<th>Your Wallet Address</th>
			<th>Rig (opt.)</th>
			<th>Type</th>
		</tr>
	</thead>

<tbody>
	<tr>
		<td>
			<select id="drop-stratum" class="form-select form-select-sm font-monospace" onchange="generate()">

			<!-- Add your stratum locations here -->
			<option value="">Main Stratum</option>
			<!--<option value="mine.">Asia Stratum</option>
			<option value="eu.">Europe Stratum</option>
			<option value="cad.">CAD Stratum</option>
			<option value="uk.">UK Stratum</option> -->
			</select>
		</td>

		<td>
			<select id="drop-coin" class="form-select form-select-sm font-monospace" onchange="generate()">
       <?php
$list = getdbolist('db_coins', "enable and visible and auto_ready order by algo asc");

if (!$list) {
    echo "<option disabled>No Coins Available</option>";
} else {
    $algoheading = "";
    $count = 0;

    foreach ($list as $coin) {
        $name = substr($coin->name, 0, 18);
        $symbol = $coin->getOfficialSymbol();
        $algo = $coin->algo;
        $auto_exchange = isset($coin->auto_exchange) ? $coin->auto_exchange : 1; // Default to 1 if null

        $port_db = getdbosql('db_stratums', "algo=:algo and symbol=:symbol", [
            ':algo' => $algo,
            ':symbol' => $symbol
        ]);

        $port = $port_db ? $port_db->port : '0000';

        // Add algorithm headings correctly
        if ($count == 0 || $algo != $algoheading) {
            echo "<option disabled='disabled'>$algo</option>";
        }

        // Append mc=SYMBOL only if auto_exchange is 0
        $mc_param = ($auto_exchange == 0) ? ",mc=$symbol" : "";

        echo "<option value='$symbol' data-port='$port' data-algo='-a $algo' data-symbol='$symbol' data-extra='-p c=$symbol$mc_param'>$name ($symbol)</option>";

        $count++;
        $algoheading = $algo;
    }
}
?>

			</select>
		</td>
		<td>
			<input id="text-wallet" type="text" class="form-control form-control-sm font-monospace" placeholder="WALLET_ADDRESS" onkeyup="generate()">
		</td>
		<td>
			<input id="text-rig-name" type="text" class="form-control form-control-sm font-monospace" placeholder="WORKER_NAME" onkeyup="generate()">
		</td>
		<td>
			<select id="drop-solo" class="form-select form-select-sm font-monospace" onchange="generate()">
			<option value="">Shared</option>
			<option value=",m=solo">Solo</option>
			</select>
		</td>
	
</tbody>
<tbody>
	<tr>
		<td colspan="5"><p class="yiimp-command font-monospace mb-0" id="output">-a  -o stratum+tcp://<?=YAAMP_STRATUM_URL?>:0000 -u . -p c=</p></td>
	</tr>
</tbody>
</table></div>

<ul class="mt-3">
<li>&lt;WALLET_ADDRESS&gt; must be valid for the currency you mine. <b>DO NOT USE a BTC address here, the auto exchange is disabled on these stratums</b>!</li>
<!-- <li><b>Our stratums are now NiceHASH compatible and ASICBoost enabled, please message support if you have any issues.</b></li> -->
<li>See the "<?=YAAMP_SITE_NAME?> coins" area on the right for PORT numbers. You may mine any coin regardless if the coin is enabled or not for autoexchange. Payouts will only be made in that coins currency.</li>
<li>Payouts are made automatically every hour for all balances above <b><?=$min_payout?></b>, or <b><?=$min_sunday?></b> on Sunday.</li>
<br>
</ul>
</div></div><br>

<!-- End new stratum generation code  -->

<div class="main-left-box">
<div class="main-left-title"><?=YAAMP_SITE_URL?> Links</div>
<div class="main-left-inner">

<ul>

<li><b>API</b> - <a href='/site/api'>http://<?=YAAMP_SITE_URL?>/site/api</a></li>
<li><b>Difficulty</b> - <a href='/site/diff'>http://<?=YAAMP_SITE_URL?>/site/diff</a></li>
<?php
if (YIIMP_PUBLIC_BENCHMARK):
?>
<li><b>Benchmarks</b> - <a href='/site/benchmarks'>http://<?=YAAMP_SITE_URL?>/site/benchmarks</a></li>
<?php
endif;
?>

<?php
if (YAAMP_ALLOW_EXCHANGE):
?>
<li><b>Algo Switching</b> - <a href='/site/multialgo'>http://<?=YAAMP_SITE_URL?>/site/multialgo</a></li>
<?php
endif;
?>

<br>

</ul>
</div></div><br>

<div class="main-left-box">
<div class="main-left-title"><?=YAAMP_SITE_URL?> Support</div>
<div class="main-left-inner">

<ul class="social-icons">
<!--    <li><a href="http://www.facebook.com"><img src='/images/Facebook.png' /></a></li>
    <li><a href="http://www.twitter.com"><img src='/images/Twitter.png' /></a></li>
    <li><a href="http://www.youtube.com"><img src='/images/YouTube.png' /></a></li>
    <li><a href="http://www.github.com"><img src='/images/Github.png' /></a></li> -->
    <li><a href="https://discord.gg/DrsrWQh3qC"><img src='/images/discord.png' /></a></li>
</ul>

</div></div><br>

    </div>
    <div class="col-lg-6">
      <div id='pool_current_results' class="yiimp-ajax-block">
  <div class="card yiimp-card">
    <div class="card-body placeholder-glow">
      <div class="d-flex align-items-center justify-content-between">
        <span class="placeholder col-6"></span>
        <span class="placeholder col-2"></span>
      </div>
      <div class="mt-3">
        <span class="placeholder col-12"></span>
        <span class="placeholder col-10"></span>
        <span class="placeholder col-8"></span>
      </div>
    </div>
  </div>
</div>

      <div id='pool_history_results' class="yiimp-ajax-block mt-4">
        <div class="yiimp-skeleton"></div>
      </div>

      <div id='pool_coins_info' class="yiimp-ajax-block mt-4">
        <div class="yiimp-skeleton"></div>
      </div>

    </div>
  </div>
</div>

<script>

function page_refresh()
{
    pool_current_refresh();
    pool_history_refresh();
	pool_coins_info_refresh();

}

function select_algo(algo)
{
    window.location.href = '/site/algo?algo='+algo+'&r=/';
}

////////////////////////////////////////////////////

function pool_current_ready(data)
{
    $('#pool_current_results').html(data);
}

function pool_current_refresh()
{
    var url = "/site/current_results";
    $.get(url, '', pool_current_ready);
}

////////////////////////////////////////////////////

function pool_history_ready(data)
{
    $('#pool_history_results').html(data);
}

function pool_history_refresh()
{
    var url = "/site/history_results";
    $.get(url, '', pool_history_ready);
}

////////////////////////////////////////////////////

function pool_coins_info_ready(data)
{
    $('#pool_coins_info').html(data);
}

function pool_coins_info_refresh()
{
    var url = "/site/coins_info";
    $.get(url, '', pool_coins_info_ready);
}

</script>

<script>
function getLastUpdated(){
    var stratum = document.getElementById('drop-stratum');
    var coin = document.getElementById('drop-coin');
    var solo = document.getElementById('drop-solo');
    var wallet = document.getElementById('text-wallet').value.trim();
    var rigName = document.getElementById('text-rig-name').value.trim();
    var result = '';

    var algo = coin.options[coin.selectedIndex].dataset.algo;
    var port = coin.options[coin.selectedIndex].dataset.port;
    var symbol = coin.options[coin.selectedIndex].dataset.symbol;
    var extra = coin.options[coin.selectedIndex].dataset.extra; // Already contains "-p c=MTBC,mc=MTBC" if needed

    result += algo + ' -o stratum+tcp://';
    result += stratum.value + '<?=YAAMP_STRATUM_URL?>:' + port + ' -u ';

    result += wallet ? wallet : 'WALLET_ADDRESS';
    result += rigName ? '.' + rigName : '.WORKER_NAME';

    result += ' ' + extra; // Removed second "-p"
    result += solo.value;  // Append solo mining option if selected

    return result;
}

function generate(){
    var result = getLastUpdated();
    document.getElementById('output').innerHTML = result;
}
generate();
</script>
